# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils java-pkg-2 git-2

DESCRIPTION="A client, protocol and server for running without incurring JVM startup overhead"
HOMEPAGE="http://martiansoftware.com/nailgun/index.html"

EGIT_REPO_URI="https://github.com/martylamb/nailgun.git"
EGIT_COMMIT="master"

#SRC_URI="https://github.com/martylamb/nailgun/archive/nailgun-all-0.9.1.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=virtual/jre-1.8
	!app-editors/ng"
DEPEND=">=virtual/jdk-1.8
	dev-java/maven-bin"

#need jcoverage
RESTRICT="test"

src_compile() {
	mvn clean install
	make
}

src_install() {
	dobin ng

	mv nailgun-server/target/nailgun-server-0.9.2-SNAPSHOT.jar nailgun.jar
	java-pkg_newjar nailgun.jar
}
