TERMUX_PKG_HOMEPAGE=https://www.lyx.org
TERMUX_PKG_DESCRIPTION="WYSIWYM (What You See Is What You Mean) Document Processor"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2.4.1"
TERMUX_PKG_SRCURL="https://ftp.lip6.fr/pub/lyx/stable/${TERMUX_PKG_VERSION%.*}.x/lyx-${TERMUX_PKG_VERSION/p/-}.tar.xz"
TERMUX_PKG_SHA256=74de28a07ef37aa9471bc9962db182152a25310c7d1f47f676bb9bc63d9713c5
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_VERSION_SED_REGEXP='s/\./p/3; s/-/p/'
TERMUX_PKG_DEPENDS="ghostscript, hunspell, imagemagick, libandroid-execinfo, libc++, libxcb, lyx-data, qt5-qtbase, qt5-qtsvg, qt5-qtx11extras, texlive-bin, zlib"
TERMUX_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-build-type=rel
--without-included-boost
--without-aspell
--with-hunspell
"
TERMUX_PKG_RM_AFTER_INSTALL="share/lyx/examples"

termux_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"

	# This is to allow the build script find the `moc` on cross-build host
	export PATH="${TERMUX_PREFIX}/opt/qt/cross/bin:${PATH}"
}
