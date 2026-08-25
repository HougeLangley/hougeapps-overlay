# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13,14} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="Main control script for the Caelestia dotfiles"
HOMEPAGE="https://github.com/caelestia-dots/cli"
SRC_URI="https://github.com/caelestia-dots/cli/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cli-${PV}"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"

# 上游 pyproject 依赖仅 pillow + materialyoucolor；其余为外部工具运行时
RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/materialyoucolor[${PYTHON_USEDEP}]
	x11-libs/libnotify
	dev-libs/glib:2
	gui-apps/grim
	gui-apps/slurp
	gui-apps/swappy
	gui-apps/wl-clipboard
	gui-apps/fuzzel
	app-misc/cliphist
	media-video/gpu-screen-recorder
"
# DISTUTILS_USE_PEP517=hatchling 由 eclass 自动引入 hatchling；
# hatch-vcs 需显式声明（tarball 无 .git，用 HATCH_VCS_PRETEND_VERSION 固定版本）
BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

# hatch-vcs 底层即 setuptools-scm；tarball 无 .git，
# 用 setuptools-scm 官方环境变量固定版本（注意：不存在 HATCH_VCS_PRETEND_VERSION）
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

src_install() {
	distutils-r1_src_install
	insinto /usr/share/fish/vendor_completions.d
	doins completions/caelestia.fish
}
