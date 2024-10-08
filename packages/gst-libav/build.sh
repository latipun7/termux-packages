TERMUX_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/modules/gst-libav.html
TERMUX_PKG_DESCRIPTION="GStreamer Libav plug-in contains one plugin with a set of elements using the Libav library code"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.24.8"
TERMUX_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=1e4a8fd537621d236442cf90a6e9ad5e00f87bffffdaeb1fd8bfd23719de8c75
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="ffmpeg, glib, gst-plugins-base, gstreamer"
