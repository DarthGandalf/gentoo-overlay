# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Netmaker makes networks with WireGuard"
HOMEPAGE="https://netmaker.io/ https://github.com/gravitl/netmaker"
SRC_URI="
	amd64? ( https://github.com/gravitl/netmaker/releases/download/v${PV}/netclient -> ${P}-amd64 )
	arm? ( https://github.com/gravitl/netmaker/releases/download/v${PV}/netclient-arm7 -> ${P}-arm )
	arm64? ( https://github.com/gravitl/netmaker/releases/download/v${PV}/netclient-arm64 -> ${P}-arm64 )
"
S="${WORKDIR}"

LICENSE="SSPL-1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

QA_PREBUILT="*"

RDEPEND="net-vpn/wireguard-tools[wg-quick]"

src_prepare() {
	cp "${DISTDIR}/${A}" netclient || die
	chmod +x ./netclient || die

	default
}

src_install() {
	dobin netclient
	newinitd "${FILESDIR}/netclient.initd" netclient
	systemd_dounit "${FILESDIR}/netclient.service"
}
