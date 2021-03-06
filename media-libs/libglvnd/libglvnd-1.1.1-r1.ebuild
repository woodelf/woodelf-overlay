# Copyright 2018-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/NVIDIA/${PN}.git"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
fi

PYTHON_COMPAT=( python2_7 )
inherit autotools ${GIT_ECLASS} multilib-minimal python-any-r1

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://github.com/NVIDIA/libglvnd"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/NVIDIA/${PN}/releases/download/v${PV}/${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	!media-libs/mesa[-libglvnd(-)]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	"
DEPEND="${PYTHON_DEPS}
	${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/add-pkgconfig-files.patch
	#"${FILESDIR}"/update-gl-glx-header.patch
	#"${FILESDIR}"/update-egl-header.patch
	#"${FILESDIR}"/add-missing-gl-gles-header.patch
	#"${FILESDIR}"/add-gl-header-option.patch
	#"${FILESDIR}"/install-headers.patch
)

src_prepare() {
	default
	[[ $PV = 9999* ]] && eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE=${S} econf
}

multilib_src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

multilib_src_test() {
	emake check
}
