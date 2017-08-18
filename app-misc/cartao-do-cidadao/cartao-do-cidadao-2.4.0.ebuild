# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN=${PN/-bin/}
inherit unpacker eutils

DESCRIPTION="Tool for signing with the Portuguese ID card"
HOMEPAGE="https://www.autenticacao.gov.pt/cc-aplicacao"

SRC_URI_AMD64="https://www.autenticacao.gov.pt/documents/10179/11962/Aplica%C3%A7%C3%A3o+do+Cart%C3%A3o+de+Cidad%C3%A3o+%28Linux+-+Ubuntu+-+64+bits%29%20%28v2.4.0%29%20Julho+2017.deb/7888d31c-168e-487c-ba9b-2a55439f1863"
SRC_URI="
    amd64? ( ${SRC_URI_AMD64} )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/pcsc-tools
	sys-apps/pcsc-lite
	dev-libs/xerces-c
	dev-libs/xml-security-c
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	virtual/jre
	app-arch/libarchive"

RESTRICT="mirror"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	cp -ar ./* "${ED}" || die "copy files failed"
}
