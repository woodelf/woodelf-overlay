# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop xdg-utils

DESCRIPTION="Proxy client for Linux"
HOMEPAGE="https://netboost.xyz"
SRC_URI="amd64? ( https://netboost.xyz/apps/NicoVPN.deb -> ${P}.deb )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/gtk+:3
		x11-libs/libnotify
		dev-libs/nss
		x11-libs/libXtst
		x11-misc/xdg-utils
		app-accessibility/at-spi2-core
		dev-libs/libappindicator
		app-crypt/libsecret"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install(){
	tar xvf data.tar.xz -C ${D}
	dosym ../../opt/NicoVPN/${PN} /usr/bin/${PN}
}

pkg_postinst(){
		xdg_desktop_database_update
		xdg_icon_cache_update
}

pkg_postrm(){
		xdg_desktop_database_update
		xdg_icon_cache_update
}
