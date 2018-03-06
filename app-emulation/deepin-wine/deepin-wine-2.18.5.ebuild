# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Windows API implementation - standard suite"
COMMON_URI="http://packages.deepin.com/deepin/pool/non-free"
HOMEPAGE="https://www.winehq.org"
SRC_URI="${COMMON_URI}/d/${PN}/${PN}_2.18-5~rc6_all.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emulation/deepin-wine-helper
	app-emulation/deepin-fonts-wine
	app-emulation/deepin-libwine
	app-emulation/deepin-wine32
	app-emulation/deepin-wine-uninstaller
	
	amd64? ( dev-libs/udis86[abi_x86_32] )
	x86? ( dev-libs/udis86 )
	"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
