# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Deepin Wine Uninstaller Tool"
HOMEPAGE="https://www.deepin.org"
SRC_URI="http://packages.deepin.com/deepin/pool/non-free/d/${PN}/${PN}_0.1deepin2_i386.deb"

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
