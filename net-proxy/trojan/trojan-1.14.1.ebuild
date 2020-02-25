# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="An unidentifiable mechanism that helps you bypass GFW"
HOMEPAGE="https://github.com/trojan-gfw/trojan"
SRC_URI="https://github.com/trojan-gfw/trojan/releases/download/v${PV}/${P}-linux-amd64.tar.xz -> ${P}-amd64.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto "/opt"
	doins -r *
	dosym "/opt/${PN}/trojan" "/usr/bin/trojan"
	fperms +x "/opt/${PN}/trojan"
}

pkg_postinst(){
	elog "Please modify your server settings in config.json"
}
