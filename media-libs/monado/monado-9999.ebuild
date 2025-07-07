# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# CMake picked to avoid automagic dependencies in meson.build
inherit cmake git-r3 fcaps

DESCRIPTION="The open source OpenXR runtime."
HOMEPAGE="https://monado.dev"
EGIT_REPO_URI="https://gitlab.freedesktop.org/monado/monado.git"
LICENSE="Boost-1.0"
SLOT="0"

IUSE="dbus ffmpeg gles gstreamer opencv opengl psvr sdl systemd uvc vive vulkan wayland X"

# TODO: OpenHMD, percetto?, libsurvive?
DEPEND="
	media-libs/openxr-loader
	media-libs/mesa[egl(+)]
	dev-cpp/eigen:3
	dev-util/glslang
	virtual/libusb:=
	virtual/libudev
	media-libs/libv4l
	dev-libs/libbsd
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
	X? (
		x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libxcb
	)
	vulkan? (
		media-libs/vulkan-loader
		dev-util/vulkan-headers
	)
	opengl? ( virtual/opengl )
	opencv? ( media-libs/opencv:= )
	gles? ( media-libs/libglvnd )
	dbus? ( sys-apps/dbus )
	systemd? ( sys-apps/systemd:= )
	uvc? ( media-libs/libuvc )
	ffmpeg? ( media-video/ffmpeg:= )
	sdl? ( media-libs/libsdl2 )
	gstreamer? ( media-libs/gstreamer )
	psvr? ( dev-libs/hidapi )
	vive? ( sys-libs/zlib:= )
"
RDEPEND="${DEPEND}"

# Make it possible for monado to use a realtime priority vulkan queue
FILECAPS=(
	cap_sys_nice+ep usr/bin/monado-service
)

src_configure() {
	local mycmakeargs=(
		-DXRT_HAVE_WAYLAND=$(usex wayland)
		-DXRT_HAVE_XLIB=$(usex X)
		-DXRT_HAVE_XRANDR=$(usex X)
		-DXRT_HAVE_XCB=$(usex X)

		-DXRT_HAVE_VULKAN=$(usex vulkan)
		-DXRT_HAVE_OPENGL=$(usex opengl)
		-DXRT_HAVE_OPENGLES=$(usex gles)
		-DXRT_HAVE_EGL=ON
		-DXRT_HAVE_LIBBSD=ON
		-DXRT_HAVE_SYSTEMD=$(usex systemd)
		-DXRT_INSTALL_SYSTEMD_UNIT_FILES=ON

		-DXRT_HAVE_LIBUSB=ON
		-DXRT_HAVE_JPEG=ON
		-DXRT_HAVE_OPENCV=$(usex opencv)
		-DXRT_HAVE_LIBUVC=$(usex uvc)
		-DXRT_HAVE_FFMPEG=$(usex ffmpeg)
		-DXRT_HAVE_SDL2=$(usex sdl)
		-DXRT_HAVE_SYSTEM_CJSON=OFF
		-DXRT_HAVE_GST=$(usex gstreamer)
		-DXRT_HAVE_PERCETTO=OFF

		-DXRT_BUILD_DRIVER_PSVR=$(usex psvr)
		-DXRT_BUILD_DRIVER_RS=OFF
		-DXRT_BUILD_DRIVER_VIVE=$(usex vive)
		-DXRT_BUILD_DRIVER_OHMD=OFF
		-DXRT_BUILD_DRIVER_HANDTRACKING=OFF
		-DXRT_BUILD_DRIVER_DAYDREAM=$(usex dbus)
		-DXRT_BUILD_DRIVER_ARDUINO=$(usex dbus)
		-DXRT_BUILD_DRIVER_ILLIXR=OFF
		-DXRT_BUILD_DRIVER_ULV2=OFF

		-DXRT_BUILD_DRIVER_SURVIVE=OFF
		-DXRT_BUILD_DRIVER_QWERTY=$(usex sdl)
	)

	cmake_src_configure
}
