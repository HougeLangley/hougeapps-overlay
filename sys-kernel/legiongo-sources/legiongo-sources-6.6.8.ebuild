# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, -xanmod patch set already includes main updates
K_GENPATCHES_VER="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

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

DESCRIPTION="Legion Go Linux Customization Kernel"
HOMEPAGE="https://xanmod.org/"
XANMOD_VERSION="1"
LEGION_LINUX_VERSION="0.0.9"
XANMOD_PATCH_URI="https://master.dl.sourceforge.net/project/xanmod/releases/main"
LEGION_GO_CONTROLLERS_URI="https://hougearch.litterhougelangley.club/doc"
LEGION_GO_PANEL_URI="https://hougearch.litterhougelangley.club/doc"
LEGION_LINUX_URI="https://github.com/johnfanv2/LenovoLegionLinux/releases/download/"
CJKTTY_URI="https://raw.githubusercontent.com/zhmars/cjktty-patches/master/v6.x/"
SRC_URI="
	${XANMOD_PATCH_URI}/${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-xanmod${XANMOD_VERSION}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-xanmod${XANMOD_VERSION}.xz
	${GENPATCHES_URI}
	${LEGION_GO_CONTROLLERS_URI}/add_lenovo_legion_go_controllers.patch
	${LEGION_GO_PANEL_URI}/add_lenovo_legion_go_panel.patch
	${LEGION_LINUX_URI}/v${LEGION_LINUX_VERSION}-prerelease/0001-Add-legion-laptop-v${LEGION_LINUX_VERSION}.patch
	${CJKTTY_URI}/cjktty-${KV_MAJOR}.${KV_MINOR}.patch
"
KEYWORDS="~amd64"

K_EXTRAEINFO="For more info PLEASE LEAVE MESSAGE TO ISSUE."

src_unpack() {
	UNIPATCH_LIST="${DISTDIR}/patch-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-xanmod${XANMOD_VERSION}.xz"
	UNIPATCH_LIST="${DISTDIR}/add_lenovo_legion_go_controllers.patch"
	UNIPATCH_LIST="${DISTDIR}/add_lenovo_legion_go_panel.patch"
	UNIPATCH_LIST="${DISTDIR}/0001-Add-legion-laptop-v${LEGION_LINUX_VERSION}.patch"
	UNIPATCH_LIST="${DISTDIR}/cjktty-${KV_MAJOR}.${KV_MINOR}.patch"

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
	elog "Use Xanmod-Kernel with microcodes"
	elog "Read https://wiki.gentoo.org/wiki/Intel_microcode"
}
