# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Baidu Cloud client written by Go"
HOMEPAGE="https://github.com/iikira/BaiduPCS-Go"
SRC_URI="https://github.com/iikira/BaiduPCS-Go/releases/download/v${PV}/${PN}-v${PV}-linux-amd64.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}-linux-amd64"

src_install(){
	insinto "/opt/${PN}"
	doins -r *
	fperms +x "/opt/${PN}/${PN}"
}
