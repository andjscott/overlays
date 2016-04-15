# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="You need a budget"
HOMEPAGE="http://classic.youneedabudget.com/download"
setupexe="YNAB+4_${PV}_Setup.exe"
SRC_URI="http://s3.amazonaws.com/cf.download/ynab4/${setupexe}"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-emulation/wine"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${setupexe}" "${WORKDIR}" || die
}
:
src_install() {
	exeinto /usr/share/ynab4
	newexe ${setupexe} Setup.exe
	dobin ${FILESDIR}/ynab4
}
