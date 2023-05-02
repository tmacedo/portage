# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9,10,11,12} pypy3 )
MY_PV="$(ver_cut 1-2)"

inherit python-single-r1

DESCRIPTION="A highly efficient backup system based on the git packfile format"
HOMEPAGE="https://bup.github.io/ https://github.com/bup/bup"
SRC_URI="https://github.com/bup/bup/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc test web"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/${PN}-${MY_PV}"

RDEPEND="${PYTHON_DEPS}
	app-arch/par2cmdline
	sys-libs/readline:0
	dev-vcs/git
	sys-apps/acl
	$(python_gen_cond_dep '
		dev-python/fuse-python[${PYTHON_USEDEP}]
		dev-python/pyxattr[${PYTHON_USEDEP}]
		web? ( www-servers/tornado[${PYTHON_USEDEP}] )
	')"
DEPEND="${RDEPEND}
	test? (
		dev-lang/perl
		net-misc/rsync
	)
	doc? ( app-text/pandoc )
"

# unresolved sandbox issues
RESTRICT="test"

PATCHES=( "${FILESDIR}"/${P}-sitedir.patch )

src_configure() {
	# only build/install docs if enabled
	export PANDOC=$(usex doc pandoc "")

	./configure || die
}

src_test() {
	emake test
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr DOCDIR="/usr/share/${PF}" \
		SITEDIR="$(python_get_sitedir)" install
	python_path="${PYTHON//\//\\/}"
	sed -i "s/.*config\/bin\/python\" || exit .*/bup_python=\"$python_path\"/" $ED$(python_get_sitedir)/cmd/*
	sed -i "s/.*config\/bin\/python.*/exec \"$python_path\" \"\$0\"/" $ED$(python_get_sitedir)/cmd/bup
	python_optimize "${ED}"
}
