# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_COMMIT_SHA="ecd4b739d83f76474959087772c086fc9cf568f0"

DESCRIPTION="Vulkan GLSL RetroArch shaders"
HOMEPAGE="https://github.com/libretro/slang-shaders"

if [[ ${PV} == *9999 ]]; then
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/libretro/slang-shaders"

	inherit git-r3
else
	inherit vcs-snapshot

	SRC_URI="https://github.com/libretro/slang-shaders/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}.tar.gz"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
