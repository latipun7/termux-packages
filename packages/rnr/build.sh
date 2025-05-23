TERMUX_PKG_HOMEPAGE="https://github.com/ismaelgv/rnr"
TERMUX_PKG_DESCRIPTION="Batch rename files and directories using regular expression (rust)"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@flosnvjx"
TERMUX_PKG_VERSION="0.5.0"
TERMUX_PKG_SRCURL="https://github.com/ismaelgv/rnr/archive/refs/tags/v$TERMUX_PKG_VERSION.tar.gz"
TERMUX_PKG_SHA256=b8edab04e1129b8caeb0c8634dd3bbc9986528c5ec479f7e7f072dbe7bf9ba20
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_make() {
	termux_setup_rust
	cargo build --jobs $TERMUX_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rnr
	install -Dm600 -t $TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME README.* CHANGELOG*
}
