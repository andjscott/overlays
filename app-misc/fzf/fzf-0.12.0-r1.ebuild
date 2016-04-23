# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A command-line fuzzy finder written in Go"
HOMEPAGE="https://github.com/junegunn/fzf"
SRC_URI="https://github.com/junegunn/fzf/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash zsh fish tmux vim doc"

DEPEND="dev-lang/go dev-lang/ruby"
RDEPEND="${DEPEND}"

src_install() {
	doman man/man1/fzf.1
	dobin fzf

	if use bash; then
		insinto /etc/bash_completion.d/
		newins shell/completion.bash fzf
		insinto /etc/profile.d/
		newins shell/key-bindings.bash fzf.bash
	fi
	if use zsh; then
		insinto /usr/share/zsh/site-functions/
		newins shell/completion.zsh _fzf
		insinto /usr/share/zsh/site-contrib/
		newins shell/key-bindings.zsh fzf.zsh
	fi
	if use fish; then
		insinto /usr/share/fish/functions/
		newins shell/key-bindings.fish fzf.fish
	fi
	if use tmux; then
		dobin bin/fzf-tmux
	fi
	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins plugin/fzf.vim
	fi
	if use doc; then
		dodoc README.md 
	fi
}
