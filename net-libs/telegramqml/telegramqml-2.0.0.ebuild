# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils
DESCRIPTION="Telegram QML"
HOMEPAGE="https://github.com/Aseman-Land/TelegramQML"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_URI="https://github.com/Aseman-Land/TelegramQML/archive/v${PV}.tar.gz"

S="${WORKDIR}/TelegramQML-${PV}"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[qml]
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtxml:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	>=net-libs/libqtelegram-ae-10.0.0"

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
