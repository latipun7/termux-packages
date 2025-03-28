TERMUX_PKG_HOMEPAGE=https://github.com/google/snappy
TERMUX_PKG_DESCRIPTION="A compression/decompression library"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.2.1
TERMUX_PKG_SRCURL=https://github.com/google/snappy/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=736aeb64d86566d2236ddffa2865ee5d7a82d26c9016b36218fcc27ea4f09f86
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DSNAPPY_BUILD_TESTS=OFF
-DSNAPPY_BUILD_BENCHMARKS=OFF
"
