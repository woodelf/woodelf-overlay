# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Nvidia PRIME Render Offload Script"
HOMEPAGE="https://github.com/woodelf"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	x11-drivers/nvidia-drivers
"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install(){
	insinto "/usr/bin"
	doins ${FILESDIR}/${PN}
	fperms +x "/usr/bin/${PN}"
}
