# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Rubik variable font (hubert&fischer / Google Fonts)"
HOMEPAGE="https://github.com/googlefonts/rubik"

# 上游无 git tag；锚定 AUR ttf-rubik-vf 2.3.0 所用同一 commit
COMMIT="e337a5f69a9bea30e58d05bd40184d79cc099628"
SRC_URI="
	https://raw.githubusercontent.com/googlefonts/rubik/${COMMIT}/fonts/variable/Rubik%5Bwght%5D.ttf -> Rubik-VF-${COMMIT}.ttf
	https://raw.githubusercontent.com/googlefonts/rubik/${COMMIT}/fonts/variable/Rubik-Italic%5Bwght%5D.ttf -> Rubik-Italic-VF-${COMMIT}.ttf
"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"

src_unpack() {
	cp "${DISTDIR}/Rubik-VF-${COMMIT}.ttf" "${WORKDIR}/Rubik[wght].ttf" || die
	cp "${DISTDIR}/Rubik-Italic-VF-${COMMIT}.ttf" "${WORKDIR}/Rubik-Italic[wght].ttf" || die
}
