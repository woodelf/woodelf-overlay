# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils meson

DESCRIPTION="i3-compatible Wayland window manager"
HOMEPAGE="http://swaywm.org/"

SRC_URI="https://github.com/swaywm/sway/archive/1.0-alpha.5.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~amd64 ~x86"
IUSE="+gdk-pixbuf +swaybar +swaybg swaygrab swaylock +swaymsg systemd +tray wallpapers zsh-completion"

REQUIRED_USE="tray? ( swaybar )"

RDEPEND=">=dev-libs/wlc-0.0.8[systemd=]
	dev-libs/json-c:0=
	dev-libs/libpcre
	dev-libs/libinput
	dev-libs/wayland
	dev-libs/wlroots
	sys-libs/libcap
	x11-libs/libxkbcommon
	x11-libs/cairo
	x11-libs/pango
	gdk-pixbuf? ( x11-libs/gdk-pixbuf[jpeg] )
	swaylock? ( virtual/pam )
	tray? ( sys-apps/dbus )"

DEPEND="${RDEPEND}
	app-text/scdoc
	virtual/pkgconfig"

S="${WORKDIR}/sway-1.0-alpha.4"

src_configure() {
	local emesonargs=(
		-Ddefault_wallpaper=$(usex wallpapers true false)
		-Dzsh_completions=$(usex zsh-completion true false)
	)

	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install

	use !systemd && fperms u+s /usr/bin/sway
}

pkg_postinst() {
	if use swaygrab
	then
		optfeature "swaygrab screenshot support" media-gfx/imagemagick[png]
		optfeature "swaygrab video capture support" virtual/ffmpeg
	fi
	if use tray
	then
		optfeature "experimental xembed tray icons support" \
			x11-misc/xembedsniproxy
	fi

	optfeature "X11 applications support" dev-libs/wlc[xwayland] x11-base/xorg-server[wayland]
}
