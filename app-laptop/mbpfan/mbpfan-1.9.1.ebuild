# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Fan-Control-Daemon is a daemon that uses input from coretemp module and sets the fan speed using the applesmc module."
HOMEPAGE="https://github.com/dgraziotin/mbpfan"
SRC_URI="https://github.com/dgraziotin/mbpfan/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/1.9.1-fix_overflow.patch"
}

src_install() {
	emake || die "Make failed!"
	dosbin bin/mbpfan
	newinitd mbpfan.init.gentoo mbpfan
}
