TERMUX_PKG_HOMEPAGE=https://git-scm.com/
TERMUX_PKG_DESCRIPTION="Fast, scalable, distributed revision control system"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="Joshua Kahn @TomJo2000"
TERMUX_PKG_VERSION="2.50.1"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/pub/software/scm/git/git-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=7e3e6c36decbd8f1eedd14d42db6674be03671c2204864befa2a41756c5c8fc4
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libcurl, libexpat, libiconv, less, openssl, pcre2, zlib"
TERMUX_PKG_RECOMMENDS="openssh"
TERMUX_PKG_SUGGESTS="perl"

## This requires a working $TERMUX_PREFIX/bin/sh on the host building:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fread_reads_directories=yes
ac_cv_header_libintl_h=no
ac_cv_iconv_omits_bom=no
ac_cv_snprintf_returns_bogus=no
--with-curl
--with-expat
--with-shell=$TERMUX_PREFIX/bin/sh
--with-tcltk=$TERMUX_PREFIX/bin/wish
"
# expat is only used by git-http-push for remote lock management over DAV, so disable:
# NO_INSTALL_HARDLINKS to use symlinks instead of hardlinks (which does not work on Android M):
TERMUX_PKG_EXTRA_MAKE_ARGS="
NO_NSEC=1
NO_GETTEXT=1
NO_INSTALL_HARDLINKS=1
CSPRNG_METHOD=openssl
PERL_PATH=$TERMUX_PREFIX/bin/perl
USE_LIBPCRE2=1
DEFAULT_PAGER=pager
DEFAULT_EDITOR=editor
"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $TERMUX_PREFIX.
	if [[ "$TERMUX_ON_DEVICE_BUILD" == 'true' ]]; then
		termux_error_exit "Package '$TERMUX_PKG_NAME' is not safe for on-device builds."
	fi

	# Setup perl so that the build process can execute it:
	rm -f "$TERMUX_PREFIX/bin/perl"
	ln -s "$(command -v perl)" "$TERMUX_PREFIX/bin/perl"

	# Force fresh perl files (otherwise files from earlier builds
	# remains without bumped modification times, so are not picked
	# up by the package):
	rm -rf "$TERMUX_PREFIX/share/git-perl"

	# Fixes build if utfcpp is installed:
	CPPFLAGS="-I$TERMUX_PKG_SRCDIR $CPPFLAGS"
}

termux_step_post_make_install() {
	# shellcheck disable=SC2086 # We need word splitting on the extra args
	{
	# Installing man requires asciidoc and xmlto, so git uses separate make targets for man pages
	make -j "$TERMUX_PKG_MAKE_PROCESSES" install-man

	make -j "$TERMUX_PKG_MAKE_PROCESSES" -C contrib/subtree $TERMUX_PKG_EXTRA_MAKE_ARGS
	make -C contrib/subtree $TERMUX_PKG_EXTRA_MAKE_ARGS "${TERMUX_PKG_MAKE_INSTALL_TARGET}"
	make -j "$TERMUX_PKG_MAKE_PROCESSES" -C contrib/subtree install-man
	}
	mkdir -p "$TERMUX_PREFIX/etc/bash_completion.d/"
	cp "$TERMUX_PKG_SRCDIR/contrib/completion/git-completion.bash" \
		"$TERMUX_PKG_SRCDIR/contrib/completion/git-prompt.sh" \
		"$TERMUX_PREFIX/etc/bash_completion.d/"

	# Remove the build machine perl setup in termux_step_pre_configure to avoid it being packaged:
	rm "$TERMUX_PREFIX/bin/perl"

	# Remove clutter:
	rm -rf "$TERMUX_PREFIX/lib"/*-linux*/perl

	# shellcheck disable=SC2164
	( # Remove duplicated binaries in bin/ with symlink to the one in libexec/git-core:
		cd "$TERMUX_PREFIX/bin"
		ln -sf ../libexec/git-core/git git
		ln -sf ../libexec/git-core/git-upload-pack git-upload-pack
		cd "$TERMUX_PREFIX/libexec/git-core"
		ln -sf git-gui git-citool
	)
}

termux_step_post_massage() {
	if [[ ! -f libexec/git-core/git-remote-https ]]; then
		termux_error_exit "Git built without https support"
	fi
}
