# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A minimalist argument handler for C++"
HOMEPAGE="https://github.com/adishavit/argh"
SRC_URI="https://github.com/adishavit/argh/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

_src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=no
		-DBUILD_TESTS=yes
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/argh_tests || die
}
