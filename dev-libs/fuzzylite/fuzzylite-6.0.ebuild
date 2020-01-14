# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake-utils

DESCRIPTION="A Fuzzy Logic Control Library in C++"
HOMEPAGE="http://www.fuzzylite.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="no-c++11 static-libs"

DEPEND=""
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${P}/${PN}"

src_configure() {
    local mycmakeargs=(
		$(cmake-utils_use static-libs FL_BUILD_STATIC)
		-DFL_USE_FLOAT=ON
		-DFL_BACKTRACE=ON
		$(cmake-utils_useno no-c++11 FL_CPP11)
	)

	cmake-utils_src_configure
}
