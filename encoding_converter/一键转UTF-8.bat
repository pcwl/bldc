@echo off
setlocal
set "UTF8_CONVERTER_SELF=%~f0"
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -Command "$raw = [System.IO.File]::ReadAllText($env:UTF8_CONVERTER_SELF, [System.Text.Encoding]::UTF8); $match = [regex]::Match($raw, '(?m)^# POWERSHELL_PAYLOAD\r?\n'); if (-not $match.Success) { throw 'Embedded converter payload was not found.' }; & ([scriptblock]::Create($raw.Substring($match.Index + $match.Length)))"
set "RESULT=%ERRORLEVEL%"
echo.
pause
exit /b %RESULT%
# POWERSHELL_PAYLOAD
param(
    [Parameter(Position = 0)]
    [string]$Path,

    [switch]$Recursive = $true,

    [string]$Extensions = ".txt,.csv,.tsv,.log,.ini,.conf,.md,.json,.xml,.html,.htm,.css,.js,.ts,.py,.c,.h,.cpp,.hpp,.java,.sql,.yaml,.yml,.properties,.sh,.bat"
)

$ErrorActionPreference = "Stop"

function Get-StrictEncoding {
    param([string]$Name)

    try {
        return [System.Text.Encoding]::GetEncoding(
            $Name,
            [System.Text.EncoderFallback]::ExceptionFallback,
            [System.Text.DecoderFallback]::ExceptionFallback
        )
    }
    catch [System.ArgumentException] {
        throw "Unknown or unsupported source encoding '$Name'. Try gb18030, gbk, big5, or shift_jis."
    }
}

function Get-SourceEncoding {
    param([byte[]]$Bytes)

    if ($Bytes.Length -ge 4 -and $Bytes[0] -eq 0xFF -and $Bytes[1] -eq 0xFE -and
        $Bytes[2] -eq 0x00 -and $Bytes[3] -eq 0x00) {
        return @{ Status = "Ready"; Encoding = Get-StrictEncoding "utf-32"; Offset = 4; Label = "UTF-32 LE BOM" }
    }
    if ($Bytes.Length -ge 4 -and $Bytes[0] -eq 0x00 -and $Bytes[1] -eq 0x00 -and
        $Bytes[2] -eq 0xFE -and $Bytes[3] -eq 0xFF) {
        return @{ Status = "Ready"; Encoding = Get-StrictEncoding "utf-32BE"; Offset = 4; Label = "UTF-32 BE BOM" }
    }
    if ($Bytes.Length -ge 3 -and $Bytes[0] -eq 0xEF -and $Bytes[1] -eq 0xBB -and
        $Bytes[2] -eq 0xBF) {
        return @{ Status = "Ready"; Encoding = Get-StrictEncoding "utf-8"; Offset = 3; Label = "UTF-8 BOM" }
    }
    if ($Bytes.Length -ge 2 -and $Bytes[0] -eq 0xFF -and $Bytes[1] -eq 0xFE) {
        return @{ Status = "Ready"; Encoding = Get-StrictEncoding "utf-16"; Offset = 2; Label = "UTF-16 LE BOM" }
    }
    if ($Bytes.Length -ge 2 -and $Bytes[0] -eq 0xFE -and $Bytes[1] -eq 0xFF) {
        return @{ Status = "Ready"; Encoding = Get-StrictEncoding "utf-16BE"; Offset = 2; Label = "UTF-16 BE BOM" }
    }

    $unicode = Find-UnmarkedUnicodeEncoding -Bytes $Bytes
    if ($null -ne $unicode) {
        return @{ Status = "Ready"; Encoding = $unicode.Encoding; Offset = 0; Label = $unicode.Label }
    }

    $utf8 = Get-StrictEncoding "utf-8"
    try {
        $null = $utf8.GetString($Bytes)
        return @{ Status = "Ready"; Encoding = $utf8; Offset = 0; Label = "UTF-8 (no BOM)" }
    }
    catch [System.Text.DecoderFallbackException] {
        $legacy = Find-LegacyEncoding -Bytes $Bytes
        if ($null -eq $legacy) {
            return @{
                Status = "Skipped"
                Message = "Encoding could not be identified with confidence; original file was not changed."
            }
        }
        return @{
            Status = "Ready"
            Encoding = $legacy.Encoding
            Offset = 0
            Label = $legacy.Label + " (auto-detected)"
        }
    }
}

function Find-UnmarkedUnicodeEncoding {
    param([byte[]]$Bytes)

    if ($Bytes.Length -lt 4) {
        return $null
    }

    $zeroCounts = @(0, 0, 0, 0)
    for ($index = 0; $index -lt $Bytes.Length; $index++) {
        if ($Bytes[$index] -eq 0) {
            $zeroCounts[$index % 4]++
        }
    }
    $groups = [math]::Floor($Bytes.Length / 4)
    if ($groups -gt 0 -and
        $zeroCounts[1] -ge ($groups * 0.75) -and
        $zeroCounts[2] -ge ($groups * 0.75) -and
        $zeroCounts[3] -ge ($groups * 0.75) -and
        $zeroCounts[0] -lt ($groups * 0.25)) {
        return @{ Encoding = Get-StrictEncoding "utf-32"; Label = "UTF-32 LE (no BOM, detected by byte pattern)" }
    }
    if ($groups -gt 0 -and
        $zeroCounts[0] -ge ($groups * 0.75) -and
        $zeroCounts[1] -ge ($groups * 0.75) -and
        $zeroCounts[2] -ge ($groups * 0.75) -and
        $zeroCounts[3] -lt ($groups * 0.25)) {
        return @{ Encoding = Get-StrictEncoding "utf-32BE"; Label = "UTF-32 BE (no BOM, detected by byte pattern)" }
    }

    if (($Bytes.Length % 2) -eq 0) {
        $evenZeroCount = 0
        $oddZeroCount = 0
        for ($index = 0; $index -lt $Bytes.Length; $index++) {
            if ($Bytes[$index] -eq 0) {
                if (($index % 2) -eq 0) {
                    $evenZeroCount++
                }
                else {
                    $oddZeroCount++
                }
            }
        }
        $pairs = $Bytes.Length / 2
        if ($oddZeroCount -ge ($pairs * 0.5) -and $evenZeroCount -lt ($pairs * 0.125)) {
            return @{ Encoding = Get-StrictEncoding "utf-16"; Label = "UTF-16 LE (no BOM, detected by byte pattern)" }
        }
        if ($evenZeroCount -ge ($pairs * 0.5) -and $oddZeroCount -lt ($pairs * 0.125)) {
            return @{ Encoding = Get-StrictEncoding "utf-16BE"; Label = "UTF-16 BE (no BOM, detected by byte pattern)" }
        }
    }
    return $null
}

function Find-LegacyEncoding {
    param([byte[]]$Bytes)

    $candidates = @()
    foreach ($name in @("gb18030", "big5", "shift_jis", "euc-jp")) {
        try {
            $encoding = Get-StrictEncoding $name
            $text = $encoding.GetString($Bytes)
            $kanaCount = [regex]::Matches($text, "[\u3040-\u30FF]").Count
            $simplifiedCount = [regex]::Matches($text, "[这来发后里国汉门东书车长为与云万复面台简体测转换编码]").Count
            $traditionalCount = [regex]::Matches($text, "[這來發後裡國漢門東書車長為與雲萬復麵臺繁體測試轉換編碼]").Count

            $score = 0
            $label = $name
            if ($name -eq "gb18030" -and $simplifiedCount -ge 2 -and $simplifiedCount -ge ($traditionalCount + 2)) {
                $score = $simplifiedCount - $traditionalCount
                $label = "GB18030/GBK"
            }
            elseif ($name -eq "big5" -and $traditionalCount -ge 2 -and $traditionalCount -ge ($simplifiedCount + 2)) {
                $score = $traditionalCount - $simplifiedCount
                $label = "Big5"
            }
            elseif (($name -eq "shift_jis" -or $name -eq "euc-jp") -and $kanaCount -ge 3) {
                $score = $kanaCount
                $label = $name
            }

            if ($score -gt 0) {
                $candidates += [PSCustomObject]@{
                    Encoding = $encoding
                    Label = $label
                    Score = $score
                    Text = $text
                }
            }
        }
        catch [System.Text.DecoderFallbackException] {
            continue
        }
        catch [System.ArgumentException] {
            continue
        }
    }

    if ($candidates.Count -eq 0) {
        return $null
    }
    $ranked = @($candidates | Sort-Object -Property Score -Descending)
    if ($ranked.Count -gt 1 -and $ranked[0].Score -lt ($ranked[1].Score + 2)) {
        return $null
    }
    return $ranked[0]
}

function Convert-TextFile {
    param([System.IO.FileInfo]$File)

    if (($File.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw "Symbolic links and reparse points are not converted."
    }

    $bytes = [System.IO.File]::ReadAllBytes($File.FullName)
    $source = Get-SourceEncoding -Bytes $bytes
    if ($source.Status -ne "Ready") {
        return @{ Status = $source.Status; Message = $source.Message }
    }
    try {
        $text = $source.Encoding.GetString($bytes, $source.Offset, $bytes.Length - $source.Offset)
    }
    catch [System.Text.DecoderFallbackException] {
        return @{ Status = "Skipped"; Message = "The file could not be decoded safely; original file was not changed." }
    }

    $utf8 = New-Object System.Text.UTF8Encoding($false, $true)
    $converted = $utf8.GetBytes($text)
    if ($bytes.Length -eq $converted.Length) {
        $identical = $true
        for ($index = 0; $index -lt $bytes.Length; $index++) {
            if ($bytes[$index] -ne $converted[$index]) {
                $identical = $false
                break
            }
        }
        if ($identical) {
            return @{ Status = "Unchanged"; Encoding = $source.Label }
        }
    }

    $temporaryName = ".utf8-convert-" + [Guid]::NewGuid().ToString("N")
    $temporaryPath = Join-Path $File.DirectoryName ($temporaryName + ".tmp")
    $backupPath = Join-Path $File.DirectoryName ($temporaryName + ".bak")
    try {
        [System.IO.File]::WriteAllBytes($temporaryPath, $converted)
        [System.IO.File]::Replace($temporaryPath, $File.FullName, $backupPath)
    }
    finally {
        if ([System.IO.File]::Exists($temporaryPath)) {
            [System.IO.File]::Delete($temporaryPath)
        }
        if ([System.IO.File]::Exists($backupPath)) {
            [System.IO.File]::Delete($backupPath)
        }
    }
    return @{ Status = "Converted"; Encoding = $source.Label }
}

function Get-TargetFiles {
    param(
        [string]$TargetPath,
        [switch]$IncludeSubdirectories,
        [string]$ExtensionList
    )

    if (-not (Test-Path -LiteralPath $TargetPath)) {
        throw "Path does not exist: $TargetPath"
    }

    $item = Get-Item -LiteralPath $TargetPath -Force
    if (($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw "Symbolic links and reparse points are not converted."
    }
    if (-not $item.PSIsContainer) {
        return ,$item
    }

    $allowedExtensions = @()
    $includeAll = $ExtensionList.Trim().ToLowerInvariant() -eq "all"
    if (-not $includeAll) {
        $allowedExtensions = @($ExtensionList -split "," | ForEach-Object {
            $extension = $_.Trim().ToLowerInvariant()
            if ($extension -and -not $extension.StartsWith(".")) {
                $extension = "." + $extension
            }
            $extension
        } | Where-Object { $_ })
        if ($allowedExtensions.Count -eq 0) {
            throw "Specify one or more extensions (for example, .txt,.csv) or 'all'."
        }
    }

    $items = if ($IncludeSubdirectories) {
        Get-ChildItem -LiteralPath $item.FullName -File -Force -Recurse
    }
    else {
        Get-ChildItem -LiteralPath $item.FullName -File -Force
    }

    return @($items | Where-Object {
        ($_.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -eq 0 -and
        ($includeAll -or $allowedExtensions -contains $_.Extension.ToLowerInvariant())
    } | Sort-Object -Property FullName)
}

if ([string]::IsNullOrWhiteSpace($Path)) {
    try {
        Add-Type -AssemblyName System.Windows.Forms
        $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
        $dialog.Description = "Select a folder of text files to convert to UTF-8"
        $dialog.ShowNewFolderButton = $false
        if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
            Write-Output "Cancelled. No files were changed."
            exit 0
        }
        $Path = $dialog.SelectedPath
    }
    catch {
        Write-Error "Could not open the folder picker: $($_.Exception.Message)"
        exit 1
    }
}
if ([string]::IsNullOrWhiteSpace($Path)) {
    Write-Output "Cancelled. No files were changed."
    exit 0
}

try {
    $files = @(Get-TargetFiles -TargetPath $Path -IncludeSubdirectories:$Recursive -ExtensionList $Extensions)
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}

if ($files.Count -eq 0) {
    Write-Output "No matching files found."
    exit 0
}

$convertedCount = 0
$unchangedCount = 0
$skippedCount = 0
$failedCount = 0
foreach ($file in $files) {
    try {
        $result = Convert-TextFile -File $file
        if ($result.Status -eq "Converted") {
            $convertedCount++
            Write-Output "[CONVERTED] $($file.FullName) ($($result.Encoding) -> UTF-8)"
        }
        elseif ($result.Status -eq "Unchanged") {
            $unchangedCount++
            Write-Output "[UNCHANGED] $($file.FullName) ($($result.Encoding))"
        }
        else {
            $skippedCount++
            Write-Output "[SKIPPED] $($file.FullName): $($result.Message)"
        }
    }
    catch {
        $failedCount++
        [Console]::Error.WriteLine("[FAILED] {0}: {1}", $file.FullName, $_.Exception.Message)
    }
}

Write-Output "Report: $convertedCount converted, $unchangedCount already UTF-8, $skippedCount skipped (unidentified/unsafe), $failedCount errors."
if ($failedCount -gt 0 -or $skippedCount -gt 0) {
    exit 1
}
exit 0
