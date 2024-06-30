# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# already included in xanmod-rt
K_WANT_GENPATCHES="extras"

# Define what default functions to run
ETYPE="sources"

# Default enable Xanmod, You have to choose one of them.
# Both of them will make some errors
IUSE="-steamdeck"

# If you have been enable src_prepare-overlay
# please unmerge sys-kernel/xanmod-sources
RDEPEND=""
DEPEND="
	app-arch/cpio
	sys-devel/bc
	sys-apps/kmod
	dev-libs/elfutils
	dev-util/pahole
"

inherit kernel-2
detect_version

DESCRIPTION="xanmod-rt kernel is xanmod's rt version"
HOMEPAGE="https://xanmod.org/"
RT_VERSION="34"
XANMOD_VERSION="1"
XANMOD_RT_PATCH_URI="https://master.dl.sourceforge.net/project/xanmod/releases/rt/${PV}-rt${RT_VERSION}-xanmod${XANMOD_VERSION}"
CJK_PATCH_URI="https://gitlab.com/HougeLangley/cjktty-patches/-/raw/master/v6.x"
CJK_VERSION="6.6"
STEAMDECK_PATCHES_URI="https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/${KV_MAJOR}.${KV_MINOR}/steamdeck-patches"
SRC_URI="
	${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	${GENPATCHES_URI}
	${XANMOD_RT_PATCH_URI}/patch-${PV}-rt${RT_VERSION}-xanmod${XANMOD_VERSION}.xz
	${CJK_PATCH_URI}/cjktty-${CJK_VERSION}.patch
	${STEAMDECK_PATCHES_URI}/0001-x86-Introduce-Steam-Deck-Patches.patch
"
KEYWORDS="~amd64"

K_EXTRAEINFO="For more info on xanmod-rt and details on how to report problems, see: ${HOMEPAGE}."

src_unpack() {
	UNIPATCH_LIST_DEFAULT="
		${DISTDIR}/patch-${PV}-rt${RT_VERSION}-xanmod${XANMOD_VERSION}.xz
		${DISTDIR}/cjktty-${CJK_VERSION}.patch
	"
	UNIPATCH_LIST=""
	if use steamdeck; then
		UNIPATCH_LIST+="${DISTDIR}/0001-x86-Introduce-Steam-Deck-Patches.patch"
	fi
	UNIPATCH_STRICTORDER="yes"

	kernel-2_src_unpack
}

pkg_setup() {
	ewarn ""
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the ${HOMEPAGE} directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn ""

	kernel-2_pkg_setup
}

pkg_postinst() {
	elog "MICROCODES"
	elog "Use xanmod-rt with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
