# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

EGIT_REPO_URI="git://gitorious.org/~tmacedo/sony-laptop-zseries/tmacedos-sony-laptop-zseries.git"

inherit git-2 linux-mod

DESCRIPTION="Sony Laptop Z Series kernel module"
HOMEPAGE="https://launchpad.net/~sony-vaio-z-series"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

BUILD_TARGETS="default"
MODULE_NAMES="sony-laptop()"

S=${WORKDIR}

pkg_setup() {
	if kernel_is lt 3 6 0; then
	    eerror "This version of the driver requires a host kernel of 3.6.0 or higher."
	fi

	linux-info_pkg_setup
	linux-mod_pkg_setup
}
