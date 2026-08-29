# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A fluid, morphing desktop shell (Quickshell configuration)"
HOMEPAGE="https://github.com/caelestia-dots/shell"

# m3shapes：上游 2.4.0 起（PR #1909）拆分为独立 QML 模块，由 gui-libs/m3shapes
# 提供（usr/lib64/qt6/qml/M3Shapes），不再随本包 FetchContent 构建。
# v2.4.0 tag 的完整 commit：上游 CMake 需要 GIT_REVISION，tarball 无 .git
GIT_REV="24aa15eefdb146350d2548c0a015b04eddbd1008"

SRC_URI="https://github.com/caelestia-dots/shell/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/shell-${PV}"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cli"

# 构建期需要链接/查包的库
DEPEND="
	dev-qt/qtbase:6[dbus,concurrent,network,sql]
	dev-qt/qtdeclarative:6
	dev-qt/qtshadertools:6
	sci-libs/libqalculate
	media-video/pipewire
	media-libs/aubio
	media-libs/libcava
	sys-apps/lm-sensors
"
# 运行时完整依赖（含外部工具与字体）
RDEPEND="
	${DEPEND}
	>=gui-apps/quickshell-0.3.0[hyprland,pipewire,mpris,pam,session-lock,tray]
	dev-qt/qtimageformats:6
	gui-libs/m3shapes
	gui-wm/hyprland
	app-shells/bash
	app-shells/fish
	app-misc/brightnessctl
	app-misc/ddcutil
	sys-power/power-profiles-daemon
	net-misc/networkmanager
	gui-apps/swappy
	gui-apps/wl-clipboard
	media-fonts/material-symbols
	media-fonts/rubik
	media-fonts/nerd-fonts[cascadiacode,jetbrainsmono]
	cli? ( app-misc/caelestia-cli )
"
BDEPEND="virtual/pkgconfig"

# Qt 6.11 收紧头文件间接 include：补 QQmlEngine/QJSEngine/QVariant 显式声明
# （iutils.hpp 的 create() 签名与 fontbuilder 的 QVariantMap 依赖旧式间接 include）
PATCHES=( "${FILESDIR}/${P}-qt611-includes.patch" )

src_configure() {
	local mycmakeargs=(
		-DVERSION="${PV}"
		-DGIT_REVISION="${GIT_REV}"
		-DDISTRIBUTOR="Gentoo (local overlay)"
		-DFETCHCONTENT_SOURCE_DIR_M3SHAPES_EXTERNAL="${WORKDIR}/m3shapes-${M3SHAPES_REV}"
		# 上游依赖 PCH 提供 qobject/qstring/qqmlengine/qvariant/qtimer/qpointer 等头，
		# 源码不显式 include；Gentoo eclass 默认禁用 PCH 会导致编译失败，必须恢复
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF
		# 上游 utils/Paths.qml 的 fallback 即 /usr/lib/caelestia，
		# 与 Gentoo multilib 的 lib64 不一致；显式对齐后无需 CAELESTIA_LIB_DIR 环境变量
		-DINSTALL_LIBDIR="/usr/lib/caelestia"
		# X-OS-Config 机制要求 shell 配置在 /etc/xdg（qs -c caelestia 按 XDG_CONFIG_DIRS 查找）；
		# GNUInstallDirs 默认 SYSCONFDIR 跟随 prefix 会装成 /usr/etc，必须显式纠正
		-DINSTALL_QSCONFDIR="/etc/xdg/quickshell/caelestia"
	)
	cmake_src_configure
}
