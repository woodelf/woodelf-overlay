# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 eutils meson

DESCRIPTION="A modular Wayland compositor library"
HOMEPAGE="http://swaywm.org/"

EGIT_REPO_URI="https://github.com/swaywm/wlroots"
EGIT_COMMIT="4ed6ee0a4d112711c3764b9b5d0d44ec916fb48a"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~amd64 ~x86"
IUSE="X +caps elogind examples systemd"

RDEPEND="dev-libs/libinput
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/meson
	systemd? ( sys-apps/systemd )
	elogind? ( sys-auth/elogind )
	caps? ( sys-libs/libcap )
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
	X? ( x11-libs/libxcb \
		x11-libs/xcb-util \
		x11-libs/xcb-util-errors \
		x11-libs/xcb-util-image \
		x11-libs/xcb-util-renderutil \
		x11-libs/xcb-util-wm )
	"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_configure() {
	local emesonargs=(
		-Denable-libcap=$(usex caps true false)
		-Denable-systemd=$(usex systemd true false)
		-Denable-elogind=$(usex elogind true false)
		-Denable-xcb_errors=$(usex X true false)
		-Denable-xwayland=$(usex X true false)
		-Denable-x11_backend=$(usex X true false)
		-Denable-examples=$(usex examples true false)
	)

	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
