# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Tencent TIM Client on Deepin Wine"
COMMON_URI="http://packages.deepin.com/deepin/pool/non-free"
HOMEPAGE="https://im.qq.com"
SRC_URI="${COMMON_URI}/d/deepin.com.qq.office/deepin.com.qq.office_2.0.0deepin4_i386.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emulation/deepin-wine
	app-emulation/deepin-wine-helper
	app-emulation/deepin-fonts-wine
	app-emulation/deepin-libwine
	app-emulation/deepin-wine32
	app-emulation/deepin-wine-uninstaller"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
