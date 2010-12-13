# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit git autotools eutils

DESCRIPTION="Persistent distributed key-value data caching system."
HOMEPAGE="http://code.google.com/p/redis/"

EGIT_REPO_URI="git://github.com/antirez/redis.git"
EGIT_COMMIT="refs/tags/2.2-alpha6"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SLOT="0"

RDEPEND=""
DEPEND="test? ( dev-lang/tcl )"

REDIS_PIDDIR=/var/run/redis/
REDIS_PIDFILE=${REDIS_PIDDIR}/redis.pid
REDIS_DATAPATH=/var/lib/redis
REDIS_LOGPATH=/var/log/redis
REDIS_LOGFILE=${REDIS_LOGPATH}/redis.log

pkg_setup() {
	enewgroup redis 75 || die "problem adding 'redis' group"
	enewuser redis 75 -1 ${REDIS_DATAPATH} redis || die "problem adding 'redis' user"
}

src_prepare() {
	# Now autotoolize this
	cp "${FILESDIR}"/configure.ac-master configure.ac
	mv src/Makefile src/Makefile.in
	sed -i \
		-e 's:$(CC):@CC@:g' \
		-e 's:$(CFLAGS):@AM_CFLAGS@:g' \
		-e 's: $(DEBUG)::g' \
		-e 's: ARCH="$(ARCH)"::g' \
		-e 's: $(ARCH)::g' \
		-e 's:PROF:GCC_PROF_FLAG:g' \
		src/Makefile.in \
	|| die "sed failed!"
	sed -i \
        -e 's: $(ARCH)::g' \
        deps/hiredis/Makefile \
    || die "sed failed!"
	sed -i \
        -e 's: $(ARCH)::g' \
        deps/linenoise/Makefile \
    || die "sed failed!"



	eautoreconf
}

src_install() {
	# configuration file rewrites
	insinto /etc/
	sed -r \
		-e "/^pidfile\>/s,/var.*,${REDIS_PIDFILE}," \
		-e '/^daemonize\>/s,no,yes,' \
		-e '/^# bind/s,^# ,,' \
		-e '/^# maxmemory\>/s,^# ,,' \
		-e '/^maxmemory\>/s,<bytes>,67108864,' \
		-e "/^dbfilename\>/s,dump.rdb,${REDIS_DATAPATH}/dump.rdb," \
		-e "/^dir\>/s, .*, ${REDIS_DATAPATH}/," \
		-e '/^loglevel\>/s:debug:notice:' \
		-e "/^logfile\>/s:stdout:${REDIS_LOGFILE}:" \
		<redis.conf \
		>redis.conf.gentoo
	newins redis.conf.gentoo redis.conf
	fowners root:redis /etc/redis.conf
	fperms 0640 /etc/redis.conf

	newconfd "${FILESDIR}/redis.confd" redis
	newinitd "${FILESDIR}/redis.initd" redis

	dodoc BUGS Changelog README TODO
	newdoc client-libraries/README README.client-libraries
	dohtml doc/*

	dobin src/redis-benchmark src/redis-cli src/redis-check-aof src/redis-check-dump
	dosbin src/redis-server

	diropts -m0750 -o redis -g redis
	keepdir ${REDIS_DATAPATH} ${REDIS_LOGPATH} ${REDIS_PIDDIR}
}

src_test() {
	make test || die "Tests failed"
}
