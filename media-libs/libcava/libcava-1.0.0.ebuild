# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Fork of cava providing the libcava shared library (used by Quickshell shells)"
HOMEPAGE="https://github.com/LukashonakV/cava"
SRC_URI="https://github.com/LukashonakV/cava/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cava-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# 仅构建共享库（上游 build_target 默认即 lib）；各 input 后端跟随系统 USE
IUSE="alsa jack pipewire portaudio pulseaudio sndio"

DEPEND="
	dev-libs/iniparser
	sci-libs/fftw:3.0
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack2 )
	pipewire? ( media-video/pipewire )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	sndio? ( media-sound/sndio )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local emesonargs=(
		-Dbuild_target=lib
		-Dasan=disabled
		-Dtsan=disabled
		-Dubsan=disabled
		$(meson_feature alsa input_alsa)
		$(meson_feature jack input_jack)
		$(meson_feature pipewire input_pipewire)
		$(meson_feature portaudio input_portaudio)
		$(meson_feature pulseaudio input_pulse)
		$(meson_feature sndio input_sndio)
	)
	meson_src_configure
}
