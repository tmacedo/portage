# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EBZR_REPO_URI="lp:thumbnailer"
EBZR_PROJECT="thumbnailer"
EBZR_REVISION="121"

inherit bzr cmake-utils

IUSE=""
DESCRIPTION="Thumbnail generator for all kinds of files"
HOMEPAGE="https://launchpad.net/thumbnailer"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:5
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	>=dev-libs/glib-2.0
	>=x11-libs/gdk-pixbuf-2.0
	>=net-libs/libsoup-2.4.0
	dev-libs/libxml2"

src_prepare() {
	sed -i '/enable_testing/d' ./CMakeLists.txt
	sed -i '/tests/d' ./CMakeLists.txt
}
