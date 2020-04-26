# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Plays sound received from network or from a QEMU Windows VM"
HOMEPAGE="https://github.com/duncanthrax/scream"

_GIT="2d47b33a19644287d2a4c0d5139e7f0a76aa9aca"
SRC_URI="https://github.com/duncanthrax/scream/archive/${_GIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/scream-${_GIT}/Receivers/unix"

LICENSE="Ms-PL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa pulseaudio"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DALSA_ENABLE=$(usex alsa)
		-DPULSEAUDIO_ENABLE=$(usex pulseaudio)
	)

	cmake_src_configure
}
