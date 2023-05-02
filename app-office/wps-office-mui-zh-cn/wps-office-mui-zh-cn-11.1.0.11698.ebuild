# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PV="$(ver_cut 4)"

DESCRIPTION="Chinese (Simplified) mui package for WPS Office"
HOMEPAGE="http://www.wps.cn/product/wpslinux/ http://wps-community.org/"
SRC_URI="https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/${MY_PV}/wps-office_${PV}_amd64.deb"

SLOT="0"
RESTRICT="strip mirror" # mirror as explained at bug #547372
LICENSE="WPS-EULA"
IUSE="systemd"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto /opt/kingsoft/wps-office/office6/
	cd "${WORKDIR}/opt/kingsoft/wps-office/office6/"
	doins -r mui
}
