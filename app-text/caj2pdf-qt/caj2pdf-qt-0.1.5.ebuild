# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake
DESCRIPTION="CAJ to PDF converter (GUI version)"
HOMEPAGE="https://caj2pdf-qt.sainnhe.dev"
SRC_URI="
	https://github.com/sainnhe/caj2pdf-qt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/caj2pdf/caj2pdf/archive/acce7c9ffd919e67b447e7baa8df2ae17b450dd4.zip -> caj2pdf.zip
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	sys-libs/glibc
	media-libs/jbig2dec
	app-text/mupdf
	sys-libs/zlib
	dev-qt/qtcore:5
	media-libs/libpng
	media-libs/harfbuzz
	app-text/md4c
	dev-libs/double-conversion
	dev-libs/libpcre2
	app-arch/zstd
	dev-libs/glib:2
	media-libs/freetype:2
	media-gfx/graphite2
	sys-libs/libcap
	dev-libs/libgcrypt
	app-arch/xz-utils
	app-arch/lz4
	x11-libs/libX11
	app-arch/bzip2
	app-arch/brotli
	dev-libs/libgpg-error
	x11-libs/libxcb
	x11-libs/libXau
	x11-libs/libXdmcp
"

BDEPEND="
    dev-vcs/git
    dev-lang/python
    dev-util/cmake
"

src_prepare() {
	default
	mv "${WORKDIR}/caj2pdf-acce7c9ffd919e67b447e7baa8df2ae17b450dd4" "${S}/caj2pdf" || die
	cd "${S}/caj2pdf" || die
	git init || die
	git add . || die
	git config user.name "Anonymous" || die
	git config user.email "noreply@localhost" || die
	git commit -m "Init" || die
}
#
#src_compile() {
#	emake -C "${S}" -f build-unix.sh cli
#	emake -C "${S}" -f build-unix.sh qt
#}
#
src_install() {
	doicon "${FILESDIR}/${P}.desktop"
}
