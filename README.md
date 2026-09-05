# hougeapps-overlay

Houge 的个人 Gentoo overlay，以 **[Caelestia](https://github.com/caelestia-dots) 桌面环境全家桶**（Hyprland + quickshell 生态）为核心，附带若干上游发布缓慢、需要自行跟版的工具包。

> 所有包均经过**逐包真实编译验证**（`ebuild compile` 或完整 `emerge` 测试），保持与上游 release 同步。

## 仓库特点

- **全 release 锚定**：只收录上游正式 tag/release 版本，**无 9999/live ebuild**，可重复构建
- **两代保留**：每个包只保留「上一代 + 当前最新」两个版本，历史版本定期清理
- **来源可溯**：每个 ebuild 均在 `metadata.xml` 标注上游；本仓库自主维护所有包的最新版本，主树/其他 overlay 仅作对照参考，不作为版本跟随或退役依据
- **不维护内核包**：内核相关包（liquorix-sources、xanmod 等）已全部移除，请使用主树或专门的内核 overlay

## 包含的包（15 个）

### Caelestia 桌面套件（核心维护）

| 包 | 版本 | 说明 |
| :--- | :--- | :--- |
| `gui-apps/caelestia-shell` | 2.3.0 / 2.4.0 | Caelestia 的 quickshell 配置（bar/启动器/通知中心/OSD 等） |
| `gui-apps/quickshell` | 0.3.1 | Qt/QML 桌面 shell 工具包（caelestia 的运行时） |
| `gui-libs/m3shapes` | 1.0.0 | Material 3 形状 QML 模块（2.4.0 起上游拆分的独立依赖） |
| `app-misc/caelestia-cli` | 1.1.2 | Caelestia 命令行工具（壁纸/配色/screenshot/安装器） |
| `media-libs/libcava` | 1.0.0 | CAVA 音频可视化库（quickshell 音频模块后端） |
| `dev-python/materialyoucolor` | 3.0.4 | Material You 动态取色库（壁纸配色引擎） |
| `media-sound/pwvucontrol` | 0.5.3-r1 | PipeWire 音量控制面板（`-r1` 为上游 retag 修订） |
| `media-fonts/rubik` | 2.3.0 | Rubik 可变字体（Caelestia 默认字体） |
| `media-fonts/material-symbols` | 4.0.0 | Material Symbols Rounded 可变图标字体 |

> **注意**：Caelestia 全家桶依赖 Hyprland 合成器，本仓库**不提供** Hyprland——请从官方 [hyproverlay](https://github.com/hyprwm/hyprland-gentoo) 安装。

### 系统工具

| 包 | 版本 | 说明 |
| :--- | :--- | :--- |
| `app-arch/zchunk` | 1.5.3 / 1.5.4 | 高效增量压缩格式（libsolv 依赖） |
| `sys-libs/libsolv` | 0.7.35 / 0.7.39 | SAT 依赖求解库（libzypp 依赖） |
| `sys-libs/libzypp` | 17.38.14 / 17.38.15 | openSUSE 包管理库 |
| `sys-apps/zypper` | 1.14.100 / 1.14.101 | openSUSE 包管理器 CLI |

### 与主树同名的包（自主维护）

| 包 | 版本 | 说明 |
| :--- | :--- | :--- |
| `games-util/gamemode` | 1.8.2 | 自主维护；主树版本仅作对照参考 |
| `media-libs/rtmidi` | 6.0.0 | 自主维护；Manifest 已对齐官网当前 tarball |

## 使用方法

### 添加 overlay

在 `/etc/portage/repos.conf/hougeapps-overlay.conf` 写入：

```ini
[hougeapps-overlay]
location = /var/db/repos/hougeapps-overlay
sync-type = git
sync-uri = https://github.com/HougeLangley/hougeapps-overlay.git
auto-sync = yes
```

SSH 用户将 `sync-uri` 换成 `git@github.com:HougeLangley/hougeapps-overlay.git`。

然后：

```bash
sudo emerge --sync hougeapps-overlay
```

### 接受关键词

本仓库包均为测试分支（`~amd64` 等）。在 `/etc/portage/package.accept_keywords` 添加：

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

## 维护说明

- 版本策略：每包保留「上一代 + 最新」；上游发布新版本后 bump（旧版保留一代），`ebuild manifest` 重打
- 所有 ebuild 在合并前经过真实编译测试（`ebuild clean compile` 或 `emerge --oneshot`）
- Manifest：BLAKE2B + SHA512 双哈希，`thin-manifests` 模式

## 问题反馈

欢迎提 [issue](https://github.com/HougeLangley/hougeapps-overlay/issues)。自用为主，精力有限，更新节奏随缘。

## 致谢

- [Caelestia](https://github.com/caelestia-dots) —— 桌面上游项目
- [quickshell](https://github.com/quickshell-mirror/quickshell) —— shell 框架
- [Gentoo](https://gentoo.org) 社区与主树维护者
