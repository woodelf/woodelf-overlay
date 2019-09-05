# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="Baidu Net Disk is a cloud storage client (Linux Version)."
HOMEPAGE="https://pan.baidu.com"
SRC_URI="http://issuecdn.baidupcs.com/issue/netdisk/LinuxGuanjia/${PV}/${PN}_linux_${PV}.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/nss
		x11-libs/gtk+:3"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
	dosym "/opt/baidunetdisk/baidunetdisk" "/usr/bin/baidunetdisk"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
    xdg_desktop_database_update
}
