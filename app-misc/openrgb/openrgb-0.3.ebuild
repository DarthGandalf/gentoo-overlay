# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils udev

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=${EGIT_REPO_URI:-"https://gitlab.com/CalcProgrammer1/OpenRGB"}
else
	SRC_URI="https://gitlab.com/CalcProgrammer1/OpenRGB/-/archive/release_${PV}/OpenRGB-release_${PV}.tar.bz2"
	S="${WORKDIR}/OpenRGB-release_${PV}"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Configuration utility for RGB lights supporting motherboards, RAM, & peripherals"
HOMEPAGE="https://gitlab.com/CalcProgrammer1/OpenRGB"
LICENSE="GPL-2"
SLOT="0"

BDEPEND="virtual/pkgconfig"
DEPEND="
	dev-libs/hidapi
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	virtual/libusb:1
"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	dobin OpenRGB
	doicon qt/OpenRGB.png
	make_desktop_entry OpenRGB OpenRGB OpenRGB
	udev_dorules 60-openrgb.rules
}

pkg_postinst() {
	elog "To control colors, the user needs to be able to access the device, so probably should be added to the 'usb' group."
}
