# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils

ELECTRON_SLOT="7.0"
DESCRIPTION="The intuitive, fast, and beautiful cross-platform Git client"
HOMEPAGE="https://www.gitkraken.com"
SRC_URI="https://release.gitkraken.com/linux/GitKraken-v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="gitkraken-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="dev-lang/python
	dev-libs/libgcrypt:0/20
	dev-libs/nss
	dev-util/electron-bin:${ELECTRON_SLOT}
	gnome-base/gconf:2
	gnome-base/gvfs
	x11-libs/gtk+:2
	x11-libs/libXtst
	x11-libs/libnotify
	x11-misc/xdg-utils"

QA_PREBUILT="usr/libexec/gitkraken/app.asar.unpacked/node_modules/*"

S="${WORKDIR}/gitkraken"

src_install() {
	newbin "${FILESDIR}"/gitkraken-launcher.sh-r1 gitkraken
	sed "s:%%ELECTRON%%:electron-${ELECTRON_SLOT}:" \
		-i "${ED%/}"/usr/bin/gitkraken || die

	# Note: intentionally not using "doins" so that we preserve +x bits
	dodir /usr/libexec/gitkraken
	cp -R resources/app.asar{,.unpacked} "${ED%/}"/usr/libexec/gitkraken || die

	dosym libcurl.so.4 "/usr/$(get_libdir)/libcurl-gnutls.so.4"

	doicon -s 512 "${FILESDIR}"/gitkraken.png
	make_desktop_entry gitkraken GitKraken gitkraken Development
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
