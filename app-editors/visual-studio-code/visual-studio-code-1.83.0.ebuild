# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils xdg-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="
	amd64? ( https://az764295.vo.msecnd.net/stable/e7e037083ff4455cf320e344325dacb480062c3c/code-stable-x64-1696349520.tar.gz -> ${P}-amd64.tar.gz )
	arm? ( https://az764295.vo.msecnd.net/stable/e7e037083ff4455cf320e344325dacb480062c3c/code-stable-armhf-1696349533.tar.gz -> ${P}-armhf.tar.gz )
	arm64? ( https://az764295.vo.msecnd.net/stable/e7e037083ff4455cf320e344325dacb480062c3c/code-stable-arm64-1696349537.tar.gz -> ${P}-arm64.tar.gz )"
RESTRICT="mirror"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
IUSE=""

DEPEND="
	>=media-libs/libpng-1.2.46
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install(){
	cd VSCode-linux-x64
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
	insinto "/usr/share/licenses/${PN}"
	newins "resources/app/LICENSE.rtf" "LICENSE"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}