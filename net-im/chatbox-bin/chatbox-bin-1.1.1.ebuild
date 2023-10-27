# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg optfeature

DESCRIPTION="Chatbox is a desktop client for multiple cutting-edge LLM models, available on Windows, Mac, Linux"
HOMEPAGE="https://github.com/Bin-Huang/chatbox"

KEYWORDS="~amd64 ~arm64"

SRC_URI="amd64? ( https://github.com/Bin-Huang/chatbox/releases/download/v${PV}/Chatbox-${PV}-amd64.deb )
arm64? ( https://github.com/Bin-Huang/chatbox/releases/download/v${PV}/Chatbox-${PV}-arm64.deb )
"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="
	dev-libs/libappindicator:3
	x11-libs/libX11
	x11-themes/hicolor-icon-theme
	dev-libs/nspr
	dev-libs/nss
"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto /opt
	doins -r opt/*
	fperms +x /opt/Chatbox
	dosym -r /opt/Chatbox/xyz.chatboxapp.app /usr/bin/chatbox

	gzip -d usr/share/doc/xyz.chatboxapp.app/*.gz || die
	dodoc usr/share/doc/xyz.chatboxapp.app/*

	doicon -s 1024 usr/share/icons/hicolor/1024x1024/apps/xyz.chatboxapp.app.png
	doicon -s 128 usr/share/icons/hicolor/128x128/apps/xyz.chatboxapp.app.png
	doicon -s 16 usr/share/icons/hicolor/16x16/apps/xyz.chatboxapp.app.png
	doicon -s 24 usr/share/icons/hicolor/24x24/apps/xyz.chatboxapp.app.png
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/xyz.chatboxapp.app.png
	doicon -s 32 usr/share/icons/hicolor/32x32/apps/xyz.chatboxapp.app.png
	doicon -s 48 usr/share/icons/hicolor/48x48/apps/xyz.chatboxapp.app.png
	doicon -s 512 usr/share/icons/hicolor/512x512/apps/xyz.chatboxapp.app.png
	doicon -s 64 usr/share/icons/hicolor/64x64/apps/xyz.chatboxapp.app.png
	doicon -s 96 usr/share/icons/hicolor/96x96/apps/xyz.chatboxapp.app.png
	domenu usr/share/applications/xyz.chatboxapp.app.desktop
}
