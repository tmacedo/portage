# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PN=${PN/-bin}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Jetty is an full-featured web and applicaction server implemented entirely in Java."
HOMEPAGE="http://www.mortbay.org/jetty-6/"
SRC_URI="http://dist.codehaus.org/jetty/${MY_P}/${MY_P}.zip"
SLOT="0"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	dev-java/java-config"
RDEPEND=">=virtual/jdk-1.5"

JETTY_HOME="/opt/${MY_PN}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup jetty
	enewuser jetty -1 /bin/bash "${JETTY_HOME}" jetty
}

src_install() {
	sed -i -e 's@default="./logs"@default="/var/log/jetty"@g' etc/jetty.xml || die

	newinitd "${FILESDIR}"/"${MY_PN}".initd "${MY_PN}"
	newconfd "${FILESDIR}"/"${MY_PN}".confd "${MY_PN}"

	dodir "${JETTY_HOME}"
	insinto "${JETTY_HOME}"
	doins start.jar
	doins -r etc
	doins -r lib
	doins -r resources

	dodir "${JETTY_HOME}"/webapps
	dodir "${JETTY_HOME}"/etc/contexts
	dosym "${JETTY_HOME}"/etc /etc/"${MY_PN}"

	fowners -R jetty:jetty "${JETTY_HOME}"

	keepdir /var/log/"${MY_PN}"
	fowners jetty:jetty /var/log/"${MY_PN}"

	keepdir /var/run/"${MY_PN}"
	fowners jetty:jetty /var/run/"${MY_PN}"
}
