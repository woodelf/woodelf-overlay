# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Windows API implementation - standard suite"
COMMON_URI="http://packages.deepin.com/deepin/pool/non-free"
HOMEPAGE="https://www.deepin.org"
SRC_URI="${COMMON_URI}/d/${PN}/${PN}_1.1-0_amd64.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/p7zip
		app-crypt/p11-kit
		dev-db/unixODBC
		dev-libs/libbsd
		dev-libs/libxslt
		dev-libs/openssl
		media-gfx/sane-backends
		media-libs/fontconfig
		media-libs/freetype
		media-libs/giflib
		media-libs/gst-plugins-base
		media-libs/gstreamer
		media-libs/libgphoto2
		media-libs/libjpeg-turbo
		media-libs/libpng
		media-libs/libv4l
		media-libs/mesa
		media-sound/gsm
		net-libs/gnutls
		net-libs/libcapi
		net-print/cups
		sys-apps/dbus
		x11-libs/libXcomposite
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXt"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
