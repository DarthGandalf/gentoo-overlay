# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit xdg distutils-r1 virtualx

DESCRIPTION="Multiple GNOME terminals in one window"
HOMEPAGE="https://github.com/gnome-terminator/terminator"
SRC_URI="https://github.com/gnome-terminator/terminator/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus"

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/keybinder:3[introspection]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=x11-libs/gtk+-3.16:3
	x11-libs/vte:2.91[introspection]
	dbus? ( sys-apps/dbus )
"
BDEPEND="
	dev-util/intltool
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.91-without-icon-cache.patch
	"${FILESDIR}"/${PN}-1.91-desktop.patch
)

python_test() {
	virtx esetup.py test
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
