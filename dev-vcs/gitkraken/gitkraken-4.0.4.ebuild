# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils xdg-utils

DESCRIPTION="The downright luxurious Git client, for Windows, Mac & Linux"
HOMEPAGE="https://www.gitkraken.com"
SRC_URI="https://release.gitkraken.com/linux/${PN}-amd64.tar.gz"

LICENSE="Axosoft"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/python
	dev-libs/libgcrypt:0/20
	dev-libs/nss
	gnome-base/gconf:2
	gnome-base/gvfs
	x11-libs/gtk+:2
	x11-libs/libXtst
	x11-libs/libnotify
	x11-misc/xdg-utils"

RDEPEND="${DEPEND}"

S=$WORKDIR

src_install() {
	insinto "/opt"
	doins -r *
	#chmod 755 ${D}/opt/GitKraken/gitkraken
	dosym "/opt/gitkraken/gitkraken" "/usr/bin/gitkraken"
	insinto "/usr/share/applications"
	fperms +x "/opt/gitkraken/gitkraken"
	doins ${FILESDIR}/${PN}.desktop
	insinto "/usr/share/pixmaps"
	doins ${FILESDIR}/${PN}.png
	insinto "/usr/share/licenses/${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
