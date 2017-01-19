# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="
	amd64? ( https://az764295.vo.msecnd.net/stable/ee428b0eead68bf0fb99ab5fdc4439be227b6281/code-stable-code_1.8.1-1482158209_amd64.tar.gz -> ${P}-amd64.tar.gz )
	x86? ( https://az764295.vo.msecnd.net/stable/ee428b0eead68bf0fb99ab5fdc4439be227b6281/code-stable-code_1.8.1-1482159060_i386.tar.gz -> ${P}-i386.tar.gz )"
RESTRICT="mirror"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
"

RDEPEND="${DEPEND}"

ARCH="$(uname -m)"

if [[ $ARCH == "x86_64" ]];then
	S="${WORKDIR}/VSCode-linux-x64"
else
	S="${WORKDIR}/VSCode-linux-ia32"
fi


src_install(){
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/code" "/usr/bin/visual-studio-code"
	insinto "/usr/share/applications"
	doins ${FILESDIR}/${PN}.desktop
	insinto "/usr/share/pixmaps"
	doins ${FILESDIR}/${PN}.png
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/bin/code"
	fperms +x "/opt/${PN}/libffmpeg.so"
	fperms +x "/opt/${PN}/libnode.so"
	insinto "/usr/share/licenses/${PN}"
	newins "resources/app/LICENSE.txt" "LICENSE"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
