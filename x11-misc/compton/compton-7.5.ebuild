# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop meson xdg

DESCRIPTION="Compton is a X compositing window manager, fork of xcompmgr-dana."
HOMEPAGE="https://github.com/yshui/compton"
KEYWORDS="~amd64 ~x86"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/yshui/compton"
else
	MY_PV="${PV/_rc/-rc}"
	SRC_URI="${HOMEPAGE}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

LICENSE="MPL-2.0 MIT"
SLOT="0"
IUSE="dbus drm +doc +libconfig +opengl +pcre"

RDEPEND="
	dev-libs/libev
	>=x11-libs/libxcb-1.9.2
	x11-libs/libXext
	x11-libs/libXdamage
	x11-libs/libXrender
	x11-libs/libXrandr
	x11-libs/libXcomposite
	x11-libs/pixman
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-renderutil
	dbus? ( sys-apps/dbus )
	drm? ( x11-libs/libdrm )
	libconfig? (
		>=dev-libs/libconfig-1.4:=
		dev-libs/libxdg-basedir
	)
	opengl? ( virtual/opengl )
	pcre? ( >=dev-libs/libpcre-8.20:3 )"
DEPEND="${RDEPEND}
	dev-libs/uthash"
BDEPEND="doc? ( app-text/asciidoc )"

src_configure() {
	# TODO: support FEATURES=test properly
	local emesonargs=(
		"$(meson_use dbus)"
		"$(meson_use doc build_docs)"
		"$(meson_use drm vsync_drm)"
		"$(meson_use libconfig config_file)"
		"$(meson_use opengl)"
		"$(meson_use pcre regex)"
	)
	meson_src_configure
}

src_install() {
	dodoc CONTRIBUTORS

	docinto examples
	dodoc compton-*-fshader-win.glsl compton.sample.conf
	if use dbus; then
		dodoc -r dbus-examples/
	fi

	meson_src_install
}
