# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils

ELECTRON_SLOT="8.0"
DESCRIPTION="Shadowsocksr client using electron"
HOMEPAGE="https://github.com/shadowsocksrr/electron-ssr"
SRC_URI="https://github.com/shadowsocksrr/electron-ssr/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="dev-libs/libsodium
	dev-util/electron-bin:${ELECTRON_SLOT}
	x11-themes/hicolor-icon-theme"

#S="${WORKDIR}"

src_install() {
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/electron-ssr" "/usr/bin/electron-ssr"
	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
	insinto "/usr/share/pixmaps"
	doins ${FILESDIR}/${PN}.png
	fperms +x "/opt/${PN}/electron-ssr"
	fperms +x "/opt/${PN}/libffmpeg.so"
	insinto "/usr/share/licenses/${PN}"
	newins "LICENSE.electron.txt" "LICENSE"
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
