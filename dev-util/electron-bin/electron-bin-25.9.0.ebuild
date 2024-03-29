# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"
SRC_URI_BASE="https://github.com/electron/electron/releases/download"
DESCRIPTION="Cross platform application development framework based on web technologies"
HOMEPAGE="https://electron.atom.io"
SRC_URI="
	amd64? ( ${SRC_URI_BASE}/v${PV}/${MY_PN}-v${PV}-linux-x64.zip -> ${P}-x64.zip )
"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="23.0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nss
	gnome-base/gconf:2
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig:1.0
	media-libs/libepoxy
	media-libs/libpng
	net-print/cups
	sys-apps/dbus
	virtual/opengl
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libxcb
	x11-libs/libXtst
	x11-libs/pango
"
DEPEND="app-arch/unzip"

S="${WORKDIR}"
DIRPATH="opt/${MY_PN}-${SLOT}"

QA_PRESTRIPPED="
	${DIRPATH}/libffmpeg.so
	${DIRPATH}/libnode.so
	${DIRPATH}/electron
"

src_install() {
	dodir "/${DIRPATH}"
	# Note: intentionally not using "doins" so that we preserve +x bits
	cp -R ./* "${ED}/${DIRPATH}" || die

	dosym "../../${DIRPATH}/electron" "/usr/bin/electron-${SLOT}"
}
