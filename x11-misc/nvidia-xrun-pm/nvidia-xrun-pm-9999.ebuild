# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3 systemd

DESCRIPTION="Script to run dedicated X server with discrete nvidia graphics"
HOMEPAGE="https://github.com/michelesr/nvidia-xrun-pm"
EGIT_REPO_URI="https://github.com/michelesr/nvidia-xrun-pm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
		media-libs/mesa
		x11-apps/xinit
		x11-base/xorg-server[xorg]
		x11-drivers/nvidia-drivers[X,driver]
		x11-libs/libXrandr"

src_prepare() {
		sed -in -e "/\/nvidia\/xorg\/modules/d" -e "s/\/nvidia/\/opengl\/nvidia/g" nvidia-xorg.conf
		sed -in -e "s/\/nvidia/\/opengl\/nvidia\/lib/g" nvidia-xinitrc
		eapply_user
}

src_install() {
		dobin nvidia-xrun
		insinto /etc/X11
		doins nvidia-xorg.conf
		insinto /etc/X11/xinit
		doins nvidia-xinitrc

		systemd_dounit nvidia-xrun-pm.service
}
