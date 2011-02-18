# Copyright 1999-2009 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Application helper to manage the Option hso interface"
HOMEPAGE="http://www.pharscape.org/"
SRC_URI="http://www.pharscape.org/downloads1.html/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	cd "${D}"
}

pkg_postinst() {
	chmod +s /usr/bin/hsolinkcontrol
}

