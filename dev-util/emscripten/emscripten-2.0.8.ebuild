# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This is a horrible ebuild. Don't use it as an example how to write one.
# TODO:
# * remove network access from npm ci
# * use supported versions of LLVM and binaryen (current it requires git head)
# * enable tests
# * use the python eclass properly
# * fperms +x is wrong
# * fix many QA issues

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
inherit python-single-r1

DESCRIPTION="Emscripten is a complete compiler toolchain to WebAssembly, using LLVM"
HOMEPAGE="https://emscripten.org"
SRC_URI="https://github.com/emscripten-core/emscripten/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT" # TODO: or illinois one
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="network-sandbox test"

RDEPEND="
	dev-util/binaryen
	net-libs/nodejs
	sys-devel/clang:11[llvm_targets_WebAssembly]
	virtual/jre
"
BDEPEND="
	net-libs/nodejs
"

PATCHES=(
	"${FILESDIR}"/emscripten-2.0.8-wasm-ld.patch
	"${FILESDIR}"/emscripten-2.0.8-py-runner.patch
)

src_prepare() {
	default
	npm ci || die
	sed -e "s|GENTOO_PREFIX|${EPREFIX}|" -e "s|GENTOO_LIB|$(get_libdir)|" < "${FILESDIR}/config" > .emscripten || die
	sed -i -e "s|GENTOO_PREFIX|${EPREFIX}|" -e "s|GENTOO_LIB|$(get_libdir)|" -e "s|GENTOO_PYTHON|${EPYTHON}|" tools/shared.py tools/run_python.sh || die
}

src_compile() {
	:
}

src_install() {
	dodir /usr/bin
	tools/create_entry_points.py || die
	insinto "/usr/$(get_libdir)/emscripten"
	doins -r .
	fperms +x "/usr/$(get_libdir)/emscripten"/*
}
