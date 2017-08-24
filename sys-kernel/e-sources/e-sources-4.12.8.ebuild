# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
K_DEBLOB_AVAILABLE="0"
K_KDBUS_AVAILABLE="1"

ck_version="2"
gentoo_version="9"
#tuxonice_version="2015.10.30"
#uksm_version=""

aufs_kernel_version="4.11.7+_p20170703"
cjktty_kernel_version="4.4"
reiser4_kernel_version="4.12.1"
#tuxonice_kernel_version="4.2.5"
#uksm_kernel_version=""

KEYWORDS="~amd64 ~x86 ~mips"

SUPPORTED_USE="+additional aufs cjktty +ck +experimental +gentoo +reiser4 +thinkpad"
UNSUPPORTED_USE="uksm tuxonice"

UNIPATCH_EXCLUDE=""

OVERRIDE_AUFS_PATCHES=""
OVERRIDE_CJKTTY_PATCHES=""
OVERRIDE_CK_PATCHES=""
OVERRIDE_REISER4_PATCHES=""
OVERRIDE_TUXONICE_PATCHES=""
OVERRIDE_UKSM_PATCHES=""

inherit e-sources
