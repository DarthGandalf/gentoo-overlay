# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_COMMIT="1e52a8048cdc0b13b829dccfc1172768af3663a0"
DESCRIPTION="A minimalist argument handler for C++"
HOMEPAGE="https://github.com/adishavit/argh"
SRC_URI="https://github.com/WebAssembly/binaryen/archive/version_${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/adishavit/argh/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/argh-${MY_COMMIT}"

_src_configure() {
	local mycmakeargs=(
		-DENABLE_WERROR=no
		-DBUILD_LLVM_DWARF=no
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/argh_tests || die
}
