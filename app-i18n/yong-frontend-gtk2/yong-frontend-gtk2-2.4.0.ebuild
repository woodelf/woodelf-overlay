# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="GTK2 Frontend for Yong Input Method"
HOMEPAGE="https://github.com/dgod/yong"
SRC_URI="amd64?  ( http://packages.deepin.com/deepin/pool/main/y/yong/yong-frontend-gtk2_2.4.0~20160911~deepin4_amd64.deb )
	x86?    ( http://packages.deepin.com/deepin/pool/main/y/yong/yong-frontend-gtk2_2.4.0~20160911~deepin4_i386.deb )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-i18n/yong-runtime"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
	chmod 755 ${D}/usr
        chown -R root:root ${D}
}
