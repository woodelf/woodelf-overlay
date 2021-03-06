# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Download Manager for Windows, Mac & Linux"
HOMEPAGE="https://flareget.com/"
SRC_URI="amd64?  ( https://flareget.com/downloads/files/flareget/debs/amd64/flareget_4.8-108_amd64.deb )
	x86?    ( https://flareget.com/downloads/files/flareget/debs/i386/flareget_4.8-108_i386.deb )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-qt/qtcore-4.8.1
	>=dev-qt/qtgui-4.8.1
	>=dev-qt/qtnetwork-4.8.1"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
