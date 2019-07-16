# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Windows API implementation - library"
COMMON_URI="http://packages.deepin.com/deepin/pool/non-free"
HOMEPAGE="https://www.winehq.org"
SRC_URI="${COMMON_URI}/d/deepin-wine/${PN}_2.18-18_i386.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-util/desktop-file-utils
	sys-devel/gcc

	amd64? (
		dev-libs/libxml2[abi_x86_32]
		media-libs/alsa-lib[abi_x86_32]
		media-libs/fontconfig[abi_x86_32]
		media-libs/freetype[abi_x86_32]
		media-libs/glu[abi_x86_32]
		media-libs/lcms[abi_x86_32]
		media-libs/mesa[abi_x86_32]
		net-libs/libpcap[abi_x86_32]
		sys-devel/gettext[abi_x86_32]
		x11-libs/libSM[abi_x86_32]
		x11-libs/libXcursor[abi_x86_32]
		x11-libs/libXdamage[abi_x86_32]
		x11-libs/libXi[abi_x86_32]
		x11-libs/libXrandr[abi_x86_32]
		)

	x86? (
		dev-libs/libxml2
		media-libs/alsa-lib
		media-libs/fontconfig
		media-libs/freetype
		media-libs/glu
		media-libs/lcms
		media-libs/mesa
		net-libs/libpcap
		sys-devel/gettext
		x11-libs/libSM
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXi
		x11-libs/libXrandr
		)"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
