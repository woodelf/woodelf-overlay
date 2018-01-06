# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CRATES="
aho-corasick-0.6.4
android_glue-0.2.3
ansi_term-0.10.2
approx-0.1.1
arraydeque-0.2.3
atty-0.2.6
base64-0.9.0
bitflags-0.4.0
bitflags-0.7.0
bitflags-0.8.2
bitflags-0.9.1
bitflags-1.0.1
block-0.1.6
byteorder-1.2.1
bytes-0.3.0
cargo_metadata-0.2.3
cc-1.0.3
cfg-if-0.1.2
cgl-0.2.1
cgmath-0.15.0
clap-2.29.0
clippy-0.0.177
clippy_lints-0.0.177
cmake-0.1.29
cocoa-0.9.2
cocoa-0.11.0
conv-0.3.3
copypasta-0.0.1
core-foundation-0.3.0
core-foundation-0.4.6
core-foundation-sys-0.3.1
core-foundation-sys-0.4.6
core-graphics-0.8.2
core-graphics-0.10.0
core-graphics-0.12.4
core-text-8.0.0
custom_derive-0.1.7
dlib-0.3.1
dlib-0.4.0
dtoa-0.4.2
dwmapi-sys-0.1.1
either-1.4.0
env_logger-0.4.3
errno-0.2.3
euclid-0.16.0
expat-sys-2.1.5
filetime-0.1.14
fnv-1.0.6
font-0.1.0
foreign-types-0.3.2
foreign-types-shared-0.1.1
freetype-rs-0.13.0
freetype-sys-0.4.0
fs2-0.2.5
fsevent-0.2.17
fsevent-sys-0.1.6
fuchsia-zircon-0.2.1
fuchsia-zircon-sys-0.2.0
gcc-0.3.53
gdi32-sys-0.1.2
getopts-0.2.15
gl_generator-0.6.1
gl_generator-0.7.0
gleam-0.4.17
glutin-0.11.0
heapsize-0.3.9
idna-0.1.4
if_chain-0.1.2
inotify-0.3.0
iovec-0.1.1
itertools-0.6.5
itoa-0.3.4
kernel32-sys-0.2.2
khronos_api-2.0.0
lazy_static-0.2.11
lazy_static-1.0.0
lazycell-0.4.0
lazycell-0.5.1
libc-0.2.34
libloading-0.3.4
libloading-0.4.3
libz-sys-1.0.18
linked-hash-map-0.3.0
linked-hash-map-0.4.2
linked-hash-map-0.5.0
log-0.3.8
magenta-0.1.1
magenta-sys-0.1.1
malloc_buf-0.0.6
matches-0.1.6
memchr-2.0.1
memmap-0.6.1
mio-0.5.1
mio-0.6.11
mio-more-0.1.0
miow-0.1.5
miow-0.2.1
net2-0.2.31
nix-0.5.1
nodrop-0.1.12
notify-4.0.3
num-traits-0.1.41
objc-0.2.2
objc-foundation-0.1.1
objc_id-0.1.0
odds-0.2.26
osmesa-sys-0.1.2
owning_ref-0.3.3
parking_lot-0.5.3
parking_lot_core-0.2.8
percent-encoding-1.0.1
phf-0.7.21
phf_codegen-0.7.21
phf_generator-0.7.21
phf_shared-0.7.21
pkg-config-0.3.9
pulldown-cmark-0.0.15
quine-mc_cluskey-0.2.4
quote-0.3.15
rand-0.3.18
redox_syscall-0.1.32
redox_termios-0.1.1
regex-0.2.3
regex-syntax-0.4.1
safemem-0.2.0
same-file-1.0.0
semver-0.6.0
semver-parser-0.7.0
serde-0.9.15
serde-1.0.25
serde_derive-1.0.25
serde_derive_internals-0.18.1
serde_json-0.9.10
serde_json-1.0.8
serde_yaml-0.7.3
servo-fontconfig-0.4.0
servo-fontconfig-sys-4.0.3
shared_library-0.1.8
shell32-sys-0.1.2
siphasher-0.2.2
slab-0.1.3
slab-0.3.0
smallvec-0.6.0
stable_deref_trait-1.0.0
strsim-0.6.0
syn-0.11.11
synom-0.11.3
target_build_utils-0.3.1
tempfile-2.2.0
termion-1.5.1
textwrap-0.9.0
thread_local-0.3.5
time-0.1.38
token_store-0.1.2
toml-0.4.5
unicode-bidi-0.3.4
unicode-normalization-0.1.5
unicode-width-0.1.4
unicode-xid-0.0.4
unreachable-1.0.0
url-1.6.0
user32-sys-0.1.3
utf8-ranges-1.0.0
utf8parse-0.1.0
vcpkg-0.2.2
vec_map-0.8.0
void-1.0.2
vte-0.3.2
walkdir-2.0.1
wayland-client-0.9.10
wayland-client-0.12.4
wayland-kbd-0.13.0
wayland-protocols-0.12.4
wayland-scanner-0.9.10
wayland-scanner-0.12.4
wayland-sys-0.9.10
wayland-sys-0.12.4
wayland-window-0.13.2
winapi-0.2.8
winapi-0.3.2
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.3.1
winapi-x86_64-pc-windows-gnu-0.3.1
winit-0.9.0
ws2_32-sys-0.2.1
x11-dl-2.17.2
xdg-2.1.0
xml-rs-0.6.1
xml-rs-0.7.0
yaml-rust-0.4.0
"

inherit eutils cargo git-r3

DESCRIPTION="GPU-accelerated terminal emulator"
HOMEPAGE="https://github.com/jwilm/alacritty"
EGIT_REPO_URI="https://github.com/jwilm/alacritty"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	media-libs/freetype
	media-libs/fontconfig
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXxf86vm
	x11-libs/libXi
	media-libs/mesa
	x11-misc/xclip
"
DEPEND="${RDEPEND}
	dev-util/cmake
	virtual/pkgconfig
"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	cargo_src_install
	make_desktop_entry ${PN} Alacritty utilities-terminal \
		"System;TerminalEmulator"
}
