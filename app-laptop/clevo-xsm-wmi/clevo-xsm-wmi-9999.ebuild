# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-2 linux-mod

DESCRIPTION="WMI driver for Clevo laptops"
HOMEPAGE="https://bitbucket.org/tuxedocomputers/clevo-xsm-wmi"
EGIT_REPO_URI="https://bitbucket.org/tuxedocomputers/clevo-xsm-wmi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="utils"

DEPEND="virtual/linux-sources
	sys-kernel/linux-headers
	utils? ( dev-qt/qtcore:5 )"

RDEPEND="${DEPEND}"

MODULE_NAMES="clevo-xsm-wmi(wmi:${S}/module)"

pkg_pretend() {
	CONFIG_CHECK="ACPI_WMI"
	check_extra_config
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_TARGETS="all"
}

src_prepare() {
	cd "${S}/module"
	sed -i -e "s|KDIR :=.*|KDIR := ${KERNEL_DIR}|" \
	  Makefile || die "Failed to change Makefile"
}

src_compile() {
	cd "${S}/module"
	linux-mod_src_compile

	if use utils; then
	cd "${S}/utility"
	/usr/lib64/qt5/bin/qmake
	default
	fi
}

src_install() {
	cd "${S}/module"
	linux-mod_src_install

	if use utils; then
	cd "${S}/utility"
	install -Dm755 clevo-xsm-wmi ${D}/usr/bin/clevo-xsm-wmi
	install -Dm755 systemd/clevo-xsm-wmi.service ${D}/usr/lib/systemd/system/clevo-xsm-wmi.service
	fi
}
