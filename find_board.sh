#!/bin/bash
# VESC 硬件目标查询脚本
# 使用: ./find_board.sh [搜索关键词]

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 所有支持的硬件目标
BOARDS=(
    "100_250" "100_250_mkiii" "100_250_mkiii_no_limits" "100_250_no_limits"
    "100_500" "100_500_no_limits" "140_300"
    "40" "410" "410_0005ohm" "410_005ohm" "410_no_limits" "45" "46"
    "46_0005ohm" "46_33k" "48" "49"
    "60" "60_75" "60_75_mk2" "60_75_mk2_no_limits" "60_75_no_limits"
    "60_mk3" "60_mk3_no_limits" "60_mk4" "60_mk4_no_limits"
    "60_mk5" "60_mk5_no_limits" "60_mk6" "60_mk6_hp"
    "60_mk6_hp_no_limits" "60_mk6_max" "60_mk6_no_limits" "60_no_limits"
    "60v2_alva" "60v2_alva_mk1" "60v2_alva_mk2"
    "75_100" "75_100_V2" "75_100_V2_0005ohm" "75_100_V2_005ohm"
    "75_100_V2_no_limits" "75_100_no_limits"
    "75_300" "75_300_mkiv" "75_300_mkiv_no_limits" "75_300_no_limits"
    "75_300_r2" "75_300_r2_no_limits" "75_300_r3" "75_300_r3_no_limits"
    "75_600" "75_600_no_limits"
    "Cheap_FOCer_2" "Cheap_FOCer_2_V09" "Cheap_FOCer_2_V09_no_limits"
    "Cheap_FOCer_2_no_limits"
    "ENNOID_150V_mk8"
    "FOCSTrot_V3" "FOCSTrot_V4"
    "JetFleetF6_20s" "JetFleetF6_24s" "JetFleetF6_32s"
    "Lightning400"
    "Little_FOCer" "Little_FOCer_V3" "Little_FOCer_V3_1" "Little_FOCer_V4"
    "RSR_DD_V1" "RSR_DD_V1_005" "RSR_DD_V2" "RSR_DD_V2.1"
    "TRONIC_250R"
    "Thor300_20s" "Thor301" "Thor400" "Thor400v2"
    "a100s_v4" "a200s_v2.1" "a200s_v2.2" "a200s_v3" "a200s_v4" "a200s_v41"
    "a50s_dual_12s" "a50s_dual_8s"
    "a50s_v22_12s" "a50s_v22_12s_hg" "a50s_v22_6s" "a50s_v22_6s_hg"
    "a50s_v23_12s" "a50s_v23_20s" "a50s_v23_6s" "a50s_v23_8s"
    "a50s_v23c_12s" "a50s_v23c_8s"
    "adv200" "adv500" "axiom"
    "basic" "basic_025" "basic_035" "basic_035_no_limits"
    "classic" "classic_no_limits" "classicp" "classicp_no_limits"
    "duet" "duet_no_limits" "duet_xs100" "duet_xs100_no_limits"
    "duet_xs60" "duet_xs60_no_limits"
    "edu" "edu_no_limits" "example"
    "flipsky_110_100" "flipsky_110_100_no_limits"
    "flipsky_110_200" "flipsky_110_200_no_limits"
    "flipsky_110_300" "flipsky_110_300_no_limits"
    "flipsky_110_400" "flipsky_110_400_no_limits"
    "flipsky_412" "flipsky_412_no_limits"
    "flipsky_60" "flipsky_60_mk5" "flipsky_60_mk5_no_limits" "flipsky_60_no_limits"
    "flipsky_75" "flipsky_75_450" "flipsky_75_450_no_limits" "flipsky_75_no_limits"
    "fsesc_75_200_alu" "fsesc_75_200_alu_no_limits" "fsesc_75_300"
    "gesc" "go_foc_dv6_pro" "go_foc_dv6_pro_no_limits" "go_foc_g300"
    "go_foc_g300_no_limits" "go_foc_hi200" "go_foc_hi200_no_limits"
    "go_foc_hv200" "go_foc_hv200_no_limits" "go_foc_m100" "go_foc_m100_no_limits"
    "gp" "hd60" "hd60_no_limits" "hd75" "hd75_no_limits"
    "itr_x1" "ka160"
    "km_75_100" "km_75_100_0005ohm" "km_75_100_no_limits"
    "km_75_300" "km_75_300_no_limits"
    "luna_bbshd" "luna_m600" "luna_m600_Rev5" "luna_m600_Rev5_60V"
    "maxim_120" "maxim_120_no_limits" "maxim_120_ph" "maxim_120_ph_no_limits"
    "maxim_150" "maxim_150_no_limits" "maxim_150_ph" "maxim_150_ph_no_limits"
    "maximp_120" "maximp_120_no_limits" "maximp_120_ph" "maximp_120_ph_no_limits"
    "maximp_150" "maximp_150_no_limits" "maximp_150_ph" "maximp_150_ph_no_limits"
    "mbot" "minim" "minim_no_limits" "minim_w60"
    "mksesc_100_300_hp" "mksesc_100_300_hp_no_limits"
    "mksesc_75_100_old" "mksesc_75_100_old_no_limits"
    "mksesc_75_100_v2" "mksesc_75_100_v2_no_limits"
    "mksesc_75_100_v2_old" "mksesc_75_100_v2_old_no_limits"
    "mksesc_75_200_v2" "mksesc_75_200_v2_no_limits"
    "mksesc_75_200_v2_old" "mksesc_75_200_v2_old_no_limits"
    "mksesc_84_100_hp" "mksesc_84_100_hp_no_limits"
    "mksesc_84_200_hp" "mksesc_84_200_hp_no_limits"
    "pronto" "pronto_no_limits"
    "r2" "raiden7" "rb"
    "solo" "solo_no_limits" "sparkf" "spesc"
    "stormcore_100d" "stormcore_100d_no_limits" "stormcore_100d_parallel"
    "stormcore_100d_v2" "stormcore_100d_v2_no_limits"
    "stormcore_100dx" "stormcore_100dx_no_limits" "stormcore_100dx_parallel"
    "stormcore_100s" "stormcore_100s_no_limits"
    "stormcore_60d" "stormcore_60d+" "stormcore_60d+_no_limits" "stormcore_60d_no_limits"
    "stormcore_60dxs" "stormcore_60dxs_no_limits"
    "str365" "str365_150" "str365_150_no_limits" "str365_no_limits"
    "str500" "str500_01" "str500_hp" "str500_hp_no_limits" "str500_no_limits"
    "ubox_126_100" "ubox_126_100_no_limits" "ubox_126_160" "ubox_126_160_no_limits"
    "ubox_single_100" "ubox_single_100_no_limits"
    "ubox_single_75" "ubox_single_75_no_limits"
    "ubox_single_80" "ubox_single_80_no_limits"
    "ubox_single_85_200" "ubox_single_85_200_no_limits"
    "ubox_v1_75_micro" "ubox_v1_75_micro_no_limits"
    "ubox_v1_75_typec" "ubox_v1_75_typec_no_limits"
    "ubox_v2_100" "ubox_v2_100_no_limits" "ubox_v2_75" "ubox_v2_75_no_limits"
    "unity" "unity_no_limits"
    "warrior6"
    "x12_pro24" "x12_pro30"
)

# 显示帮助信息
show_help() {
    cat << EOF
VESC 硬件目标查询工具

用法: ./find_board.sh [搜索关键词]

示例:
  ./find_board.sh flipsky          # 查找 Flipsky 相关硬件
  ./find_board.sh 100_              # 查找 100A 相关硬件
  ./find_board.sh luna              # 查找 Luna 相关硬件
  ./find_board.sh "no_limits"       # 查找无限制版本
  ./find_board.sh                   # 列出所有硬件

常用搜索:
  ./find_board.sh vesc              # 查找 VESC 官方硬件
  ./find_board.sh stormcore         # 查找 Storm Core 硬件
  ./find_board.sh mayth             # 查找 Maytech 硬件
  ./find_board.sh mkesc             # 查找 MKSesc 硬件
  ./find_board.sh 75_               # 查找 75A 系列
  ./find_board.sh 100_              # 查找 100A 系列

EOF
}

# 如果没有参数，显示帮助并列出所有硬件
if [[ $# -eq 0 ]]; then
    echo "VESC 硬件目标列表 (共 ${#BOARDS[@]} 个硬件)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # 按字母顺序列出
    printf '%s\n' "${BOARDS[@]}" | sort | column
    
    echo ""
    echo "💡 使用 './find_board.sh <关键词>' 快速查找硬件"
    echo ""
    show_help
    exit 0
fi

# 处理搜索关键词
KEYWORD="$1"
FOUND=0
MATCHES=()

echo "🔍 搜索: '$KEYWORD'"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 转换为小写进行搜索（但保留原始大小写）
KEYWORD_LOWER=$(echo "$KEYWORD" | tr '[:upper:]' '[:lower:]')

for board in "${BOARDS[@]}"; do
    BOARD_LOWER=$(echo "$board" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$BOARD_LOWER" == *"$KEYWORD_LOWER"* ]]; then
        MATCHES+=("$board")
        FOUND=$((FOUND + 1))
    fi
done

if [[ $FOUND -eq 0 ]]; then
    echo "❌ 未找到匹配的硬件"
    echo ""
    echo "💡 提示:"
    echo "  - 尝试更短的关键词"
    echo "  - 检查拼写"
    echo "  - 查看 SUPPORTED_BOARDS.md 获取完整列表"
    exit 1
fi

echo "✅ 找到 $FOUND 个匹配的硬件:"
echo ""

# 显示搜索结果并提供编译命令
printf '%s\n' "${MATCHES[@]}" | sort | nl -w2 -s'. '

echo ""
echo "编译命令:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ $FOUND -eq 1 ]]; then
    BOARD="${MATCHES[0]}"
    echo "source ./build_env.sh && make $BOARD"
    echo ""
    echo "📁 输出文件会在: build/$BOARD/"
    echo ""
    echo "编译已选择的硬件:"
    echo "  make $BOARD"
    echo ""
    echo "清理编译输出:"
    echo "  make ${BOARD}_clean"
    echo ""
    echo "烧录到硬件（需要 OpenOCD 和 ST-Link）:"
    echo "  make ${BOARD}_flash"
else
    echo "source ./build_env.sh"
    echo ""
    echo "然后选择要编译的硬件，例如："
    echo "  make ${MATCHES[0]}"
    if [[ $FOUND -gt 1 ]]; then
        echo "  make ${MATCHES[1]}"
        if [[ $FOUND -gt 2 ]]; then
            echo "  # ... 或者其他 $(($FOUND - 2)) 个硬件"
        fi
    fi
fi

echo ""
