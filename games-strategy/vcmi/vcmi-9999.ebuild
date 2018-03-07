# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils games cmake-utils git-r3 gnome2-utils

DESCRIPTION="Heroes of Might and Magic III game engine rewrite"
HOMEPAGE="http://forum.vcmi.eu/index.php"
SRC_URI=""
EGIT_REPO_URI="https://github.com/${PN}/${PN}"
EGIT_BRANCH="develop"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug editor launcher +erm"

CDEPEND="
	media-libs/libsdl2[video]
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	virtual/ffmpeg
	sys-libs/zlib[minizip]
	editor? (
		dev-qt/qtgui
		dev-qt/qtcore
		dev-qt/qtwidgets
	)
	launcher? (
		dev-qt/qtgui
		dev-qt/qtcore
		dev-qt/qtnetwork
		dev-qt/qtwidgets
	)
"

DEPEND="
	>dev-libs/boost-1.48.0
	virtual/pkgconfig
	${CDEPEND}
"
RDEPEND="
	${CDEPEND}
"
PDEPEND="
	games-strategy/vcmi-data
"

src_prepare() {
	cmake-utils_src_prepare
	epatch_user
}

src_configure() {
	local mycmakeargs=(
		-DBIN_DIR="${GAMES_BINDIR#/usr/}"
		-DDATA_DIR="${GAMES_DATADIR#/usr/}"/"${PN}"
		-DLIB_DIR="${GAMES_PREFIX#/usr/}"/$(get_libdir)/"${PN}"
		-DENABLE_PCH=OFF # Do not works with NDEBUG set
		-DENABLE_TEST=OFF
		$(cmake-utils_use_enable editor)
		$(cmake-utils_use_enable erm)
		$(cmake-utils_use_enable launcher)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs

	elog "In order to play VCMI you must install:"
	elog "- Heroes III: Shadow of Death or Complete edition;"
	elog "- Unnoficial WoG addon;"
	elog "- VCMI data files."
	elog "Use vcmibuilder tool for automated install of data files;"
	elog "Additional information can be found in VCMI wiki:"
	elog "http://wiki.vcmi.eu/index.php?title=Installation_on_Linux#Installing_Heroes_III_data_files"

}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
