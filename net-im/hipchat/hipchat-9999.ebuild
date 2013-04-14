# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="A Hipchat client"
HOMEPAGE="http://www.skype.com/"

SRC_URI_AMD64="http://downloads.hipchat.com/linux/arch/hipchat-x86_64.tar.xz"
SRC_URI_X86="http://downloads.hipchat.com/linux/arch/hipchat-i686.tar.xz"
SRC_URI="
    amd64? ( ${SRC_URI_AMD64} )
	x86? ( ${SRC_URI_X86} )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}

src_install() {
	doins -r *
	fperms 0755 /opt/HipChat/bin/hipchat /opt/HipChat/lib/hipchat.bin
}
