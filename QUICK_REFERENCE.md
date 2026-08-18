# VESC 硬件快速参考卡片

## 🚀 常用硬件快速查找

### VESC 官方系列（推荐）

| 型号 | 电流 | 电压 | 编译命令 | 应用场景 |
|------|------|------|---------|---------|
| **VESC 60** | 60A | 低 | `make 60_mk6` | 轻量应用 |
| **VESC 75/100** | 75A/100A | 中 | `make 75_100_V2` | 通用应用 |
| **VESC 75/300** | 75A/300A | 高 | `make 75_300_mkiv` | 高性能 |
| **VESC 100/250** | 100A/250A | 高 | `make 100_250_mkiii` | 双驱应用 |
| **VESC 100/500** | 100A/500A | 最高 | `make 100_500` | 顶级性能 |

### 流行的第三方品牌

#### 滑板/轮滑应用
| 品牌 | 型号 | 编译命令 | 功率 |
|------|------|---------|------|
| Trampa | TRONIC 250R | `make TRONIC_250R` | 250A |
| Luna | M600 Rev5 | `make luna_m600_Rev5` | 高功率 |
| Grin | Unity | `make unity` | 中等 |
| Grin | Duet | `make duet` | 双驱 |
| Cheap FOCer | V2 | `make Cheap_FOCer_2` | 低成本 |
| Little FOCer | V4 | `make Little_FOCer_V4` | 紧凑型 |

#### E-Bike 应用
| 品牌 | 型号 | 编译命令 | 适用电机 |
|------|------|---------|---------|
| Luna | BBSHD | `make luna_bbshd` | Bafang BBSHD |
| Luna | M600 | `make luna_m600` | 标准 |
| Maytech | Maxim 150A | `make maxim_150` | 多种 |
| MKSesc | 75/200 V2 | `make mksesc_75_200_v2` | 多种 |
| Flipsky | 110/300 | `make flipsky_110_300` | 高性能 |

#### 高性能竞速
| 品牌 | 型号 | 编译命令 | 特点 |
|------|------|---------|------|
| Storm Core | 100DX | `make stormcore_100dx` | 最新型 |
| Storm Core | 100D V2 | `make stormcore_100d_v2` | 双驱 |
| ENNOID | 150V MK8 | `make ENNOID_150V_mk8` | 高压 |
| Maytech | Maxim 150 HP | `make maxim_150_ph` | 高功率版 |

### 按价格/性能 Quick Pick

#### 🎯 预算友好 ($)
```bash
make Cheap_FOCer_2        # 廉价 FOC
make basic_035            # 基础款
make classic              # 经典款
```

#### 🎯 性价比 ($$)
```bash
make flipsky_75           # Flipsky 75A
make 60_mk6               # VESC 60
make Little_FOCer_V4      # 小型 FOC
```

#### 🎯 高端 ($$$)
```bash
make 75_300_mkiv          # VESC 官方
make stormcore_100d_v2    # Storm Core
make 100_500              # VESC 顶级
```

---

## � 快速查找硬件

使用硬件查询脚本快速找到你的硬件编译目标：

```bash
# 查找 Flipsky 硬件
./find_board.sh flipsky

# 查找 75A 系列
./find_board.sh 75_

# 查找 Storm Core 硬件
./find_board.sh stormcore

# 查找所有无限制版本
./find_board.sh no_limits

# 列出所有硬件
./find_board.sh
```

输出示例：
```
🔍 搜索: 'flipsky'
✅ 找到 18 个匹配的硬件:
 1. flipsky_60
 2. flipsky_75
 3. flipsky_110_100
 ... 等等
```

## 🔧 快速编译步骤

### 第一次使用

```bash
# 1. 进入项目目录
cd /workspaces/bldc

# 2. 查找你的硬件（可选）
./find_board.sh flipsky      # 例如查找 Flipsky 硬件

# 3. 加载编译环境
source ./build_env.sh

# 4. 选择你的硬件，编译固件
make flipsky_75              # 示例：Flipsky 75A

# 5. 等待编译完成（通常 1-2 分钟）
# 输出文件在: build/flipsky_75/flipsky_75.bin
```

### 后续编译

```bash
# 已经加载过环境的情况下，直接编译
source ./build_env.sh && make stormcore_100d

# 或编译不同硬件
make 100_250

# 清理前一个编译
make flipsky_75_clean

# 查看详细编译日志
make V=1 100_250
```

---

## 📱 按应用类别查找

### 电动滑板 / 轮滑

推荐硬件（按性能）：
1. **高性能**: `make stormcore_100dx` / `make TRONIC_250R`
2. **中性能**: `make flipsky_110_300` / `make luna_m600_Rev5`
3. **入门级**: `make Little_FOCer_V4` / `make Cheap_FOCer_2`

### 电动自行车（E-Bike）

推荐硬件：
1. **标准电机**: `make maytech_150` / `make mksesc_75_200_v2`
2. **BBSHD 电机**: `make luna_bbshd`
3. **高功率应用**: `make flipsky_110_400` / `make stormcore_100d_v2`

### 无人机 / 小型无人机

推荐硬件：
1. 小型控制器：`make Little_FOCer_V4` / `make flipsky_60`

### 轮毂电机

推荐硬件：
1. 标准轮毂：`make 75_300_mkiv` / `make mksesc_75_200_v2`
2. 高性能轮毂：`make stormcore_100d` / `make 100_250`

### 直驱电机

推荐硬件：
1. **双驱应用**: `make unity` / `make duet_xs100`
2. **单驱高功率**: `make maxim_150` / `make stormcore_100d_v2`

---

## 🎓 示例工作流

### 工作流 1：快速测试固件

```bash
# 编译示例/演示固件
source ./build_env.sh
make example

# 输出文件
ls -lh build/example/example.bin
```

### 工作流 2：为特定硬件编译

```bash
# 例如：为 Flipsky 75A 编译
source ./build_env.sh
make flipsky_75

# 查看输出
ls build/flipsky_75/
  flipsky_75.bin      # 二进制固件（用于烧录）
  flipsky_75.hex      # HEX 格式
  flipsky_75.elf      # ELF 文件
  flipsky_75.map      # 链接器映射
```

### 工作流 3：编译所有硬件

```bash
# 编译所有 300+ 目标（需要 30+ 分钟）
source ./build_env.sh
make all_fw

# 所有输出在 build/ 目录下
ls build/ | wc -l    # 查看编译的硬件数量
```

---

## ⚙️ 常用命令

```bash
# 环境设置
source ./build_env.sh              # 加载编译环境

# 编译
make <board>                       # 编译特定硬件
make <board>_clean                 # 清理编译输出
make <board>_flash                 # 烧录到硬件（需要 OpenOCD）

# 查询
make                               # 显示帮助信息和所有硬件列表
make help                          # 显示详细帮助

# 日志和诊断
make V=1 <board>                   # 显示详细编译日志
arm-none-eabi-gcc --version        # 检查工具链版本
```

---

## 📚 更多信息

- **详细硬件列表**: 查看 [SUPPORTED_BOARDS.md](SUPPORTED_BOARDS.md)
- **构建指南**: 查看 [BUILD_SETUP.md](BUILD_SETUP.md)
- **项目 GitHub**: https://github.com/vedderb/bldc
- **VESC 官网**: https://vesc-project.com/

---

**💡 提示**: 不确定选择哪个硬件？
- 价格优先 → `Cheap_FOCer_2`
- 性价比 → `flipsky_75` 或 `60_mk6`
- 最佳性能 → `stormcore_100dx` 或 `VESC 100/500`

---

**最后更新**: 2026-08-18
