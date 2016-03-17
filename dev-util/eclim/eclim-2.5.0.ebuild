# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=2

inherit eutils java-pkg-2 java-ant-2 multilib
MY_P=${P/-/_}

DESCRIPTION="Expose eclipse features inside of vim."
HOMEPAGE="https://github.com/ervandew/eclim"
SRC_URI="https://github.com/ervandew/eclim/releases/download/2.5.0/eclim_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cdt +java php ruby doc"

COMMON_DEPEND=">=dev-util/eclipse-sdk-bin-4.5"
DEPEND="${COMMON_DEPEND}
>=virtual/jdk-1.5
doc? ( dev-python/sphinx )"
RDEPEND="${COMMON_DEPEND}
app-editors/vim
>=virtual/jre-1.5
dev-java/nailgun"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
eclipse_home="/opt/eclipse-sdk-bin-4.5/"
vim_home="/usr/share/vim/vimfiles/"
mypkg_plugins=""

pkg_setup() {
	ewarn "Eclim can only use Eclipse plugins that are installed system-wide."
	ewarn "Please make sure necessary plugins are installed in ${eclipse_home}."

	if use java ; then
		mypkg_plugins="jdt,ant,maven"
	fi
	if use cdt ; then
		mypkg_plugins="${mypkg_plugins},cdt"
		ewarn "You have enabled the 'cdt' USE flag."
		ewarn "The cdt plugin requires that you have the Eclipse CDT installed."
	fi
	if use php ; then
		mypkg_plugins="${mypkg_plugins},wst,dltk,pdt"
		ewarn "You have enabled the 'php' USE flag."
		ewarn "The php plugin requires that you have the Eclipse PDT installed."
	fi
	if use ruby ; then
		mypkg_plugins="${mypkg_plugins},dltk,dltkruby"
		ewarn "You have enabled the 'ruby' USE flag."
		ewarn "The ruby plugin requires that you have the Eclipse DLTK Ruby installed."
	fi
	# Remove leading comma
	mypkg_plugins=${mypkg_plugins#,}
}

src_configure() {
	chmod +x ${S}/org.eclim/nailgun/configure ${S}/bin/sphinx
}

src_compile() { 
	if use doc; then
		eant -Declipse.home="${ROOT}/${eclipse_home}" \
			-Declipse.local="${T}" \
			docs vimdocs
	fi

	mkdir -p "${T}/${eclipse_home}"
	mkdir -p "${T}/${vim_home}"
	eant -Declipse.home="${ROOT}/${eclipse_home}" \
		-Declipse.local="${T}/${eclipse_home}" \
		-Dvim.files="${T}/${vim_home}" \
		-Dplugins="${mypkg_plugins}" \
		deploy
}

src_install() {
	dodir "${vim_home}"
	dodir "${eclipse_home}"
	cp -a "${T}/${eclipse_home}/." ${D}/${eclipse_home}
	cp -a "${T}/${vim_home}/." ${D}/${vim_home}
}
