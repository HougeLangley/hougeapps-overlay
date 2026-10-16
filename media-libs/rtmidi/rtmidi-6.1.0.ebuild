# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A set of C++ classes that provide a common API for realtime MIDI input/output"
HOMEPAGE="https://caml.music.mcgill.ca/~gary/rtmidi/"
# 6.1.0 起上游改在 GitHub release 附件发布发行版 tarball（官网 release/ 目录停在 6.0.0）
SRC_URI="https://github.com/thestk/rtmidi/releases/download/${PV}/${P}.tar.gz"

LICENSE="RtMidi"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc64 x86"
IUSE="+alsa jack test"
RESTRICT="!test? ( test )"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
"
RDEPEND="${DEPEND}"

# 6.1.0 上游把 ALSA 热插拔回归测试挂成 ALL 自定义目标：每次构建（含 install）
# 都跑测试程序去开 /dev/snd/seq，被 sandbox 拒绝导致 src_install 中止。
# 补丁把它收进 RTMIDI_BUILD_TESTING 开关（默认 no 时不构建不运行）。
PATCHES=( "${FILESDIR}/${P}-disable-hotplug-install-test.patch" )

src_configure() {
	local mycmakeargs=(
		-DRTMIDI_API_ALSA=$(usex alsa)
		-DRTMIDI_API_JACK=$(usex jack)
		-DRTMIDI_BUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
