# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EBZR_REPO_URI="lp:libqtelegram"
EBZR_PROJECT="libqtelegram"
EBZR_REVISION="86"

inherit bzr cmake-utils

IUSE=""
DESCRIPTION="A Qt library to access telegram"
HOMEPAGE="https://code.launchpad.net/libqtelegram"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	media-libs/thumbnailer
	media-libs/libmediainfo
	dev-libs/openssl"

src_prepare() {
	sed -i '/asserter.h/d' ./lib/core/CMakeLists.txt
	sed -i '/constants.h/d' ./lib/core/CMakeLists.txt
	sed -i '/cryptoutils.h/d' ./lib/core/CMakeLists.txt
	sed -i '/tlvalues.h/d' ./lib/core/CMakeLists.txt
	sed -i '/utils.h/d' ./lib/core/CMakeLists.txt
	sed -i 's/settings.h/settings.h\)/g' ./lib/core/CMakeLists.txt
}
