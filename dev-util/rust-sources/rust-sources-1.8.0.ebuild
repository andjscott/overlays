# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="http://www.rust-lang.org/"

MY_P="rustc-${PV}"
SRC="${MY_P}-src.tar.gz"
SRC_URI="http://static.rust-lang.org/dist/${SRC} -> rustc-${PV}-src.tar.gz"

LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4 UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "rustc-${PV}-src.tar.gz" || die
	mv "rustc-${PV}" "rust-sources-${PV}" || die
}

src_configure() {
	true
}

src_compile() {
	true
}

src_install() {
	dodir /usr/local/src/rust/src
	find src -name '*.rs' -exec cp --parents "{}" ${D}/usr/local/src/rust/ \; 
}
