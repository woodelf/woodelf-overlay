# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils unpacker versionator

DESCRIPTION="A better WeChat on Mac OS X and Linux."
HOMEPAGE="https://github.com/kooritea/electronic-wechat"
SRC_BASE="https://github.com/kooritea/${PN}/releases/download/v${PV}"
SRC_URI="${SRC_BASE}/${PN}-linux-x64-${PV}.zip -> ${P}-amd64.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="dev-lang/python
	dev-libs/libappindicator:3
	dev-util/electron-bin:6.0
	dev-vcs/git
	media-gfx/imagemagick
	net-libs/nodejs
	x11-themes/hicolor-icon-theme"

S=${WORKDIR}

src_prepare(){
	mv electronic-wechat* ${PN}
}

src_install() {
	insinto /opt
	doins -r ${S}/${PN}
	fperms 0755 /opt/${PN}/electronic-wechat
	dosym "/opt/${PN}/electronic-wechat" /usr/bin/electronic-wechat
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/${PN}.png
}
