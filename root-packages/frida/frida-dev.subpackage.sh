TERMUX_SUBPKG_DESCRIPTION="Development files for frida"
TERMUX_SUBPKG_CONFLICTS="frida-server (<< 14.2.13)"
TERMUX_SUBPKG_REPLACES="frida-server (<< 14.2.13)"
TERMUX_SUBPKG_INCLUDE="
lib/libfrida*
lib/frida/
lib/pkgconfig
include/frida-*
share/vala
"
