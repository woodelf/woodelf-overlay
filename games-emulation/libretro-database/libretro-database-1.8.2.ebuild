# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Cheatcode files, content data files and etc. stuff for RetroArch"
HOMEPAGE="https://github.com/libretro/libretro-database"

if [[ ${PV} == *9999 ]]; then
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/libretro/libretro-database.git"
	inherit git-r3
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/libretro/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

src_compile() {
	:
}
