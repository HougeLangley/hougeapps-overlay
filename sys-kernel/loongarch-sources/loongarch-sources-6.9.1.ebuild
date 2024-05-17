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
IUSE="bbr3"

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
AOSC_PATCHES_URI="https://raw.githubusercontent.com/AOSC-Dev/aosc-os-abbs/stable/runtime-kernel/linux-kernel/autobuild/patches"
BBR3_URI="https://gitlab.com/sirlucjan/kernel-patches/-/raw/master/6.9/bbr3-patches"
MAIN_LINUX_URI="https://mirrors.ustc.edu.cn/kernel.org/linux/kernel/v6.x"
SRC_URI="
	${MAIN_LINUX_URI}/linux-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.tar.xz
	${GENPATCHES_URI}
	${BBR3_URI}/0001-tcp-bbr3-initial-import.patch
	${AOSC_PATCHES_URI}/0001-ath9k-rx-dma-stop-check.patch
	${AOSC_PATCHES_URI}/0002-pci-Enable-overrides-for-missing-ACS-capabilities-5..patch
	${AOSC_PATCHES_URI}/0003-cpuinfo-fix-a-warning-for-CONFIG_CPUMASK_OFFSTACK.patch
	${AOSC_PATCHES_URI}/0004-HACK-drm-amdgpu-use-amdgpu-by-default-for-si-cik-dev.patch
	${AOSC_PATCHES_URI}/0005-input-synaptics-pin-3-touches-when-the-firmware-repo.patch
	${AOSC_PATCHES_URI}/0006-hid-logitech-dj-add-support-for-the-new-lightspeed-r.patch
	${AOSC_PATCHES_URI}/0007-hid-add-PixArt-touchpad-driver.patch
	${AOSC_PATCHES_URI}/0008-hid-register-Surface-hid-devices.patch
	${AOSC_PATCHES_URI}/0009-lis3-improve-handling-of-null-rate.patch
	${AOSC_PATCHES_URI}/0010-ethernet-bundle-module-for-Motorcomm-YT6801.patch
	${AOSC_PATCHES_URI}/0011-net-stmmac-Move-the-atds-flag-to-the-stmmac_dma_cfg-.patch
	${AOSC_PATCHES_URI}/0012-net-stmmac-Add-multi-channel-support.patch
	${AOSC_PATCHES_URI}/0013-net-stmmac-Export-dwmac1000_dma_ops.patch
	${AOSC_PATCHES_URI}/0014-net-stmmac-dwmac-loongson-Drop-useless-platform-data.patch
	${AOSC_PATCHES_URI}/0015-net-stmmac-dwmac-loongson-Use-PCI_DEVICE_DATA-macro-.patch
	${AOSC_PATCHES_URI}/0016-net-stmmac-dwmac-loongson-Split-up-the-platform-data.patch
	${AOSC_PATCHES_URI}/0017-net-stmmac-dwmac-loongson-Add-ref-and-ptp-clocks-for.patch
	${AOSC_PATCHES_URI}/0018-net-stmmac-dwmac-loongson-Add-phy-mask-for-Loongson-.patch
	${AOSC_PATCHES_URI}/0019-net-stmmac-dwmac-loongson-Add-phy_interface-for-Loon.patch
	${AOSC_PATCHES_URI}/0020-net-stmmac-dwmac-loongson-Add-full-PCI-support.patch
	${AOSC_PATCHES_URI}/0021-net-stmmac-dwmac-loongson-Add-loongson_dwmac_config_.patch
	${AOSC_PATCHES_URI}/0022-net-stmmac-dwmac-loongson-Fixed-failure-to-set-netwo.patch
	${AOSC_PATCHES_URI}/0023-net-stmmac-dwmac-loongson-Add-Loongson-GNET-support.patch
	${AOSC_PATCHES_URI}/0024-net-stmmac-dwmac-loongson-Move-disable_force-flag-to.patch
	${AOSC_PATCHES_URI}/0025-net-stmmac-dwmac-loongson-Add-loongson-module-author.patch
	${AOSC_PATCHES_URI}/0026-net-stmmac-add-a-glue-driver-for-GMACs-in-Phytium-So.patch
	${AOSC_PATCHES_URI}/0027-x86-add-more-uarches-for-kernel-6.8-rc4.patch
	${AOSC_PATCHES_URI}/0028-arm-usb-phy-tegra-Add-38.4MHz-clock-table-entry.patch
	${AOSC_PATCHES_URI}/0029-arm64-dts-rockchip-change-GMAC-rx_delay-for-RockPro6.patch
	${AOSC_PATCHES_URI}/0030-arm64-dts-rockchip-add-out-of-band-IRQ-for-RK3399-Wi.patch
	${AOSC_PATCHES_URI}/0031-arm64-rockchip-dts-rk3399-fix-PD-on-Pinebook-Pro.patch
	${AOSC_PATCHES_URI}/0032-arm64-add-Kconfig-option-for-Phytium-SoCs.patch
	${AOSC_PATCHES_URI}/0033-arm64-dts-rockchip-disable-usb3-on-quartz64.patch
	${AOSC_PATCHES_URI}/0034-arm64-drop-hisi_ddrc_pmu-driver.patch
	${AOSC_PATCHES_URI}/0035-MIPS-loongson64-disable-writecombine-for-Loongson-3A.patch
	${AOSC_PATCHES_URI}/0036-MIPS-loongson64-init-suppress-memcpy-out-of-bound-ch.patch
	${AOSC_PATCHES_URI}/0037-MIPS-loongson64-video-output-re-introduce-display-ou.patch
	${AOSC_PATCHES_URI}/0038-MIPS-video-fbdev-sis-add-1368x768-resolution.patch
	${AOSC_PATCHES_URI}/0039-LoongArch-Select-ARCH_SUPPORTS_INT128-if-CC_HAS_INT1.patch
	${AOSC_PATCHES_URI}/0040-LoongArch-Define-__ARCH_WANT_NEW_STAT-in-unistd.h.patch
	${AOSC_PATCHES_URI}/0041-LoongArch-rust-Switch-to-use-built-in-rustc-target.patch
	${AOSC_PATCHES_URI}/0042-LoongArch-Add-CPU-HWMon-platform-driver.patch
	${AOSC_PATCHES_URI}/0043-LoongArch-Update-Loongson-3-default-config-file.patch
	${AOSC_PATCHES_URI}/0044-LoongArch-Select-THP_SWAP-if-HAVE_ARCH_TRANSPARENT_H.patch
	${AOSC_PATCHES_URI}/0045-LoongArch-Update-the-flush-cache-policy.patch
	${AOSC_PATCHES_URI}/0046-dt-bindings-pwm-Add-Loongson-PWM-controller.patch
	${AOSC_PATCHES_URI}/0047-pwm-Add-Loongson-PWM-controller-support.patch
	${AOSC_PATCHES_URI}/0048-thermal-loongson2-Trivial-code-style-adjustment.patch
	${AOSC_PATCHES_URI}/0049-dt-bindings-thermal-loongson-ls2k-thermal-Add-Loongs.patch
	${AOSC_PATCHES_URI}/0050-dt-bindings-thermal-loongson-ls2k-thermal-Fix-incorr.patch
	${AOSC_PATCHES_URI}/0051-thermal-loongson2-Add-Loongson-2K2000-support.patch
	${AOSC_PATCHES_URI}/0052-KVM-loongarch-Add-vcpu-id-check-before-create-vcpu.patch
	${AOSC_PATCHES_URI}/0055-LOONGARCH64-drivers-firmware-Move-sysfb_init-from-de.patch.loongarch64 -> 0055-LOONGARCH64-drivers-firmware-Move-sysfb_init-from-de.patch
	${AOSC_PATCHES_URI}/0056-LOONGARCH64-drm-Makefile-Move-tiny-drivers-before-na.patch.loongarch64 -> 0056-LOONGARCH64-drm-Makefile-Move-tiny-drivers-before-na.patch
	${AOSC_PATCHES_URI}/0057-LOONGARCH64-drm-xe-fix-build-on-non-4K-kernels.patch.loongarch64 -> 0057-LOONGARCH64-drm-xe-fix-build-on-non-4K-kernels.patch
	${AOSC_PATCHES_URI}/0058-LOONGARCH64-drm-radeon-Workaround-radeon-driver-bug-.patch.loongarch64 -> 0058-LOONGARCH64-drm-radeon-Workaround-radeon-driver-bug-.patch
	${AOSC_PATCHES_URI}/0059-LOONGARCH64-drm-radeon-Call-mmiowb-at-the-end-of-rad.patch.loongarch64 -> 0059-LOONGARCH64-drm-radeon-Call-mmiowb-at-the-end-of-rad.patch
	${AOSC_PATCHES_URI}/0060-LOONGARCH64-HACK-drm-amdgpu-disable-DPM-in-auto-mode.patch.loongarch64 -> 0060-LOONGARCH64-HACK-drm-amdgpu-disable-DPM-in-auto-mode.patch
"
KEYWORDS="~loong"

K_EXTRAEINFO="For more info on AOSC's LoongArch Kernel and details on how to report problems, see: ${HOMEPAGE}."

src_unpack() {
	UNIPATCH_LIST_DEFAULT="
	${DISTDIR}/0001-ath9k-rx-dma-stop-check.patch || die
	${DISTDIR}/0002-pci-Enable-overrides-for-missing-ACS-capabilities-5..patch || die
	${DISTDIR}/0003-cpuinfo-fix-a-warning-for-CONFIG_CPUMASK_OFFSTACK.patch || die
	${DISTDIR}/0004-HACK-drm-amdgpu-use-amdgpu-by-default-for-si-cik-dev.patch || die
	${DISTDIR}/0005-input-synaptics-pin-3-touches-when-the-firmware-repo.patch || die
	${DISTDIR}/0006-hid-logitech-dj-add-support-for-the-new-lightspeed-r.patch || die
	${DISTDIR}/0007-hid-add-PixArt-touchpad-driver.patch || die
	${DISTDIR}/0008-hid-register-Surface-hid-devices.patch || die
	${DISTDIR}/0009-lis3-improve-handling-of-null-rate.patch || die
	${DISTDIR}/0010-ethernet-bundle-module-for-Motorcomm-YT6801.patch || die
	${DISTDIR}/0011-net-stmmac-Move-the-atds-flag-to-the-stmmac_dma_cfg-.patch || die
	${DISTDIR}/0012-net-stmmac-Add-multi-channel-support.patch || die
	${DISTDIR}/0013-net-stmmac-Export-dwmac1000_dma_ops.patch || die
	${DISTDIR}/0014-net-stmmac-dwmac-loongson-Drop-useless-platform-data.patch || die
	${DISTDIR}/0015-net-stmmac-dwmac-loongson-Use-PCI_DEVICE_DATA-macro-.patch || die
	${DISTDIR}/0016-net-stmmac-dwmac-loongson-Split-up-the-platform-data.patch || die
	${DISTDIR}/0017-net-stmmac-dwmac-loongson-Add-ref-and-ptp-clocks-for.patch || die
	${DISTDIR}/0018-net-stmmac-dwmac-loongson-Add-phy-mask-for-Loongson-.patch || die
	${DISTDIR}/0019-net-stmmac-dwmac-loongson-Add-phy_interface-for-Loon.patch || die
	${DISTDIR}/0020-net-stmmac-dwmac-loongson-Add-full-PCI-support.patch || die
	${DISTDIR}/0021-net-stmmac-dwmac-loongson-Add-loongson_dwmac_config_.patch || die
	${DISTDIR}/0022-net-stmmac-dwmac-loongson-Fixed-failure-to-set-netwo.patch || die
	${DISTDIR}/0023-net-stmmac-dwmac-loongson-Add-Loongson-GNET-support.patch || die
	${DISTDIR}/0024-net-stmmac-dwmac-loongson-Move-disable_force-flag-to.patch || die
	${DISTDIR}/0025-net-stmmac-dwmac-loongson-Add-loongson-module-author.patch || die
	${DISTDIR}/0026-net-stmmac-add-a-glue-driver-for-GMACs-in-Phytium-So.patch || die
	${DISTDIR}/0027-x86-add-more-uarches-for-kernel-6.8-rc4.patch || die
	${DISTDIR}/0028-arm-usb-phy-tegra-Add-38.4MHz-clock-table-entry.patch || die
	${DISTDIR}/0029-arm64-dts-rockchip-change-GMAC-rx_delay-for-RockPro6.patch || die
	${DISTDIR}/0030-arm64-dts-rockchip-add-out-of-band-IRQ-for-RK3399-Wi.patch || die
	${DISTDIR}/0031-arm64-rockchip-dts-rk3399-fix-PD-on-Pinebook-Pro.patch || die
	${DISTDIR}/0032-arm64-add-Kconfig-option-for-Phytium-SoCs.patch || die
	${DISTDIR}/0033-arm64-dts-rockchip-disable-usb3-on-quartz64.patch || die
	${DISTDIR}/0034-arm64-drop-hisi_ddrc_pmu-driver.patch || die
	${DISTDIR}/0035-MIPS-loongson64-disable-writecombine-for-Loongson-3A.patch || die
	${DISTDIR}/0036-MIPS-loongson64-init-suppress-memcpy-out-of-bound-ch.patch || die
	${DISTDIR}/0037-MIPS-loongson64-video-output-re-introduce-display-ou.patch || die
	${DISTDIR}/0038-MIPS-video-fbdev-sis-add-1368x768-resolution.patch || die
	${DISTDIR}/0039-LoongArch-Select-ARCH_SUPPORTS_INT128-if-CC_HAS_INT1.patch || die
	${DISTDIR}/0040-LoongArch-Define-__ARCH_WANT_NEW_STAT-in-unistd.h.patch || die
	${DISTDIR}/0041-LoongArch-rust-Switch-to-use-built-in-rustc-target.patch || die
	${DISTDIR}/0042-LoongArch-Add-CPU-HWMon-platform-driver.patch || die
	${DISTDIR}/0043-LoongArch-Update-Loongson-3-default-config-file.patch || die
	${DISTDIR}/0044-LoongArch-Select-THP_SWAP-if-HAVE_ARCH_TRANSPARENT_H.patch || die
	${DISTDIR}/0045-LoongArch-Update-the-flush-cache-policy.patch || die
	${DISTDIR}/0046-dt-bindings-pwm-Add-Loongson-PWM-controller.patch || die
	${DISTDIR}/0047-pwm-Add-Loongson-PWM-controller-support.patch || die
	${DISTDIR}/0048-thermal-loongson2-Trivial-code-style-adjustment.patch || die
	${DISTDIR}/0049-dt-bindings-thermal-loongson-ls2k-thermal-Add-Loongs.patch || die
	${DISTDIR}/0050-dt-bindings-thermal-loongson-ls2k-thermal-Fix-incorr.patch || die
	${DISTDIR}/0051-thermal-loongson2-Add-Loongson-2K2000-support.patch || die
	${DISTDIR}/0052-KVM-loongarch-Add-vcpu-id-check-before-create-vcpu.patch || die
	${DISTDIR}/0055-LOONGARCH64-drivers-firmware-Move-sysfb_init-from-de.patch || die
	${DISTDIR}/0056-LOONGARCH64-drm-Makefile-Move-tiny-drivers-before-na.patch || die
	${DISTDIR}/0057-LOONGARCH64-drm-xe-fix-build-on-non-4K-kernels.patch || die
	${DISTDIR}/0058-LOONGARCH64-drm-radeon-Workaround-radeon-driver-bug-.patch || die
	${DISTDIR}/0059-LOONGARCH64-drm-radeon-Call-mmiowb-at-the-end-of-rad.patch || die
	${DISTDIR}/0060-LOONGARCH64-HACK-drm-amdgpu-disable-DPM-in-auto-mode.patch || die
	"

	if use bbr3; then
		UNIPATCH_LIST+=" ${DISTDIR}/0001-tcp-bbr3-initial-import.patch" || die
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
