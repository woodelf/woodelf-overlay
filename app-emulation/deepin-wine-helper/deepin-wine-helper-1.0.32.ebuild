# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Windows API implementation - standard suite"
COMMON_URI="http://packages.deepin.com/deepin/pool/non-free"
HOMEPAGE="https://www.deepin.org"
SRC_URI="${COMMON_URI}/d/${PN}/${PN}_1.0deepin32_i386.deb"

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/p7zip

	amd64? (
		app-crypt/p11-kit[abi_x86_32]
		dev-db/unixODBC[abi_x86_32]
		dev-libs/libbsd[abi_x86_32]
		dev-libs/libxslt[abi_x86_32]
		dev-libs/openssl[abi_x86_32]
		media-gfx/sane-backends[abi_x86_32]
		media-libs/fontconfig[abi_x86_32]
		media-libs/freetype[abi_x86_32]
		media-libs/giflib[abi_x86_32]
		media-libs/gst-plugins-base[abi_x86_32]
		media-libs/gstreamer[abi_x86_32]
		media-libs/libgphoto2[abi_x86_32]
		media-libs/libjpeg-turbo[abi_x86_32]
		media-libs/libpng[abi_x86_32]
		media-libs/libv4l[abi_x86_32]
		media-libs/mesa[abi_x86_32]
		media-sound/gsm[abi_x86_32]
		net-libs/gnutls[abi_x86_32]
		net-libs/libcapi[abi_x86_32]
		net-print/cups[abi_x86_32]
		sys-apps/dbus[abi_x86_32]
		x11-libs/libXcomposite[abi_x86_32]
		x11-libs/libXi[abi_x86_32]
		x11-libs/libXinerama[abi_x86_32]
		x11-libs/libXrandr[abi_x86_32]
		x11-libs/libXrender[abi_x86_32]
		x11-libs/libXt[abi_x86_32]
		)

	x86? (
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
		x11-libs/libXt
		)"

RDEPEND="${DEPEND}"

RESTRICT="mirror strip"

S=$WORKDIR

src_install() {
	tar xvf data.tar.xz -C ${D}
}
