# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

M3SHAPES_REV="32ad9ce328bb77ed349b40a3be10ee9ea610b8ab"

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
		# 上游默认相对路径 usr/lib/qt6/qml（Nix/PKGBUILD 场景），Gentoo 需绝对路径
		-DINSTALL_QMLDIR="${EPREFIX}/usr/lib64/qt6/qml"
	)
	cmake_src_configure
}
