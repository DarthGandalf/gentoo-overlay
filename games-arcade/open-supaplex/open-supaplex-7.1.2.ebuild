# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="OSS reimplementation of Supaplex in C and SDL"
HOMEPAGE="https://github.com/sergiou87/open-supaplex"
SRC_URI="https://github.com/sergiou87/open-supaplex/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer[vorbis]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? ( dev-lang/ruby )
"

src_compile() {
	append-cflags -DFILE_FHS_XDG_DIRS -DFILE_DATA_PATH="${EPREFIX}/usr/share/OpenSupaplex"
	tc-export CC
	cd linux || die
	emake
}

src_test() {
	cd tests || die
	emake
	cp -R "${S}/resources" "${T}/test" || die
	OPENSUPAPLEX_PATH="${T}/test" ./run-tests.rb ./opensupaplex || die
}

src_install() {
	dobin linux/opensupaplex
	insinto /usr/share/OpenSupaplex
	doins -r resources/*
	rm -r "${ED}"/usr/share/OpenSupaplex/audio-lq || die
	rm -r "${ED}"/usr/share/OpenSupaplex/audio-mq || die
}
