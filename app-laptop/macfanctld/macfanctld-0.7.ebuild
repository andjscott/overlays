# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Fan control for MacBook"
HOMEPAGE="https://github.com/detly/macfanctld"
SRC_URI="https://github.com/andjscott/macfanctld/archive/v0.7.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake || die "Make failed!"
	dosbin macfanctld
	newinitd $FILESDIR/macfanctld.init macfanctl
	doman macfanctld.1
	insinto /etc/
	doins macfanctl.conf
}
