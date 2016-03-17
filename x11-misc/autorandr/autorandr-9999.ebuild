# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2

DESCRIPTION="Automatically select a display configuration based on connected devices"
HOMEPAGE="https://github.com/phillipberndt/autorandr"
EGIT_REPO_URI="git://github.com/phillipberndt/autorandr.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion pm-utils systemd udev"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	targets="autorandr"
	if use bash-completion; then
		targets="$targets bash_completion"
	fi
	if use pm-utils; then
		targets="$targets pmutils"
	fi
	if use systemd; then
		targets="$targets systemd"
	fi
	if use udev; then
		targets="$targets udev"
	fi
	emake DESTDIR="${D}" install TARGETS="$targets" || die "Make failed!"
}
