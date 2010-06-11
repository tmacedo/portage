# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-webcal/evolution-webcal-2.21.92.ebuild,v 1.1 2008/03/26 22:39:57 eva Exp $

inherit gnome2

MY_P=${P/_beta/beta}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A GNOME URL handler for web-published ical calendar files"
HOMEPAGE="http://www.estamos.de/download/syncevolution/sources/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_URI="http://downloads.syncevolution.org/syncevolution/sources/${MY_P}.tar.gz"

RESTRICT="mirror"

RDEPEND=">=gnome-base/gconf-2
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2
	>=gnome-extra/evolution-data-server-1.2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog TODO"
