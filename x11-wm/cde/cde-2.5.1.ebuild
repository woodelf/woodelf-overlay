# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Common Desktop Environment, the first UNIX desktop environment"
HOMEPAGE="https://sourceforge.net/projects/cdesktopenv/"
SRC_URI="http://sourceforge.net/projects/cdesktopenv/files/src/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libXp
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXpm
	x11-libs/motif
	x11-libs/libXaw
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-apps/xset
	media-libs/libjpeg-turbo
	media-libs/freetype
	dev-lang/tcl
	app-shells/ksh
	sys-devel/m4
	app-arch/ncompress
	media-fonts/font-bitstream-100dpi
	net-nds/rpcbind
	sys-devel/bison
	x11-misc/xbitmaps"
RDEPEND="${DEPEND}"

src_prepare() {
	cd ${S}
	mkdir -p imports/x11/include || die "fail to update code tree"
	cd imports/x11/include
	ln -s /usr/include/X11 . || die "fail to create X11 includes symlink"
}

src_compile() {
	cd ${S}
	make World || die "fail to build the CDE"
}

src_install() {
	default
	# vanilla script seems to be incompatibe with portage
	#cd ${S}/admin/IntegTools/dbTools || die "fail to cd to admin directory"
	#./installCDE -s ${S} || die "fail to install the CDE"
}

pkg_postinst() {
	cd ${S}/admin/IntegTools/post_install/linux || die "fail to cd to linux postinstall check directory"
	./configRun -e || die "linux postinstall check failed"
	einfo "This may terminate with inetd errors. These are harmless and can be ignored."

	# Not sure if it is really necessary, so commented quote:
	#chmod -R a+rwx /var/dt

	dodir /usr/spool/calendar || die "fail to create calendar spool directory"
}
