# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="Portage plugin to download and mount latest SquashFS snapshot"
HOMEPAGE="https://github.com/g0dsCookie/portage-sqfssync"
SRC_URI="https://github.com/g0dsCookie/portage-sqfssync/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="arm"

RDEPEND="
	sys-apps/util-linux[${PYTHON_USEDEP},python]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

S="${WORKDIR}/portage-sqfssync-${PV}"

PATCHES=(
	"${FILESDIR}"/noopts.patch
)
