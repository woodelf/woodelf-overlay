# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="Tencent Video is a video client for QQTV."
HOMEPAGE="https://v.qq.com"
SRC_URI="https://dldir1.qq.com/qqtv/linux/Tenvideo_universal_${PV}_amd64.deb -> ${P}.deb"

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
	dosym "/opt/腾讯视频/TencentVideo" "/usr/bin/tencentvideo"
	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
	insinto "/usr/share/pixmaps"
	doins ${FILESDIR}/${PN}.png
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
