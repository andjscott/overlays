# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="KeePass plugin to expose password entries securely (256bit AES/CBC) over HTTP"
HOMEPAGE="https://github.com/pfn/keepasshttp"
SRC_URI="https://github.com/pfn/keepasshttp/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-admin/keepass"
RDEPEND="${DEPEND}"

INSTALL_DIR="/usr/lib/keepass/"
PLUGIN_FILENAME="KeePassHttp.plgx"

src_install() {
	fperms 644 "${PLUGIN_FILENAME}"
	insinto "${INSTALL_DIR}"
	doins "${PLUGIN_FILENAME}"
}
