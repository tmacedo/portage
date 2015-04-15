# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils
DESCRIPTION="Cutegram Desktop Client"
HOMEPAGE="http://aseman.co/en/products/cutegram/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_URI="https://github.com/Aseman-Land/Cutegram/archive/v${PV}-stable.tar.gz"

S="${WORKDIR}/Cutegram-${PV}-stable"

DEPEND="dev-libs/openssl
    dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[qml]
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtquick1:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtxml:5
	dev-qt/qtwidgets:5
	net-im/libqtelegram"

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
