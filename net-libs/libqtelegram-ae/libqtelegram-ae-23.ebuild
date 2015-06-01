# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/Aseman-Land/libqtelegram-aseman-edition.git"
EGIT_COMMIT="AP_23"
inherit git-2 qmake-utils
DESCRIPTION="Aseman's fork of libqtelegram"
HOMEPAGE="http://aseman.co/en/products/cutegram/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	media-libs/thumbnailer
	media-libs/libmediainfo
	dev-libs/openssl"

src_prepare() {
	sed -i 's/\/$$LIB_PATH//g' ./libqtelegram-ae.pro
}

src_configure() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
