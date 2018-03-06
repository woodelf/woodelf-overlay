# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit webapp

DESCRIPTION="AriaNg, a modern web frontend making aria2 easier to use"
HOMEPAGE="http://ariang.mayswind.net"
SRC_URI="https://github.com/mayswind/AriaNg/releases/download/${PV}/${P}.zip"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${WEBAPP_DEPEND}"
RDEPEND="${DEPEND}"

INSTALL_DIR="aria-ng"

S="${WORKDIR}"

src_install() {
	webapp_src_preinst
	cp -R css fonts js langs index.html robots.txt "${D}/${MY_HTDOCSDIR}"
	webapp_src_install
}
