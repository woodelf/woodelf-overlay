# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Windows API implementation - 32-bit binary loader"
COMMON_URI="http://packages.deepin.com/deepin/pool/non-free"
HOMEPAGE="https://www.deepin.org"
SRC_URI="${COMMON_URI}/d/deepin-wine/${PN}_2.18-14~rc1_i386.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-emulation/deepin-libwine
	media-libs/mesa[abi_x86_32]"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
