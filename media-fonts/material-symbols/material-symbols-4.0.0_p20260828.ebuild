# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Google Material Symbols variable icon font (Rounded)"
HOMEPAGE="https://fonts.google.com/icons https://github.com/google/material-design-icons"

# 上游 release 节奏为 4.0.0 tag + master 滚动（AUR 亦以 commit 快照打包）；
# 本包锚定 variablefont 目录最新 commit（2026-08-14）
COMMIT="84ccef280841abfac506afc4ad4a2782f6d0a1d0"
SRC_URI="https://raw.githubusercontent.com/google/material-design-icons/${COMMIT}/variablefont/MaterialSymbolsRounded%5BFILL%2CGRAD%2Copsz%2Cwght%5D.ttf -> MaterialSymbolsRounded-${COMMIT}.ttf"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/MaterialSymbolsRounded-${COMMIT}.ttf" \
		"${WORKDIR}/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf" || die
}
