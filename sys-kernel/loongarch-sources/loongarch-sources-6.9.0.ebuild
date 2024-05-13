# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Define what default functions to run
ETYPE="sources"

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# Just get basic genpatches, AOSC's LoongArch patch not set already includes main updates
K_GENPATCHES_VER="1"

# Not supported by the Gentoo security team
K_SECURITY_UNSUPPORTED="1"

# We want the very basic patches from gentoo-sources, experimental patch is
# not already included in AOSC's LoongArch Linux Kernel
K_WANT_GENPATCHES="extras"

# Default enable AOSC's LoongArch's Kernel, You have to choose one of them.
# Both of them will make some errors
IUSE="+cjk"

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

DESCRIPTION="AOSC's LoongArch64 Kernel"
HOMEPAGE="https://aosc.io/"
AOSC_VERSION="1"
MAIN_LINUX_URI="https://mirrors.ustc.edu.cn/kernel.org/linux/kernel/v6.x/"
SRC_URI="
	${MAIN_LINUX_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz
	${GENPATCHES_URI}
"
KEYWORDS="~loong"

K_EXTRAEINFO="For more info on AOSC's LoongArch Kernel and details on how to report problems, see: ${HOMEPAGE}."

src_unpack() {
	UNIPATCH_LIST_DEFAULT="
	${FILESDIR}/0001-ath9k-rx-dma-stop-check.patch || die
	${FILESDIR}/0002-pci-Enable-overrides-for-missing-ACS-capabilities-5..patch || die
	${FILESDIR}/0003-cpuinfo-fix-a-warning-for-CONFIG_CPUMASK_OFFSTACK.patch || die
	${FILESDIR}/0004-HACK-drm-amdgpu-use-amdgpu-by-default-for-si-cik-dev.patch || die
	${FILESDIR}/0005-input-synaptics-pin-3-touches-when-the-firmware-repo.patch || die
	${FILESDIR}/0006-hid-logitech-dj-add-support-for-the-new-lightspeed-r.patch || die
	${FILESDIR}/0007-hid-add-PixArt-touchpad-driver.patch || die
	${FILESDIR}/0008-hid-register-Surface-hid-devices.patch || die
	${FILESDIR}/0009-lis3-improve-handling-of-null-rate.patch || die
	${FILESDIR}/0010-ethernet-bundle-module-for-Motorcomm-YT6801.patch || die
	${FILESDIR}/0011-net-stmmac-Move-the-atds-flag-to-the-stmmac_dma_cfg-.patch || die
	${FILESDIR}/0012-net-stmmac-Add-multi-channel-support.patch || die
	${FILESDIR}/0013-net-stmmac-Export-dwmac1000_dma_ops.patch || die
	${FILESDIR}/0014-net-stmmac-dwmac-loongson-Drop-useless-platform-data.patch || die
	${FILESDIR}/0015-net-stmmac-dwmac-loongson-Use-PCI_DEVICE_DATA-macro-.patch || die
	${FILESDIR}/0016-net-stmmac-dwmac-loongson-Split-up-the-platform-data.patch || die
	${FILESDIR}/0017-net-stmmac-dwmac-loongson-Add-ref-and-ptp-clocks-for.patch || die
	${FILESDIR}/0018-net-stmmac-dwmac-loongson-Add-phy-mask-for-Loongson-.patch || die
	${FILESDIR}/0019-net-stmmac-dwmac-loongson-Add-phy_interface-for-Loon.patch || die
	${FILESDIR}/0020-net-stmmac-dwmac-loongson-Add-full-PCI-support.patch || die
	${FILESDIR}/0021-net-stmmac-dwmac-loongson-Add-loongson_dwmac_config_.patch || die
	${FILESDIR}/0022-net-stmmac-dwmac-loongson-Fixed-failure-to-set-netwo.patch || die
	${FILESDIR}/0023-net-stmmac-dwmac-loongson-Add-Loongson-GNET-support.patch || die
	${FILESDIR}/0024-net-stmmac-dwmac-loongson-Move-disable_force-flag-to.patch || die
	${FILESDIR}/0025-net-stmmac-dwmac-loongson-Add-loongson-module-author.patch || die
	${FILESDIR}/0026-net-stmmac-add-a-glue-driver-for-GMACs-in-Phytium-So.patch || die
	${FILESDIR}/0027-x86-add-more-uarches-for-kernel-6.8-rc4.patch || die
	${FILESDIR}/0028-arm-usb-phy-tegra-Add-38.4MHz-clock-table-entry.patch || die
	${FILESDIR}/0029-arm64-dts-rockchip-change-GMAC-rx_delay-for-RockPro6.patch || die
	${FILESDIR}/0030-arm64-dts-rockchip-add-out-of-band-IRQ-for-RK3399-Wi.patch || die
	${FILESDIR}/0031-arm64-rockchip-dts-rk3399-fix-PD-on-Pinebook-Pro.patch || die
	${FILESDIR}/0032-arm64-add-Kconfig-option-for-Phytium-SoCs.patch || die
	${FILESDIR}/0033-arm64-dts-rockchip-disable-usb3-on-quartz64.patch || die
	${FILESDIR}/0034-arm64-drop-hisi_ddrc_pmu-driver.patch || die
	${FILESDIR}/0035-MIPS-loongson64-disable-writecombine-for-Loongson-3A.patch || die
	${FILESDIR}/0036-MIPS-loongson64-init-suppress-memcpy-out-of-bound-ch.patch || die
	${FILESDIR}/0037-MIPS-loongson64-video-output-re-introduce-display-ou.patch || die
	${FILESDIR}/0038-MIPS-video-fbdev-sis-add-1368x768-resolution.patch || die
	${FILESDIR}/0039-LoongArch-Select-ARCH_SUPPORTS_INT128-if-CC_HAS_INT1.patch || die
	${FILESDIR}/0040-LoongArch-Define-__ARCH_WANT_NEW_STAT-in-unistd.h.patch || die
	${FILESDIR}/0041-LoongArch-rust-Switch-to-use-built-in-rustc-target.patch || die
	${FILESDIR}/0042-LoongArch-Add-CPU-HWMon-platform-driver.patch || die
	${FILESDIR}/0043-LoongArch-Update-Loongson-3-default-config-file.patch || die
	${FILESDIR}/0044-LoongArch-Select-THP_SWAP-if-HAVE_ARCH_TRANSPARENT_H.patch || die
	${FILESDIR}/0045-LoongArch-Update-the-flush-cache-policy.patch || die
	${FILESDIR}/0046-dt-bindings-pwm-Add-Loongson-PWM-controller.patch || die
	${FILESDIR}/0047-pwm-Add-Loongson-PWM-controller-support.patch || die
	${FILESDIR}/0048-thermal-loongson2-Trivial-code-style-adjustment.patch || die
	${FILESDIR}/0049-dt-bindings-thermal-loongson-ls2k-thermal-Add-Loongs.patch || die
	${FILESDIR}/0050-dt-bindings-thermal-loongson-ls2k-thermal-Fix-incorr.patch || die
	${FILESDIR}/0051-thermal-loongson2-Add-Loongson-2K2000-support.patch || die
	${FILESDIR}/0052-KVM-loongarch-Add-vcpu-id-check-before-create-vcpu.patch || die
	${FILESDIR}/0055-LOONGARCH64-drivers-firmware-Move-sysfb_init-from-de.patch || die
	${FILESDIR}/0056-LOONGARCH64-drm-Makefile-Move-tiny-drivers-before-na.patch || die
	${FILESDIR}/0057-LOONGARCH64-drm-xe-fix-build-on-non-4K-kernels.patch || die
	${FILESDIR}/0058-LOONGARCH64-drm-radeon-Workaround-radeon-driver-bug-.patch || die
	${FILESDIR}/0059-LOONGARCH64-drm-radeon-Call-mmiowb-at-the-end-of-rad.patch || die
	${FILESDIR}/0060-LOONGARCH64-HACK-drm-amdgpu-disable-DPM-in-auto-mode.patch || die
	"

	if use cjk; then
		UNIPATCH_LIST+=" ${FILESDIR}/cjktty-6.7.patch" || die
	fi

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
	elog "AOSC's LoongArch Linux Kernel"
	elog "Use default config in files"
	elog "Please copy to kernel sources dir and using"
}
