# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="MiTalk Messenger"
HOMEPAGE="http://www.miliao.com"
SRC_URI="https://s1.zb.mi.com/miliao/apk/miliao/7.4/MiTalk_${PV}.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libappindicator
	dev-libs/nss
	gnome-base/gconf
	x11-libs/libnotify
	x11-libs/libXrandr
	x11-libs/libXtst"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
	dosym "/opt/MiTalk/mitalk" "/usr/bin/mitalk"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
    xdg_desktop_database_update
}
