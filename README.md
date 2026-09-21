# hougeapps-overlay

Houge 的个人 Gentoo overlay。以 **[Caelestia](https://github.com/caelestia-dots) 桌面环境全家桶**（Hyprland + quickshell 生态）为核心，附带若干上游发布缓慢、需要自行跟版的工具包。

> 所有包均经过**逐包真实编译验证**（`ebuild clean compile` 或完整 `emerge` 测试），并由**自动巡检**每日跟版——上游发版后通常当天完成 bump。

## 仓库特点

- **全 release 锚定**：只收录上游正式 tag/release 版本，**无 `9999`/live ebuild**，可重复构建；无 release 可锚的滚动上游（m3shapes、material-symbols）退而锚定 commit 快照，并在 ebuild 注释里写明理由
- **最多两代保留**：发生过版本升级的包保留「上一代 + 当前最新」两个 ebuild；只有单个 ebuild 的包说明尚未 bump 过。例外——无 tag 上游的周期快照包（m3shapes）以 `-rN` 单调递增更新，不并存旧修订
- **来源可溯**：每个包都有 `metadata.xml` 标注上游项目；本仓库**自主维护所有包的最新版本**，主树/其他 overlay 仅作对照参考，不作为版本跟随或退役依据
- **自动巡检跟版**：每日全仓四路巡检 + 快照包专属监检（见「维护说明」）；编译失败的版本不会进入仓库
- **不维护内核包**：内核相关包（liquorix-sources、xanmod 等）已全部移除，请使用主树或专门的内核 overlay

## 包含的包（15 个）

### Caelestia 桌面套件（9 个）

| 包 | 版本 | 说明 |
| :--- | :--- | :--- |
| `gui-apps/caelestia-shell` | 2.4.0 / 2.5.0 | Caelestia 的 quickshell 配置（bar/启动器/通知中心/OSD 等）；2.4.0 携带 Qt 6.11 头文件补丁 |
| `gui-apps/quickshell` | 0.3.1 | Qt/QML 桌面 shell 工具包（Caelestia 的运行时）；携带 strict-aliasing 补丁 |
| `gui-libs/m3shapes` | 1.0.0-r2 | Material 3 形状 QML 模块。上游 2.4.0 起（PR #1909）从 shell 拆为独立依赖，本包以 commit 快照跟随滚动上游 |
| `app-misc/caelestia-cli` | 1.1.2 / 1.1.3 | Caelestia 命令行工具（壁纸/配色/screenshot/安装器） |
| `media-libs/libcava` | 1.0.0 | CAVA 音频可视化库（quickshell 音频模块后端）；仅构建共享库，各 input 后端跟随系统 USE |
| `dev-python/materialyoucolor` | 3.0.4 | Material You 动态取色库（壁纸配色引擎）；sdist 已 vendor 全部 C++ 源，构建不联网 |
| `media-sound/pwvucontrol` | 0.5.3-r1 | PipeWire 音量控制面板；`-r1` 用于适配上游 2026-08 retag 的 0.5.3（Cargo.lock 全量 bump） |
| `media-fonts/rubik` | 2.3.0 | Rubik 可变字体（Caelestia 默认字体）；上游无 git tag，锚定 AUR `ttf-rubik-vf` 所用同一 commit |
| `media-fonts/material-symbols` | 4.0.0_p20260918 | Material Symbols Rounded 可变图标字体；上游为「4.0.0 tag + master 滚动」节奏，本包锚定 `variablefont/` 目录最新 commit |

> **注意**：Caelestia 全家桶依赖 Hyprland 合成器，本仓库**不提供** Hyprland——请从官方 [hyproverlay](https://github.com/hyprwm/hyprland-gentoo) 安装。

### openSUSE 打包工具链（4 个）

| 包 | 版本 | 说明 |
| :--- | :--- | :--- |
| `app-arch/zchunk` | 1.5.3 / 1.5.4 | 高效增量压缩格式（libsolv 依赖） |
| `sys-libs/libsolv` | 0.7.35 / 0.7.39 | SAT 依赖求解库（libzypp 依赖） |
| `sys-libs/libzypp` | 17.38.14 / 17.38.15 | openSUSE 包管理库 |
| `sys-apps/zypper` | 1.14.100 / 1.14.101 | openSUSE 包管理器 CLI |

### 与主树同名的包（自主维护，2 个）

| 包 | 版本 | 说明 |
| :--- | :--- | :--- |
| `games-util/gamemode` | 1.8.2 | 自主维护；主树版本仅作对照参考 |
| `media-libs/rtmidi` | 6.0.0 | 自主维护；Manifest 已对齐官网当前 tarball（上游曾 retag 同版本） |

## 使用方法

### 添加 overlay

在 `/etc/portage/repos.conf/hougeapps-overlay.conf` 写入：

```ini
[hougeapps-overlay]
location = /var/db/repos/hougeapps-overlay
sync-type = git
sync-uri = https://github.com/HougeLangley/hougeapps-overlay.git
auto-sync = yes
priority = 100
```

- **`sync-uri` 用 HTTPS**：`emerge --sync` 以 root 运行，拿不到普通用户的 GitHub SSH 私钥
- **`priority = 100`**：Gentoo 的规则是「版本优先，同版本才比优先级」。提权本地后，同版本时本仓库兜底胜出；主树/guru 一旦发布更高版本便自动接管，无需人工干预

SSH 用户（仅用于自己推送）可将 `sync-uri` 换成 `git@github.com:HougeLangley/hougeapps-overlay.git`。

然后：

```bash
sudo emerge --sync hougeapps-overlay
```

### 接受关键词

本仓库所有包均为 **`~amd64`** 测试分支（`media-libs/rtmidi` 另声明 `amd64 ~arm ~arm64 ~ppc64 x86`）。因此在 `/etc/portage/package.accept_keywords` 添加：

```
*/*::hougeapps-overlay
```

### 安装 Caelestia 桌面

```bash
# 1. 先装 Hyprland（hyproverlay）+ 本仓库全家桶
sudo emerge -av gui-apps/caelestia-shell gui-apps/quickshell gui-libs/m3shapes app-misc/caelestia-cli \
  media-libs/libcava dev-python/materialyoucolor media-fonts/rubik \
  media-fonts/material-symbols media-sound/pwvucontrol

# 2. 部署 dots（点文件）
caelestia install

# 3. 个人配置写入用户区（dots 更新不覆盖）
#    ~/.config/caelestia/hypr-vars.lua   —— 选择型覆盖（终端/浏览器/文件管理器/光标主题）
#    ~/.config/caelestia/hypr-user.lua   —— 追加型配置（env/monitor/自启程序）
#    ~/.config/caelestia/user-config.fish —— fish 用户配置
```

## 版本号约定

| 形式 | 含义 | 例 |
| :--- | :--- | :--- |
| `X.Y.Z` | 上游正式 tag/release | `quickshell-0.3.1` |
| `X.Y.Z-rN` | 本地打包修订（补丁、依赖修正，或适配上游 retag） | `pwvucontrol-0.5.3-r1` |
| `X.Y.Z_pYYYYMMDD` | 无 release 的滚动上游，按当日锚定的 commit 打包 | `material-symbols-4.0.0_p20260918` |
| `A.B.C-rN` 递增链 | 无 tag 上游的周期快照，修订号**单调递增、不复用** | `m3shapes-1.0.0-r2` |

## 维护说明

### 更新节奏

- **有 release 的包**：上游发布新 tag/release 后跟版（自动巡检驱动，通常当天完成）
- **滚动上游的包**：锚定 commit 快照（`material-symbols` 跟随 `variablefont/` 最新 commit；`m3shapes` 在有新 commit 且距上次 ebuild 变更 ≥7 天时做 `-rN+1`）
- **上游首次出现 tag 时**：快照包立即迁移回 tag 锚定（不受周期窗口约束）

### 自动巡检（已落地）

| 机制 | 频率 | 作用 |
| :--- | :--- | :--- |
| `deep-check.py` 全仓深度巡检 | 每日 09:00 | 四路合围：tags 全量 / GitHub releases 暗渠道 / commit 快照 / 主树·guru·hyproverlay 对照；外加「仓库里有包但清单没盯」的完整性自检 |
| `m3shapes-check.py` 专属监检 | 每 2 天 | 输出确定性事实 + `ACTION` 裁决（tag 迁移 / `-rN` 快照 bump / 仅报告 / 无动作） |

巡检脚本**动态读取 ebuild 文件名取版本**（不硬编码），因此 bump 后无需维护脚本。全部 ✅ 时静默；发现更新则自动执行「改 ebuild → 编译验证 → 提交 → 推送 → 本机 `emerge --sync`」并在编译失败时停手等人工；有包没被清单盯上会立即报警，杜绝「新包成为巡检盲区」。

### ebuild 质量约定

- **编译验证优先于提交**：每个版本在合并前跑 `ebuild clean compile`（无依赖链），或有依赖链时 `emerge --oneshot` + `depclean` 回收；编译失败绝不 commit/push
- **版本化补丁必须 dry-run**：`PATCHES=("${FILESDIR}/${P}-*.patch")` 形式的包在 bump 时同步改名补丁文件，并解包新 tarball 用 `patch -p1 --dry-run` 验证适用性，上游已吸收的 hunk 会从补丁中剔除
- **Manifest**：`BLAKE2B + SHA512` 双哈希、`thin-manifests` 模式，由 `ebuild <path> manifest` 生成
- **构建期不联网**：需联网的上游行为显式处理（`materialyoucolor` 依赖 sdist 内 vendor 的 C++ 源；`m3shapes` 显式传 `-DINSTALL_QMLDIR` 修正 QML 安装落点）
- **全系统 LTO 用户注意**：`media-libs/libcava` 的 ebuild 自带 `filter-lto`（其 `.incbin` 着色器内嵌在 LTO 链接期会失败），全局 `-flto` 构建无需额外处理
- **历史不改写**：已推送的 commit 绝不 amend，追加改动一律新开 commit

## 仓库元信息

| 项 | 值 |
| :--- | :--- |
| `repo_name` | `hougeapps-overlay` |
| `masters` | `gentoo` |
| `EAPI` | `8`（全线一致） |
| `KEYWORDS` | 全线 `~amd64`（`media-libs/rtmidi` 额外含 `amd64 ~arm ~arm64 ~ppc64 x86`）|
| `thin-manifests` | `true` |
| `manifest-hashes` | `BLAKE2B SHA512`（`manifest-required-hashes = BLAKE2B`）|
| `profile-formats` | `portage-2 profile-set` |
| `sign-commits` | `true`（仅对 rsync 镜像生成有意义；git sync 不校验签名）|
| 结构 | 15 个包 / 9 个 category / 21 个 ebuild |
| 许可 | 本仓库自身 GPL-3.0；各包版权与许可见其 ebuild 的 `LICENSE` 与上游项目 |

## 问题反馈

欢迎提 [issue](https://github.com/HougeLangley/hougeapps-overlay/issues)。自用为主，更新由自动巡检驱动，上游发版后通常当天跟版。

## 致谢

- [Caelestia](https://github.com/caelestia-dots) —— 桌面上游项目
- [quickshell](https://github.com/quickshell-mirror/quickshell) —— shell 框架
- [Gentoo](https://gentoo.org) 社区与主树维护者
