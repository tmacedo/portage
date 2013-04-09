# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_PN=${PN/apache-}

DESCRIPTION="Popular, blazing fast open source enterprise search platform from the Apache Lucene project"
HOMEPAGE="http://lucene.apache.org/solr/"
SRC_URI="http://www.apache.org/dist/lucene/${MY_PN}/${PV}/${P}.tgz"

LICENSE="Apache"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
	www-servers/jetty-bin"

SOLR_HOME="/usr/share/solr"

src_install() {
	dodir "${SOLR_HOME}"
	dodir /etc/solr

	unzip dist/"${P}.war" -d "${D}/${SOLR_HOME}" || die
	sed -i -e 's@\.\./\.\./@\./@g' example/solr/conf/solrconfig.xml || die
	rm -rf "${D}/${SOLR_HOME}"/META-INF  || die

	insinto "${SOLR_HOME}"
	doins -r dist
	doins -r contrib
	doins -r example/solr/conf
	doins "${FILESDIR}"/solr.xml

	dosym "${SOLR_HOME}"/conf /etc/solr/conf
	dosym "${SOLR_HOME}"/WEB-INF/web.xml /etc/solr/web.xml

	# jetty env
	insinto /opt/jetty/etc
	doins "${FILESDIR}"/jetty-solr.xml
	dosym "${SOLR_HOME}" /opt/jetty/webapps/solr
	dosym "${SOLR_HOME}"/solr.xml /opt/jetty/etc/solr.xml
}
