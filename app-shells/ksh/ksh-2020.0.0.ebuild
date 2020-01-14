# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs prefix eutils

DESCRIPTION="The Original Korn Shell, 1993 revision (ksh93)"
HOMEPAGE="http://www.kornshell.com/"

#COMMIT="96d1960c18f9ea93fde5f999bc5450d636d45163"
SRC_URI="https://github.com/att/ast/releases/download/${PV}/${P}.tar.gz"

LICENSE="CPL-1.0 EPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="!app-shells/pdksh"

S="${WORKDIR}/ast-${COMMIT}"

PATCHES=(
	"${FILESDIR}"/ksh-prefix.patch
	"${FILESDIR}"/cpp.patch
	"${FILESDIR}"/glibc.patch
)

src_prepare() {
	default

	# Bug 238906.
	sed -i -e 's,cd /tmp,cd "${TMPDIR:-/tmp}",' \
		bin/package src/cmd/INIT/package.sh || die

	eprefixify src/cmd/ksh93/data/msg.c
}

src_compile() {
	tc-export AR CC LD NM
	export CCFLAGS="${CFLAGS}"
	sh bin/package flat only make ast-ksh SHELL=sh SHOPT_SYSRC=1 || die
	# The build system doesn't exit properly
	[[ -e bin/ksh ]] || die
}

src_install() {
	into /
	dobin bin/ksh
	dosym ksh /bin/rksh
	newman man/man1/sh.1 ksh.1
}
