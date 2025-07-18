# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.14.0

EAPI=8

CRATES="
	aho-corasick@1.1.3
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.88
	approx@0.5.1
	autocfg@1.3.0
	bindgen@0.69.4
	bindgen@0.71.1
	bitflags@2.6.0
	bytemuck@1.18.0
	cc@1.1.18
	cexpr@0.6.0
	cfg-if@1.0.0
	clang-sys@1.8.1
	clap@4.5.17
	clap_builder@4.5.17
	clap_derive@4.5.13
	clap_lex@0.7.2
	cmake@0.1.51
	colorchoice@1.0.2
	colored@3.0.0
	console@0.15.8
	convert_case@0.6.0
	dlopen2@0.7.0
	dlopen2_derive@0.4.0
	either@1.13.0
	encode_unicode@0.3.6
	env_filter@0.1.2
	env_logger@0.11.5
	errno@0.3.9
	flagset@0.4.6
	glob@0.3.1
	heck@0.5.0
	home@0.5.9
	humantime@2.1.0
	indicatif-log-bridge@0.2.3
	indicatif@0.17.8
	instant@0.1.13
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.11
	lazy_static@1.5.0
	lazycell@1.3.0
	libc@0.2.170
	libloading@0.8.5
	linux-raw-sys@0.4.14
	log@0.4.22
	matrixmultiply@0.3.9
	memchr@2.7.4
	minimal-lexical@0.2.1
	mint@0.5.9
	nalgebra-macros@0.2.2
	nalgebra@0.33.0
	ndk-context@0.1.1
	nom@7.1.3
	num-bigint@0.4.6
	num-complex@0.4.6
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	number_prefix@0.4.0
	once_cell@1.19.0
	paste@1.0.15
	portable-atomic@1.7.0
	prettyplease@0.2.22
	proc-macro2@1.0.86
	quote@1.0.37
	rawpointer@0.2.1
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.6
	rustc-hash@1.1.0
	rustc-hash@2.1.1
	rustix@0.38.37
	ryu@1.0.18
	safe_arch@0.7.2
	semver@1.0.23
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	shlex@1.3.0
	simba@0.9.0
	strsim@0.11.1
	syn@2.0.77
	typenum@1.17.0
	unicode-ident@1.0.13
	unicode-segmentation@1.11.0
	unicode-width@0.1.13
	utf8parse@0.2.2
	which@4.4.2
	wide@0.7.28
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	xdg@2.5.2
"

declare -A GIT_CRATES=(
	[libmonado]='https://github.com/technobaboo/libmonado-rs;256895b18c8f9368174fad8a6232ff07764eeacb;libmonado-rs-%commit%'
	[openxr-sys]='https://github.com/Ralith/openxrs;6c7747aee678048642dc16aad8bab3d6961dce03;openxrs-%commit%/sys'
	[openxr]='https://github.com/Ralith/openxrs;6c7747aee678048642dc16aad8bab3d6961dce03;openxrs-%commit%/openxr'
)

inherit cargo

DESCRIPTION="Monado Tracking Origin Calibrator"
HOMEPAGE="https://github.com/galister/motoc"
EGIT_COMMIT=1cd733b9eb7227131e7755d6a7602f3aa64c5eb8
SRC_URI="
	https://github.com/galister/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}/"

DEPENDS="
	media-libs/openxr-loader
	dev-libs/jsoncpp
"
RDEPENDS="${DEPENDS}"

LICENSE=""
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	cargo_src_install
	dodoc README.md
}
