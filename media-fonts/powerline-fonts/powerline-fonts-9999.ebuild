# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Enforce Bash scrictness.
set -e

EGIT_REPO_URI="https://github.com/powerline/fonts"

inherit font git-r3

DESCRIPTION="Monospaced fonts pre-patched with Powerline symbols"
HOMEPAGE="https://github.com/powerline/fonts"

LICENSE="3270? ( BSD-3.0 )
	anonymouspro? ( OFL-1.1 )
	arimo? ( Apache-2.0 )
	cousine? ( Apache-2.0 )
	d2coding? ( OFL-1.1 )
	dejavusansmono? ( BitstreamVera )
	droidsansmono? ( Apache-2.0 )
	droidsansmonodotted? ( Apache-2.0 )
	droidsansmonoslashed? ( Apache-2.0 )
	firamono? ( OFL-1.1 )
	gomono? ( BSD-2.0 )
	hack? ( OFL/BitstreamVera )
	inconsolata-g? ( OFL-1.0 )
	inconsolata? ( OFL-1.0 )
	inconsolatadz? ( OFL-1.0 )
	liberationmono? ( OFL-1.1 )
	meslodotted? ( Apache-2.0 )
	mesloslashed? ( Apache-2.0 )
	monofur? ( OFL )
	notomono? ( OFL-1.1 )
	novamono? ( OFL-1.1 )
	profont? ( MIT )
	robotomono? ( Apache-2.0 )
	sourcecodepro? ( OFL-1.1 )
	spacemono? ( OFL-1.1 )
	symbolneu? ( Apache-2.0 )
	terminus_pcf? ( OFL-1.1 )
	tinos? ( Apache-2.0 )
	ubuntumono? ( UbuntuFontLicense-1.0 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"

# src_install() expects USE flags to be the lowercase basenames of the
# corresponding font directories. See src_install_font() for details.
IUSE_FLAGS=(
	3270
	anonymouspro
	arimo
	cousine
	d2coding
	dejavusansmono
	droidsansmono
	droidsansmonodotted
	droidsansmonoslashed
	firamono
	gomono
	hack
	inconsolata-g
	inconsolata
	inconsolatadz
	liberationmono
	meslodotted
	mesloslashed
	monofur
	notomono
	novamono
	profont
	robotomono
	sourcecodepro
	spacemono
	symbolneu
	terminus_pcf
	tinos
	ubuntumono
)
IUSE="${IUSE_FLAGS[*]}"

# If no such USE flags were enabled, fail.
REQUIRED_USE="|| ( ${IUSE_FLAGS[*]} )"

DEPEND=""
RDEPEND=""

# Temporary directory to which all fonts to be installed will be copied.
# Ideally, such fonts could simply be installed from their default directories;
# sadly, eclass "font" assumes such fonts always reside in a single directory.
FONT_S="${S}/fonts"
DOCS="README.rst"

src_install() {
	mkdir -p "${FONT_S}"

	# Map of all font filetypes to be installed and hence appended to eclass
	# "font" string global ${FONT_SUFFIX} below. Since we only leverage such map
	# for its keys, we map all keys to the empty string.
	declare -A font_filetypes

	# Copy all fonts in the passed directory with the passed filetype to a
	# temporary directory for subsequent installation if the corresponding USE
	# flag is enabled or return silently otherwise.
	src_install_font() {
		(( ${#} == 2 )) || die 'Expected one dirname and one filetype.'
		local dirname="${1}" filetype="${2}" flag_name
		flag_name="${dirname,,}"

		if use "${flag_name}"; then
			mv ${dirname}/*.${filetype} "${FONT_S}"
			font_filetypes[${filetype}]=
			newdoc ${dirname}/README.rst README_${dirname}.rst
		fi
	}

	# Copy all fonts to be installed to a temporary directory.
	src_install_font 3270 ttf
	src_install_font AnonymousPro ttf
	src_install_font Arimo ttf
	src_install_font Cousine ttf
	src_install_font D2Coding ttf
	src_install_font DejaVuSansMono ttf
	src_install_font DroidSansMono otf
	src_install_font DroidSansMonoDotted ttf
	src_install_font DroidSansMonoSlashed ttf
	src_install_font FiraMono otf
	src_install_font GoMono ttf
	src_install_font Hack ttf
	src_install_font Inconsolata-g otf
	src_install_font Inconsolata otf
	src_install_font InconsolataDz otf
	src_install_font LiberationMono ttf
	src_install_font NotoMono ttf
	src_install_font NovaMono ttf
	src_install_font ProFont ttf
	src_install_font RobotoMono ttf
	src_install_font SourceCodePro otf
	src_install_font SpaceMono ttf
	src_install_font SymbolNeu ttf
	src_install_font Tinos ttf
	src_install_font UbuntuMono ttf

	# Terminus is a bitmap- rather than vector-based font and hence requires
	# unique handling. In particular, the repository provides three variants of
	# such patched font: in BDF, PCF, and PSF format. Since X.org is
	# incompatible with PSF-formatted fonts and since PCF-formatted fonts are
	# more space efficient than BDF-formatted fonts, install only the Terminus
	# fonts in PCF format. This corresponds to the "terminus" ebuild, as well.
	if use terminus_pcf; then
		mv Terminus/PCF/*.pcf.gz "${FONT_S}"
		font_filetypes[pcf.gz]=
		newdoc Terminus/README.rst README_Terminus.rst
	fi

	# Meslo fonts directory names contain spaces, thus they requires unique
	# handling.
	if use mesloslashed; then
		mv "Meslo Dotted"/*.ttf "${FONT_S}"
                font_filetypes[ttf]=
                newdoc "Meslo Dotted"/README.rst README_meslodotted.rst
        fi

	if use meslodotted; then
                mv "Meslo Slashed"/*.ttf "${FONT_S}"
                font_filetypes[ttf]=
                newdoc "Meslo Slashed"/README.rst README_mesloslashed.rst
        fi

	# Monofur fonts have no README.rst.
	if use monofur; then
		mv Monofur/*.ttf "${FONT_S}"
                font_filetypes[ttf]=
        fi

	# Convert the above map of all font filetypes to be installed into the
	# whitespace-delimited string global accepted by eclass "font".
	FONT_SUFFIX="${!font_filetypes[@]}"

	# Install all such fonts.
	font_src_install
}
