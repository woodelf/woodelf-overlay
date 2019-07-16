# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Windows API implementation - fonts"
COMMON_URI="http://packages.deepin.com/deepin/pool/non-free"
HOMEPAGE="https://www.winehq.org"
SRC_URI="${COMMON_URI}/d/deepin-wine/${PN}_2.18-18_all.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
