# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# skipping: alacritty
CRATES="
aho-corasick-0.6.6
android_glue-0.2.3
ansi_term-0.11.0
approx-0.1.1
arraydeque-0.4.2
atty-0.2.11
base64-0.9.2
bitflags-0.4.0
bitflags-0.7.0
bitflags-0.8.2
bitflags-1.0.3
block-0.1.6
byteorder-1.2.4
bytes-0.3.0
cc-1.0.18
cfg-if-0.1.4
cgl-0.2.3
cgmath-0.16.1
clap-2.32.0
cloudabi-0.0.3
cmake-0.1.32
cocoa-0.15.0
copypasta-0.0.1
core-foundation-0.5.1
core-foundation-0.6.1
core-foundation-sys-0.5.1
core-foundation-sys-0.6.1
core-graphics-0.13.0
core-graphics-0.14.0
core-text-9.2.0
dirs-1.0.2
dlib-0.4.1
downcast-rs-1.0.3
dtoa-0.4.3
env_logger-0.5.12
errno-0.2.4
errno-dragonfly-0.1.1
euclid-0.17.3
expat-sys-2.1.5
filetime-0.1.15
fnv-1.0.6
font-0.1.0
foreign-types-0.3.2
foreign-types-shared-0.1.1
freetype-rs-0.13.0
freetype-sys-0.4.0
fsevent-0.2.17
fsevent-sys-0.1.6
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
gcc-0.3.54
gl_generator-0.9.0
gleam-0.6.0
glutin-0.16.0
humantime-1.1.1
inotify-0.3.0
iovec-0.1.2
itoa-0.4.2
kernel32-sys-0.2.2
khronos_api-2.2.0
lazy_static-1.1.0
lazycell-0.4.0
lazycell-0.6.0
libc-0.2.42
libloading-0.5.0
libz-sys-1.0.18
linked-hash-map-0.5.1
log-0.3.9
log-0.4.3
malloc_buf-0.0.6
memchr-2.0.1
memmap-0.6.2
mio-0.5.1
mio-0.6.15
mio-more-0.1.0
miow-0.1.5
miow-0.2.1
net2-0.2.33
nix-0.11.0
nix-0.5.1
notify-4.0.3
num-traits-0.1.43
num-traits-0.2.5
objc-0.2.5
objc-foundation-0.1.1
objc_id-0.1.1
osmesa-sys-0.1.2
owning_ref-0.3.3
parking_lot-0.5.5
parking_lot_core-0.2.14
percent-encoding-1.0.1
pkg-config-0.3.12
proc-macro2-0.4.9
quick-error-1.2.2
quote-0.6.5
rand-0.4.2
rand-0.5.4
rand_core-0.2.1
redox_syscall-0.1.40
redox_termios-0.1.1
regex-1.0.2
regex-syntax-0.6.2
remove_dir_all-0.5.1
safemem-0.2.0
same-file-1.0.2
serde-1.0.70
serde_derive-1.0.70
serde_json-1.0.24
serde_yaml-0.7.5
servo-fontconfig-0.4.0
servo-fontconfig-sys-4.0.3
shared_library-0.1.9
slab-0.1.3
slab-0.3.0
slab-0.4.1
smallvec-0.6.3
smithay-client-toolkit-0.2.6
stable_deref_trait-1.1.1
static_assertions-0.2.5
strsim-0.7.0
syn-0.14.7
tempfile-3.0.3
termcolor-1.0.1
termion-1.5.1
textwrap-0.10.0
thread_local-0.3.5
time-0.1.40
ucd-util-0.1.1
unicode-width-0.1.5
unicode-xid-0.1.0
unreachable-1.0.0
utf8-ranges-1.0.0
utf8parse-0.1.0
vcpkg-0.2.4
vec_map-0.8.1
version_check-0.1.4
void-1.0.2
vte-0.3.2
walkdir-2.2.0
wayland-client-0.20.11
wayland-commons-0.20.11
wayland-protocols-0.20.11
wayland-scanner-0.20.11
wayland-sys-0.20.11
winapi-0.2.8
winapi-0.3.5
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
wincolor-1.0.0
winit-0.15.1
ws2_32-sys-0.2.1
x11-dl-2.18.3
xdg-2.1.0
xml-rs-0.7.0
yaml-rust-0.4.0
"

inherit eutils cargo bash-completion-r1

DESCRIPTION="Cross-platform, GPU-accelerated terminal emulator"
HOMEPAGE="https://github.com/jwilm/alacritty"
SRC_URI="
	https://github.com/jwilm/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
#jwilm/rust-fontconfig
#jwilm/libfontconfig

RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion fish-completion zsh-completion"

RDEPEND="
	media-libs/freetype:2=
	media-libs/fontconfig:1.0=
	sys-libs/zlib:0=

	x11-libs/libX11:0=
	x11-libs/libXxf86vm:0=
	x11-libs/libXi:0=
	media-libs/mesa:0=

	x11-misc/xclip

	bash-completion? ( app-shells/bash-completion )
	fish-completion? ( app-shells/fish )
	zsh-completion? ( app-shells/zsh )
"
# needs >=rust-1.20.0 to avoid "error: associated constants are experimental (see issue #29646)"
DEPEND="
	${RDPENED}
	dev-util/cmake
	virtual/pkgconfig
	>=dev-lang/rust-1.20.0
"

src_prepare() {
	ewarn "cargo breaks with FEATURES=network-sandbox, please keep it disabled."
	eapply_user
}

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md alacritty.yml
	mv alacritty.man alacritty.1 &&	doman alacritty.1 || die "manpage failed"
	domenu alacritty.desktop

	dodir /usr/share/terminfo/a
	tic -o "${ED}/usr/share/terminfo" alacritty.info || die "tic failed"

	use bash-completion && newbashcomp alacritty-completions.bash alacritty
	use fish-completion && {
		insinto /usr/share/fish/vendor_completions/
		newins alacritty-completions.fish alacritty.fish
	}
	use zsh-completion && {
		insinto /usr/share/zsh/functions/Completion/X/
		newins alacritty-completions.zsh _alacritty
	}
}

pkg_postinst() {
	elog "An example config file can be found in /usr/share/doc/${PF}/."
	elog "Install it, otherwise, many things (such as arrow keys) will not work."
}
