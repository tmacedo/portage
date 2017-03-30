# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/Aseman-Land/aseman-qt-tools.git"
EGIT_BRANCH="master"
inherit git-r3 qmake-utils
DESCRIPTION="Aseman's Qt Tools"
HOMEPAGE="https://github.com/Aseman-Land/aseman-qt-tools"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	dev-qt/qtdbus:5
	dev-qt/qtsensors:5
	dev-qt/qtpositioning:5
	dev-libs/qtkeychain"

src_configure() {
    mkdir build
	cd build
	eqmake5 QT+=widgets QT+=multimedia QT+=dbus QT+=sensors QT+=positioning ../asemantools.pro
}

src_install() {
	cd build
	emake INSTALL_ROOT="${D}" install
}
