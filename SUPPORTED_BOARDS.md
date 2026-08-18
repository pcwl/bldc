# VESC 支持的硬件目标板清单

本文档按硬件厂商和系列组织了所有支持的编译目标。

## 🔧 如何使用

选择下面的任何目标板名称，使用以下命令编译：

```bash
source ./build_env.sh
make <board_name>          # 编译固件
make <board_name>_clean    # 清理构建
make <board_name>_flash    # 烧录到硬件（需要 OpenOCD + ST-Link）
```

例如：
```bash
make 100_250               # 编译 VESC 100/250
make flipsky_75            # 编译 Flipsky 75A
make stormcore_100d        # 编译 Storm Core 100D
```

---

## 📋 硬件列表（按品牌分类）

### VESC 官方硬件

#### VESC 100/250 系列 (100A / 250A)
- `100_250` - 标准版
- `100_250_mkiii` - MK III 版本
- `100_250_mkiii_no_limits` - MK III 版本（无限制）
- `100_250_no_limits` - 标准版（无限制）

#### VESC 100/500 系列 (100A / 500A)
- `100_500` - 标准版
- `100_500_no_limits` - 无限制版本

#### VESC 75/100 系列 (75A / 100A)
- `75_100` - 标准版
- `75_100_V2` - V2 版本
- `75_100_V2_0005ohm` - V2 版本（0.5mΩ）
- `75_100_V2_005ohm` - V2 版本（0.5mΩ）
- `75_100_V2_no_limits` - V2 版本（无限制）
- `75_100_no_limits` - 标准版（无限制）

#### VESC 75/300 系列 (75A / 300A)
- `75_300` - 标准版
- `75_300_mkiv` - MK IV 版本
- `75_300_mkiv_no_limits` - MK IV 版本（无限制）
- `75_300_no_limits` - 标准版（无限制）
- `75_300_r2` - R2 版本
- `75_300_r2_no_limits` - R2 版本（无限制）
- `75_300_r3` - R3 版本
- `75_300_r3_no_limits` - R3 版本（无限制）

#### VESC 75/600 系列 (75A / 600A)
- `75_600` - 标准版
- `75_600_no_limits` - 无限制版本

#### VESC 60 系列 (60A)
- `60` - 基础版
- `60_mk3` - MK3 版本
- `60_mk3_no_limits` - MK3 版本（无限制）
- `60_mk4` - MK4 版本
- `60_mk4_no_limits` - MK4 版本（无限制）
- `60_mk5` - MK5 版本
- `60_mk5_no_limits` - MK5 版本（无限制）
- `60_mk6` - MK6 版本
- `60_mk6_hp` - MK6 HP（高功率）版本
- `60_mk6_hp_no_limits` - MK6 HP（无限制）
- `60_mk6_max` - MK6 MAX 版本
- `60_mk6_no_limits` - MK6 版本（无限制）
- `60_no_limits` - 基础版（无限制）

#### VESC 60/75 系列 (60A / 75A)
- `60_75` - 标准版
- `60_75_mk2` - MK2 版本
- `60_75_mk2_no_limits` - MK2 版本（无限制）
- `60_75_no_limits` - 标准版（无限制）

#### VESC Alva 系列 (60V2)
- `60v2_alva` - 标准版
- `60v2_alva_mk1` - MK1 版本
- `60v2_alva_mk2` - MK2 版本

#### VESC 140/300 系列
- `140_300` - 标准版

#### VESC 小型系列
- `40` - 40A 版本
- `45` - 45A 版本
- `46` - 46A 版本
- `46_0005ohm` - 46A（0.5mΩ）
- `46_33k` - 46A（33k）
- `48` - 48A 版本
- `49` - 49A 版本

#### VESC 410 系列 (40A / 10S / 60V)
- `410` - 标准版
- `410_0005ohm` - 0.5mΩ 版本
- `410_005ohm` - 0.5mΩ 版本
- `410_no_limits` - 无限制版本

---

### 第三方品牌

#### Cheap FOCer (廉价 FOC 控制器)
- `Cheap_FOCer_2` - V2 标准版
- `Cheap_FOCer_2_V09` - V2 V0.9 版本
- `Cheap_FOCer_2_V09_no_limits` - V2 V0.9（无限制）
- `Cheap_FOCer_2_no_limits` - V2（无限制）

#### Little FOCer (迷你 FOC)
- `Little_FOCer` - 基础版
- `Little_FOCer_V3` - V3 版本
- `Little_FOCer_V3_1` - V3.1 版本
- `Little_FOCer_V4` - V4 版本

#### Flipsky (飞天狐)
- `flipsky_60` - 60A 版本
- `flipsky_60_mk5` - 60A MK5 版本
- `flipsky_60_mk5_no_limits` - 60A MK5（无限制）
- `flipsky_60_no_limits` - 60A（无限制）
- `flipsky_75` - 75A 版本
- `flipsky_75_450` - 75A 450A 版本
- `flipsky_75_450_no_limits` - 75A 450A（无限制）
- `flipsky_75_no_limits` - 75A（无限制）
- `flipsky_110_100` - 110A 100A 版本
- `flipsky_110_100_no_limits` - 110A 100A（无限制）
- `flipsky_110_200` - 110A 200A 版本
- `flipsky_110_200_no_limits` - 110A 200A（无限制）
- `flipsky_110_300` - 110A 300A 版本
- `flipsky_110_300_no_limits` - 110A 300A（无限制）
- `flipsky_110_400` - 110A 400A 版本
- `flipsky_110_400_no_limits` - 110A 400A（无限制）
- `flipsky_412` - 4S 12A 版本
- `flipsky_412_no_limits` - 4S 12A（无限制）

#### Storm Core (风暴核心)
- `stormcore_60d` - 60D 标准版
- `stormcore_60d+` - 60D+ 版本
- `stormcore_60d+_no_limits` - 60D+（无限制）
- `stormcore_60d_no_limits` - 60D（无限制）
- `stormcore_60dxs` - 60DXS 版本
- `stormcore_60dxs_no_limits` - 60DXS（无限制）
- `stormcore_100d` - 100D 标准版
- `stormcore_100d_no_limits` - 100D（无限制）
- `stormcore_100d_parallel` - 100D 并联版本
- `stormcore_100d_v2` - 100D V2 版本
- `stormcore_100d_v2_no_limits` - 100D V2（无限制）
- `stormcore_100dx` - 100DX 版本
- `stormcore_100dx_no_limits` - 100DX（无限制）
- `stormcore_100dx_parallel` - 100DX 并联版本
- `stormcore_100s` - 100S 版本
- `stormcore_100s_no_limits` - 100S（无限制）

#### MKSesc (Makerbase)
- `mksesc_75_100_old` - 75A/100A 老版本
- `mksesc_75_100_old_no_limits` - 75A/100A 老版本（无限制）
- `mksesc_75_100_v2` - 75A/100A V2 版本
- `mksesc_75_100_v2_no_limits` - 75A/100A V2（无限制）
- `mksesc_75_100_v2_old` - 75A/100A V2 老版本
- `mksesc_75_100_v2_old_no_limits` - 75A/100A V2 老版本（无限制）
- `mksesc_75_200_v2` - 75A/200A V2 版本
- `mksesc_75_200_v2_no_limits` - 75A/200A V2（无限制）
- `mksesc_75_200_v2_old` - 75A/200A V2 老版本
- `mksesc_75_200_v2_old_no_limits` - 75A/200A V2 老版本（无限制）
- `mksesc_84_100_hp` - 84A/100A HP 版本
- `mksesc_84_100_hp_no_limits` - 84A/100A HP（无限制）
- `mksesc_84_200_hp` - 84A/200A HP 版本
- `mksesc_84_200_hp_no_limits` - 84A/200A HP（无限制）
- `mksesc_100_300_hp` - 100A/300A HP 版本
- `mksesc_100_300_hp_no_limits` - 100A/300A HP（无限制）

#### Luna (Grin Technologies)
- `luna_bbshd` - BBSHD 电机集成版本
- `luna_m600` - M600 标准版本
- `luna_m600_Rev5` - M600 Rev5 版本
- `luna_m600_Rev5_60V` - M600 Rev5 60V 版本

#### FOCSTrot
- `FOCSTrot_V3` - V3 版本
- `FOCSTrot_V4` - V4 版本

#### Trampa (Trampa)
- `TRONIC_250R` - TRONIC 250R 版本
- `TRONIC` - 基础版

#### Thunder (Thunder ESC)
- `Thor300_20s` - Thor300 20S 版本
- `Thor301` - Thor301 版本
- `Thor400` - Thor400 标准版
- `Thor400v2` - Thor400 V2 版本

#### STR 系列
- `str365` - STR365 标准版
- `str365_150` - STR365 150A 版本
- `str365_150_no_limits` - STR365 150A（无限制）
- `str365_no_limits` - STR365（无限制）
- `str500` - STR500 标准版
- `str500_01` - STR500 0.1 版本
- `str500_hp` - STR500 HP（高功率）版本
- `str500_hp_no_limits` - STR500 HP（无限制）
- `str500_no_limits` - STR500（无限制）

#### Maytech (Maytech)
- `maxim_120` - Maxim 120A 标准版
- `maxim_120_no_limits` - Maxim 120A（无限制）
- `maxim_120_ph` - Maxim 120A PH 版本
- `maxim_120_ph_no_limits` - Maxim 120A PH（无限制）
- `maxim_150` - Maxim 150A 标准版
- `maxim_150_no_limits` - Maxim 150A（无限制）
- `maxim_150_ph` - Maxim 150A PH 版本
- `maxim_150_ph_no_limits` - Maxim 150A PH（无限制）
- `maximp_120` - Maximp 120A 标准版
- `maximp_120_no_limits` - Maximp 120A（无限制）
- `maximp_120_ph` - Maximp 120A PH 版本
- `maximp_120_ph_no_limits` - Maximp 120A PH（无限制）
- `maximp_150` - Maximp 150A 标准版
- `maximp_150_no_limits` - Maximp 150A（无限制）
- `maximp_150_ph` - Maximp 150A PH 版本
- `maximp_150_ph_no_limits` - Maximp 150A PH（无限制）

#### Ubox 系列
- `ubox_single_75` - 单驱 75A 版本
- `ubox_single_75_no_limits` - 单驱 75A（无限制）
- `ubox_single_80` - 单驱 80A 版本
- `ubox_single_80_no_limits` - 单驱 80A（无限制）
- `ubox_single_100` - 单驱 100A 版本
- `ubox_single_100_no_limits` - 单驱 100A（无限制）
- `ubox_single_85_200` - 单驱 85A/200A 版本
- `ubox_single_85_200_no_limits` - 单驱 85A/200A（无限制）
- `ubox_v1_75_micro` - V1 75A 微版本
- `ubox_v1_75_micro_no_limits` - V1 75A 微版本（无限制）
- `ubox_v1_75_typec` - V1 75A TypeC 版本
- `ubox_v1_75_typec_no_limits` - V1 75A TypeC（无限制）
- `ubox_v2_75` - V2 75A 版本
- `ubox_v2_75_no_limits` - V2 75A（无限制）
- `ubox_v2_100` - V2 100A 版本
- `ubox_v2_100_no_limits` - V2 100A（无限制）
- `ubox_126_100` - 126S 100A 版本
- `ubox_126_100_no_limits` - 126S 100A（无限制）
- `ubox_126_160` - 126S 160A 版本
- `ubox_126_160_no_limits` - 126S 160A（无限制）

#### ENNOID
- `ENNOID_150V_mk8` - 150V MK8 版本

#### Unity (Grin Technologies)
- `unity` - 标准版
- `unity_no_limits` - 无限制版本

#### Duet (Grin Technologies)
- `duet` - 标准版
- `duet_no_limits` - 无限制版本
- `duet_xs60` - XS60 版本
- `duet_xs60_no_limits` - XS60（无限制）
- `duet_xs100` - XS100 版本
- `duet_xs100_no_limits` - XS100（无限制）

#### JetFleet (Jet Fleet)
- `JetFleetF6_20s` - F6 20S 版本
- `JetFleetF6_24s` - F6 24S 版本
- `JetFleetF6_32s` - F6 32S 版本

#### FOCS Trot
- `FOCSTrot_V3` - V3 版本
- `FOCSTrot_V4` - V4 版本

#### Go FOC
- `go_foc_dv6_pro` - DV6 Pro 版本
- `go_foc_dv6_pro_no_limits` - DV6 Pro（无限制）
- `go_foc_g300` - G300 版本
- `go_foc_g300_no_limits` - G300（无限制）
- `go_foc_hi200` - HI200 版本
- `go_foc_hi200_no_limits` - HI200（无限制）
- `go_foc_hv200` - HV200 版本
- `go_foc_hv200_no_limits` - HV200（无限制）
- `go_foc_m100` - M100 版本
- `go_foc_m100_no_limits` - M100（无限制）

#### Avescado (AVEScado)
- `a50s_v22_6s` - A50S V22 6S 版本
- `a50s_v22_6s_hg` - A50S V22 6S HG 版本
- `a50s_v22_12s` - A50S V22 12S 版本
- `a50s_v22_12s_hg` - A50S V22 12S HG 版本
- `a50s_v23_6s` - A50S V23 6S 版本
- `a50s_v23_8s` - A50S V23 8S 版本
- `a50s_v23_12s` - A50S V23 12S 版本
- `a50s_v23_20s` - A50S V23 20S 版本
- `a50s_v23c_8s` - A50S V23C 8S 版本
- `a50s_v23c_12s` - A50S V23C 12S 版本
- `a50s_dual_8s` - A50S 双驱 8S 版本
- `a50s_dual_12s` - A50S 双驱 12S 版本
- `a100s_v4` - A100S V4 版本
- `a200s_v2.1` - A200S V2.1 版本
- `a200s_v2.2` - A200S V2.2 版本
- `a200s_v3` - A200S V3 版本
- `a200s_v4` - A200S V4 版本
- `a200s_v41` - A200S V4.1 版本

#### FSESC
- `fsesc_75_200_alu` - 75A/200A 铝版
- `fsesc_75_200_alu_no_limits` - 75A/200A 铝版（无限制）
- `fsesc_75_300` - 75A/300A 版本

#### HD（High Density）
- `hd60` - HD60 版本
- `hd60_no_limits` - HD60（无限制）
- `hd75` - HD75 版本
- `hd75_no_limits` - HD75（无限制）

#### KM 系列
- `km_75_100` - KM 75A/100A 版本
- `km_75_100_0005ohm` - KM 75A/100A（0.5mΩ）
- `km_75_100_no_limits` - KM 75A/100A（无限制）
- `km_75_300` - KM 75A/300A 版本
- `km_75_300_no_limits` - KM 75A/300A（无限制）

#### Raiden
- `raiden7` - Raiden7 版本

#### RSR
- `RSR_DD_V1` - RS RS 直驱 V1 版本
- `RSR_DD_V1_005` - RS RS 直驱 V1（0.5mΩ）
- `RSR_DD_V2` - RS RS 直驱 V2 版本
- `RSR_DD_V2.1` - RS RS 直驱 V2.1 版本

#### Lightning
- `Lightning400` - Lightning 400 版本

#### Advance (Advanced)
- `adv200` - ADV200 版本
- `adv500` - ADV500 版本

#### Classic (Classic ESC)
- `classic` - 标准版
- `classic_no_limits` - 无限制版本
- `classicp` - Classic Plus 版本
- `classicp_no_limits` - Classic Plus（无限制）

#### Basic (基础版)
- `basic` - 基础版
- `basic_025` - 基础版 0.25
- `basic_035` - 基础版 0.35
- `basic_035_no_limits` - 基础版 0.35（无限制）

#### 其他品牌
- `axiom` - Axiom 版本
- `edu` - 教育版
- `edu_no_limits` - 教育版（无限制）
- `example` - 示例/演示版本
- `gesc` - GESC 版本
- `gp` - GP 通用版本
- `itr_x1` - ITR X1 版本
- `ka160` - KA160 版本
- `mbot` - MBot 版本
- `minim` - Minim 版本
- `minim_no_limits` - Minim（无限制）
- `minim_w60` - Minim W60 版本
- `pronto` - Pronto 版本
- `pronto_no_limits` - Pronto（无限制）
- `r2` - R2 版本
- `rb` - RB 版本
- `solo` - Solo 版本
- `solo_no_limits` - Solo（无限制）
- `sparkf` - Sparkf 版本
- `spesc` - SPESC 版本
- `warrior6` - Warrior6 版本
- `x12_pro24` - X12 Pro 24S 版本
- `x12_pro30` - X12 Pro 30S 版本

---

## 📊 统计信息

- **总目标板数**: 300+
- **官方 VESC 系列**: 40+ 种型号
- **第三方品牌**: 260+ 种型号
- **"无限制"版本**: 许多硬件都有无限制功率版本可选

## 🎯 如何选择

### 按性能分类

**低功率** (< 100A):
`40`, `45`, `46`, `48`, `49`, `60`, `410`, `flipsky_412`, 等

**中功率** (100A - 300A):
`100_250`, `100_500`, `75_100`, `75_300`, `mksesc_84_100_hp`, 等

**高功率** (> 300A):
`75_600`, `mksesc_100_300_hp`, `stormcore_100d_v2`, 等

### 按应用场景

**滑板/滑冰**:
`Cheap_FOCer`, `Little_FOCer`, `Thunder`, `Luna`, `Unity`, `Duet`

**E-Bike**:
`Luna BBSHD`, `Luna M600`, `Flipsky`, `Maytech Maxim`

**高性能应用**:
`Storm Core`, `VESC 75/600`, `VESC 100/500`, `ENNOID 150V`

**预算友好型**:
`Cheap_FOCer_2`, `Basic`, `Classic`, `Flipsky 60`

---

## ✅ 编译示例

```bash
# 加载环境
source ./build_env.sh

# 编译不同类型
make 100_250           # 官方高性能
make flipsky_75        # 第三方中等功率
make stormcore_100d    # 最新高性能型号
make luna_m600         # E-Bike 应用
make basic             # 基础版本

# 编译所有
make all_fw            # 编译所有 300+ 目标（需要较长时间）

# 查看具体构建日志
make V=1 100_250       # 详细日志输出
```

---

**最后更新**: 2026-08-18
**编译环境**: ARM GNU Toolchain 14.3.Rel1
