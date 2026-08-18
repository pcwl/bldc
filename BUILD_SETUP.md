# VESC 固件编译环境设置

## 环境状态

✅ **编译环境已成功搭建**

### 已安装组件

| 组件 | 版本 | 位置 |
|------|------|------|
| ARM GNU Toolchain | 14.3.Rel1 | `tools/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-eabi/` |
| GNU Make | - | `/usr/bin/make` |
| git | - | `/usr/bin/git` |
| wget | - | `/usr/bin/wget` |

## 快速开始

### 方法 1：使用环境设置脚本（推荐）

```bash
# 加载构建环境
source ./build_env.sh

# 编译固件
make example          # 编译示例固件
make 100_250          # 编译 VESC 100/250
make all_fw           # 编译所有目标
```

### 方法 2：手动设置 PATH

```bash
export PATH="/workspaces/bldc/tools/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-eabi/bin:$PATH"
make <board_name>
```

## 验证编译环境

查看可用的目标板：

```bash
make
```

输出将显示所有支持的目标板，包括：
- `100_250`, `100_250_mkiii` - VESC 100/250 系列
- `60_mk6`, `60_mk6_hp` - VESC 60 系列
- `75_300`, `75_300_mkiv` - VESC 75/300 系列
- 以及 200+ 其他目标板

## 硬件列表

本项目支持 **300+ 种硬件目标板**，包括：
- 40+ VESC 官方系列
- 260+ 第三方品牌（Flipsky、Storm Core、MKSesc、Luna、Maytech 等）

**📋 详细硬件列表**：查看 [SUPPORTED_BOARDS.md](SUPPORTED_BOARDS.md)  
**🚀 快速查找常用硬件**：查看 [QUICK_REFERENCE.md](QUICK_REFERENCE.md)

常见硬件快速编译：
```bash
# 查看完整列表
make

# 常用示例
make 100_250          # VESC 100/250
make 60_mk6           # VESC 60 MK6
make flipsky_75       # Flipsky 75A
make stormcore_100d   # Storm Core 100D
make luna_m600        # Luna M600
make Little_FOCer_V4  # Little FOCer
```

## 构建命令

### 编译特定固件

```bash
# 编译示例固件（已验证）
make example

# 编译特定硬件
make 100_250
make 60_mk6
make flipsky_75

# 查看编译进度（详细日志）
make V=1 100_250
```

### 编译所有固件

```bash
make all_fw
```

### 清理构建

```bash
make fw_example_clean
make fw_100_250_clean
```

### 编译输出

编译成功后，输出文件位于：`build/<board_name>/`

常见的输出文件：
- `*.bin` - 二进制固件文件（用于烧录）
- `*.hex` - Intel HEX 格式
- `*.elf` - ELF 可执行文件
- `*.map` - 链接器映射文件
- `*.list` - 反汇编列表

## 编译测试结果

✅ 已成功编译示例固件：

```
编译目标：example
编译结果：成功
输出大小：
  text:    451348 B
  data:      2820 B
  bss:     173392 B
  总计:    627560 B (99.368 KB)
```

## 高级编译选项

### 自定义硬件配置

```bash
HW_SRC=<path> HW_HEADER=<header> make fw_custom
```

### 编译所有测试

```bash
make all_ut              # 编译所有单元测试
make all_ut_run          # 编译并运行所有测试
make all_ut_xml          # 编译并生成 XML 报告
```

## 烧录固件

### 使用 ST-Link SWD 调试器

```bash
make fw_100_250_flash    # 自动检测设备并烧录
```

需要预先安装 OpenOCD：
```bash
# Ubuntu/Debian
sudo apt install openocd

# macOS
brew install openocd
```

## 常见问题

### Q: 如何解决"arm-none-eabi-gcc: No such file or directory"错误？

A: 需要设置正确的 PATH：
```bash
source ./build_env.sh
# 或手动设置
export PATH="/workspaces/bldc/tools/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-eabi/bin:$PATH"
```

### Q: 如何查看支持的所有目标板？

A: 运行 `make` 命令，输出将列出所有支持的 200+ 目标板。

### Q: 编译时出现内存不足错误？

A: 可以限制并行编译数：
```bash
make -j2 100_250  # 使用 2 个线程而不是默认的全部
```

## 更多信息

- 项目主页：https://vesc-project.com/
- GitHub 仓库：https://github.com/vedderb/bldc
- 支持的硬件配置：查看 `hwconf/` 目录

## 环境路径信息

```
项目根目录：/workspaces/bldc/
构建输出：/workspaces/bldc/build/
工具链：/workspaces/bldc/tools/
下载缓存：/workspaces/bldc/downloads/
```

---

设置时间：2026-08-18
状态：✅ 就绪可用
