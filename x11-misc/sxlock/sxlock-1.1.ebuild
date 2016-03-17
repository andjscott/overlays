# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Simple screen locker utility for X, fork of sflock, which is based on slock. Main difference is that sxlock uses PAM authentication, so no suid is needed."
HOMEPAGE="https://github.com/lahwaacz/sxlock"
SRC_URI="https://github.com/lahwaacz/sxlock/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	sys-libs/pam"
RDEPEND="${DEPEND}"

