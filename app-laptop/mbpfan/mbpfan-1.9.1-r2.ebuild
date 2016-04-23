# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils systemd

DESCRIPTION="Fan-Control-Daemon is a daemon that uses input from coretemp module and sets the fan speed using the applesmc module."
HOMEPAGE="https://github.com/dgraziotin/mbpfan"
SRC_URI="https://github.com/dgraziotin/mbpfan/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE="-systemd"

DEPEND="systemd? ( sys-apps/systemd )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/1.9.1-fix_overflow.patch"
}

src_install() {
	emake || die "Make failed!"
	dosbin bin/mbpfan
	if use systemd ; then
		ewarn "systemd service file installation is untested"
		systemd_dounit mbpfan.service
	else
		newinitd mbpfan.init.gentoo mbpfan
	fi
	insinto /etc/
	doins mbpfan.conf
}
