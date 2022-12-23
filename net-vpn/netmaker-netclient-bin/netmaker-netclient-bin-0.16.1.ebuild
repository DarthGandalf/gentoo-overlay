# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Netmaker makes networks with WireGuard"
HOMEPAGE="https://netmaker.io/ https://github.com/gravitl/netmaker"
SRC_URI="
	amd64? ( https://github.com/gravitl/netmaker/releases/download/v${PV}/netclient -> ${P}-amd64 )
	arm? ( https://github.com/gravitl/netmaker/releases/download/v${PV}/netclient-arm7 -> ${P}-arm )
	arm64? ( https://github.com/gravitl/netmaker/releases/download/v${PV}/netclient-arm64 -> ${P}-arm64 )
"

LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

S="${WORKDIR}"

src_prepare() {
	cp "${DISTDIR}/${A}" netclient
	chmod +x ./netclient

	default
}

src_install() {
	dobin netclient
	newinitd "${FILESDIR}/netclient.initd" netclient
}
