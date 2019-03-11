# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

MY_PN=${PN/-bin/}
inherit unpacker eutils gnome2-utils xdg-utils

DESCRIPTION="Tool for signing with the Portuguese ID card"
HOMEPAGE="https://www.autenticacao.gov.pt/cc-aplicacao"

SRC_URI_AMD64="https://www.autenticacao.gov.pt/documents/10179/11962/Ubuntu+3.0.16+x64/170f0e8a-c83f-4570-af0f-7fbd4741a42e"
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
	dev-libs/openssl:1.0.0
	>=dev-libs/xerces-c-3.2.0
	=dev-libs/libzip-1.1.3
	=dev-libs/xml-security-c-1.7.3-r1
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	virtual/jre
	app-arch/libarchive
	net-misc/curl"

RESTRICT="mirror"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	insinto /usr
	doins -r usr/share
	rm -r usr/share
	insinto /usr
	doins -r usr/local
	dosym /usr/lib/libcurl.so.4 usr/lib/libcurl-nss.so.4
	fperms -R +x /usr/local/bin
	insinto /usr/bin
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
