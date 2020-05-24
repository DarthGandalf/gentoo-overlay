# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Plays sound received from network or from a QEMU Windows VM"
HOMEPAGE="https://github.com/duncanthrax/scream"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=${EGIT_REPO_URI:-"https://github.com/duncanthrax/scream.git"}
else
	SRC_URI="https://github.com/duncanthrax/scream/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

S="${S}/Receivers/unix"

LICENSE="Ms-PL"
SLOT="0"
IUSE="alsa pulseaudio"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"
BDEPEND="
	virtual/pkgconfig
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DALSA_ENABLE=$(usex alsa)
		-DPULSEAUDIO_ENABLE=$(usex pulseaudio)
	)

	cmake_src_configure
}
