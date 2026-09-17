# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

M3SHAPES_REV="cc8e213301c96ccec0198008675069a3f3951b62"

DESCRIPTION="Material 3 shape library for Qt Quick (Caelestia shell runtime dependency)"
HOMEPAGE="https://github.com/soramanew/m3shapes"
SRC_URI="https://github.com/soramanew/m3shapes/archive/${M3SHAPES_REV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/m3shapes-${M3SHAPES_REV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6=[gui]
	dev-qt/qtdeclarative:6=
	dev-qt/qtshadertools:6=
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		# 2026-09-17 上游改用 GNUInstallDirs（${CMAKE_INSTALL_LIBDIR}/qt6/qml）；Gentoo eclass
		# 注入 CMAKE_INSTALL_LIBDIR=lib64 后其默认值也对，此处绝对路径覆盖为显式兜底
		-DINSTALL_QMLDIR="${EPREFIX}/usr/lib64/qt6/qml"
	)
	cmake_src_configure
}
