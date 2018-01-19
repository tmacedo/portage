# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils java-pkg-2 git-r3

SV="2.11"

DESCRIPTION="Scalafmt - code formatter for Scala"
HOMEPAGE="http://scalameta.org/scalafmt/"
EGIT_COMMIT="v${PV}"
EGIT_REPO_URI="https://github.com/scalameta/scalafmt.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
USE=""
IUSE=""

DEPEND=">=virtual/jdk-1.8
	>=dev-lang/scala-2.11.8:${SV}
	|| ( dev-java/sbt dev-java/sbt-bin )"
RDEPEND=">=virtual/jre-1.8"

JAVA_GENTOO_CLASSPATH="scala-${SV}"

src_compile() {
	sbt cli/assembly
}

src_install() {
	java-pkg_dojar $(find "${WORKDIR}"/${PN}-${PV}/scalafmt-cli/target/ -name \*.jar -print)
	java-pkg_dolauncher scalafmt --main org.scalafmt.cli.Cli --java_args "-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512M"
}
