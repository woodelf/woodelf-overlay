# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="Typora — a minimal markdown reading & writing app"
HOMEPAGE="https://typora.io"
SRC_URI="
	amd64? ( https://typora.io/linux/Typora-linux-x64.tar.gz -> ${P}-amd64.tar.gz )
	x86? ( https://typora.io/linux/Typora-linux-ia32.tar.gz -> ${P}-i386.tar.gz )"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	gnome-base/libgnome-keyring"

RESTRICT="mirror strip"

S="${WORKDIR}"

src_install() {
	ARCH="$(uname -m)"
	if [[ $ARCH == "x86_64" ]];then
		cd Typora-linux-x64
	else
		cd Typora-linux-ia32
	fi

	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/Typora" "/usr/bin/typora"
	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
	insinto "/usr/share/pixmaps"
	doins ${FILESDIR}/${PN}.png
	fperms +x "/opt/${PN}/Typora"
	fperms +x "/opt/${PN}/libffmpeg.so"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
