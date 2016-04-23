# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Rust Code Completion utility "
HOMEPAGE="https://github.com/phildawes/racer"
if [[ $PV = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/phildawes/racer"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/phildawes/racer/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="MIT"
SLOT="0"
IUSE="+source"


COMMON_DEPEND="virtual/rust:*"
DEPEND="${COMMON_DEPEND}
	dev-util/cargo"
RDEPEND="${COMMON_DEPEND}
	source? ( dev-util/rust-sources )"

src_compile() {
	cargo build --release
}

src_install() {
	dobin target/release/racer
}

pkg_postinst() {
	elog "Racer requires the rust sources in a path pointed by RUST_SRC_PATH"
	elog "environment variable."
	if use source; then
		elog "% export RUST_SRC_PATH=/usr/local/src/rust"
	else
		elog "Download a copy of the rust source and run"
		elog "% export RUST_SRC_PATH=<path to>/rust/src."
		elog "or enable the 'sources' use flag for this package"
	fi
	elog "Use vim-racer or emacs-racer for the editors support"
	elog
}
