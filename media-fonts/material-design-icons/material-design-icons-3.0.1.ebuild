# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Material Design icons by Google"
HOMEPAGE="http://google.github.io/material-design-icons"
SRC_URI="https://github.com/google/material-design-icons/releases/download/3.0.1/${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S="${S}/${P}/iconfont"

src_install(){
	font_src_install
}
