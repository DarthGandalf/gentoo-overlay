# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Shows stats of Corsair PSU, controls its fan"
HOMEPAGE="https://github.com/audiohacked/OpenCorsairLink"
EGIT_REPO_URI="https://github.com/audiohacked/OpenCorsairLink"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="
	virtual/libusb
"
RDEPEND="${DEPEND}"

src_install() {
	dobin OpenCorsairLink.elf
}

pkg_postinst() {
	elog "The user needs to be able to access the device, so probably should be added to the 'usb' group."
}
