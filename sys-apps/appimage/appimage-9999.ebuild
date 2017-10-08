# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-2

DESCRIPTION="Linux apps that run anywhere"
HOMEPAGE="http://appimage.org"
EGIT_REPO_URI="https://github.com/AppImage/AppImageKit.git"
EGIT_MASTER="appimagetool/master"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-arch/libarchive
	app-arch/lz4
	app-arch/xz-utils
	dev-libs/glib
	dev-libs/openssl
	net-misc/zsync
	sys-apps/coreutils
	sys-devel/binutils
	sys-fs/fuse
	sys-fs/inotify-tools
	sys-libs/glibc
	sys-libs/zlib"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	./build.sh --clean
	sed -i "s/find /#find /g" build-appdirs.sh
}

src_compile() {
	./build.sh --no-dependencies --use-shared-libs

	# Copy metainfo files
	mkdir -p appimagetool.AppDir/usr/share/metainfo/
	mkdir -p appimaged.AppDir/usr/share/metainfo/

	cp resources/usr/share/metainfo/appimagetool.appdata.xml appimagetool.AppDir/usr/share/metainfo/
	cp resources/usr/share/metainfo/appimaged.appdata.xml appimaged.AppDir/usr/share/metainfo/

	# Generate appimage files
	appimagetool.AppDir/AppRun -n appimagetool.AppDir appimagetool
	appimagetool.AppDir/AppRun -n appimaged.AppDir appimaged
}

src_install() {
	mkdir -p ${D}/usr/share/appimage

	cp appimagetool ${D}/usr/bin/
	cp appimaged ${D}/usr/bin/

	cp AppRun.c ${D}/usr/share/appimage/
	cp README.md ${D}/usr/share/appimage/

	insinto "/usr/lib/systemd/user"
	doins ${FILESDIR}/appimaged.service
}
