# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Compiler and toolchain infrastructure library for WebAssembly"
HOMEPAGE="https://github.com/WebAssembly/binaryen"
SRC_URI="https://github.com/WebAssembly/binaryen/archive/version_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

S="${WORKDIR}/binaryen-version_${PV}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_WERROR=no
		-DBUILD_LLVM_DWARF=no
	)
	cmake_src_configure
}

src_test() {
	./check.py || die
}
