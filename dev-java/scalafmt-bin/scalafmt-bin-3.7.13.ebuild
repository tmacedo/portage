# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Scalafmt - code formatter for Scala"
HOMEPAGE="http://scalameta.org/scalafmt/"
SRC_URI="https://github.com/scalameta/scalafmt/releases/download/v${PV}/scalafmt-linux-glibc"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
USE=""
IUSE=""

RDEPEND="
	>=virtual/jre-1.8"

src_unpack() {
	mkdir "${S}"
	cp ../distdir/scalafmt-linux-glibc "${S}/scalafmt"
}

src_install() {
	dobin scalafmt
}
