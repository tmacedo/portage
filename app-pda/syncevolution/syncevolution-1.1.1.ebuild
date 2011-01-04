# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit gnome2

MY_P=${P}
S=${WORKDIR}/${MY_P}

DESCRIPTION="SyncEvolution synchronizes personal information management (PIM) data such as contacts, appointments, tasks and memos using the Synthesis sync engine, which provides support for the SyncML synchronization protocol."
HOMEPAGE="http://syncevolution.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus gtk"

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

DOCS="AUTHORS ChangeLog"

src_compile() {
    econf \
    $(use_enable dbus dbus-service) \
	$(use_enable gtk gui) \
    || die "configure failed"

    emake || die "emake failed"
}

