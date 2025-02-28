# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fcaps xdg

DESCRIPTION="WiVRn OpenXR streaming"
HOMEPAGE="https://github.com/WiVRn/WiVRn"

LICENSE="GPL-3 Apache-2.0 MIT"
SLOT="0"
IUSE="gui nvenc +pipewire pulseaudio +steamvr systemd vaapi wireshark-plugins x264"
REQUIRED_USE="|| ( nvenc vaapi x264 )"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WiVRn/WiVRn.git"
	MONADO_REPO_URI="https://gitlab.freedesktop.org/monado/monado.git"
else
	SRC_URI="
		https://github.com/WiVRn/WiVRn/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/WiVRn/WiVRn/releases/download/v${PV}/server-build-deps.tar.xz -> ${P}-server-build-deps.tar.xz"
	KEYWORDS="~amd64"
fi

RDEPEND="
	dev-libs/glib
	dev-libs/libbsd
	dev-libs/openssl
	media-libs/openxr-loader
	net-dns/avahi
	x11-libs/libnotify
	|| (
		sys-apps/systemd
		sys-auth/elogind
	)
	gui? (
		dev-libs/qcoro[qml]
		kde-frameworks/kcoreaddons:6
		kde-frameworks/ki18n:6
		kde-frameworks/kiconthemes:6
		kde-frameworks/kirigami:6
		kde-frameworks/qqc2-desktop-style:6
	)
	pipewire? (
		media-video/pipewire
	)
	pulseaudio? (
		media-libs/libpulse
	)
	systemd? (
		sys-apps/systemd
	)
	vaapi? (
		media-video/ffmpeg[libdrm,vaapi]
	)
	wireshark-plugins? (
		net-analyzer/wireshark
	)
	x264? (
		media-libs/x264
	)
"
DEPEND="
	${RDEPEND}
	dev-cpp/cli11
	dev-cpp/eigen
	dev-cpp/nlohmann_json
	dev-libs/boost
"
BDEPEND="
	dev-util/glslang
	dev-util/gdbus-codegen
	gui? (
		gnome-base/librsvg
	)
	dev-util/vulkan-headers
"

do_patches() {
	eapply "${FILESDIR}/0001-Don-t-throw-socket_shutdown-for-0-writes.patch"
	eapply "${FILESDIR}/0001-Use-width-height-multiple-of-32-for-nvenc-probing.patch"
	if use steamvr; then
		eapply "${FILESDIR}/force-enable-steamvr_lh.patch"
	fi
}

if [[ ${PV} == 9999 ]]; then
	src_unpack() {
		git-r3_src_unpack
		default_src_unpack

		local MONADO_COMMIT=$(grep "GIT_TAG" "${P}/CMakeLists.txt" | awk '{print $2}' | tail -1)
		git-r3_fetch "${MONADO_REPO_URI}" "${MONADO_COMMIT}"
		git-r3_checkout "${MONADO_REPO_URI}" "${WORKDIR}/monado-src"
	}

	src_prepare() {
		default_src_prepare
		eapply --directory="${WORKDIR}/monado-src" "${WORKDIR}/${P}/patches/monado"/*
		do_patches
		cmake_src_prepare
	}
else
        src_prepare() {
		do_patches
		cmake_src_prepare
        }

	src_unpack() {
		default_src_unpack
		cd "${WORKDIR}"
		mv "WiVRn-${PV}" "${P}"
	}
fi

src_configure() {
	if [[ ${PV} == 9999 ]]; then
		GIT_DESC=$(git describe --tags --always)
		GIT_COMMIT=$(git rev-parse HEAD)
	else
		GIT_DESC=v${PV}
		GIT_COMMIT=v${PV}
	fi
	local mycmakeargs=(
		-DGIT_DESC=${GIT_DESC}
		-DGIT_COMMIT=${GIT_COMMIT}
		-DWIVRN_BUILD_CLIENT=OFF
		-DWIVRN_BUILD_SERVER=ON
		-DWIVRN_OPENXR_MANIFEST_TYPE=relative
		-DWIVRN_BUILD_DASHBOARD=$(usex gui)
		-DWIVRN_BUILD_DISSECTOR=$(usex wireshark-plugins)
		-DWIVRN_BUILD_WIVRNCTL=ON
		-DWIVRN_USE_PIPEWIRE=$(usex pipewire)
		-DWIVRN_USE_PULSEAUDIO=$(usex pulseaudio)
		-DWIVRN_USE_NVENC=$(usex nvenc)
		-DWIVRN_USE_VAAPI=$(usex vaapi)
		-DWIVRN_USE_VULKAN_ENCODE=ON
		-DWIVRN_USE_X264=$(usex x264)
		-DWIVRN_USE_SYSTEMD=$(usex systemd)
		-DWIVRN_USE_SYSTEM_OPENXR=ON
		-DWIVRN_USE_SYSTEM_BOOST=ON
                -DWIVRN_FEATURE_STEAMVR_LIGHTHOUSE=$(usex steamvr)
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_BASE_DIR="${WORKDIR}"
		-DENABLE_COLOURED_OUTPUT=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	dosym -r /usr/share/openxr/1/openxr_wivrn.json /etc/openxr/1/active_runtime.json
}

pkg_postinst()
{
	fcaps cap_sys_nice bin/wivrn-server
	xdg_pkg_postinst
	elog "WiVRn requires a compatible client on VR headset to run."
	if [[ ${PV} == 9999 ]]; then
		elog "For most headsets it can be downloaded from CI artifacts on https://github.com/WiVRn/WiVRn/actions/workflows/Build.yml"
	else
		elog "For most headsets it can be downloaded on https://github.com/WiVRn/WiVRn/releases/tag/v${PV}"
	fi
}
