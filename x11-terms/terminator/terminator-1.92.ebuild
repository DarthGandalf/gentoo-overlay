# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_6 python3_7 )
inherit eutils distutils-r1 virtualx xdg

DESCRIPTION="Multiple GNOME terminals in one window"
HOMEPAGE="https://github.com/gnome-terminator/terminator"
SRC_URI="https://github.com/gnome-terminator/terminator/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus"

RDEPEND="
	>=x11-libs/gtk+-3.16:3
	>=dev-libs/glib-2.32:2
	dev-libs/keybinder:3[introspection]
	dev-python/psutil
	x11-libs/vte:2.91[introspection]
	dbus? ( sys-apps/dbus )
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
"
DEPEND="
	dev-util/intltool
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.91-without-icon-cache.patch
	"${FILESDIR}"/${PN}-1.91-desktop.patch
)

python_prepare_all() {
	local i p
	if [[ -n "${LINGUAS+x}" ]] ; then
		pushd "${S}"/po > /dev/null
		strip-linguas -i .
		for i in *.po; do
			if ! has ${i%.po} ${LINGUAS} ; then
				rm ${i} || die
			fi
		done
		popd > /dev/null
	fi

	distutils-r1_python_prepare_all
}

python_test() {
	virtx esetup.py test
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
