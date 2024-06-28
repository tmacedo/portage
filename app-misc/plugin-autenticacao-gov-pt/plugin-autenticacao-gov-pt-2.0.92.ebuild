# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

MY_PN=${PN/-bin/}
inherit unpacker

DESCRIPTION="Tool for authenticating with https://www.autenticacao.gov.pt/"
HOMEPAGE="https://www.autenticacao.gov.pt/"

SRC_URI="https://aplicacoes.autenticacao.gov.pt/plugin/plugin-autenticacao-gov.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/pcsc-tools
	sys-apps/pcsc-lite
	app-crypt/ccid
	virtual/jre"

RESTRICT="mirror"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	cp -ar ./* "${ED}" || die "copy files failed"
}
