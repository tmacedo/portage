# Copyright 1999-2009 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit python rpm

DESCRIPTION="HSO UMTS PyGTK Connection Manager"
SUPPORT_PYTHON_ABIS="1"
HOMEPAGE="http://www.pharscape.org/"
SRC_URI="http://www.pharscape.org/Downloads.html/RPM/hsoconnect-py2.5-1.1.128-2.noarch.rpm"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND="dev-lang/python
	net-dialup/hsolink
	sys-apps/usb_modeswitch
	sys-fs/udev"

src_unpack() {
	rpm_src_unpack ${A}
	mkdir "${WORKDIR}/${P}"
	mv "${WORKDIR}/usr" "${WORKDIR}/${P}"
	mv "${WORKDIR}/${P}/usr/lib/python2.5/site-packages" "${WORKDIR}/${P}"
	rmdir "${WORKDIR}/${P}/usr/lib/python2.5"
	mkdir "${WORKDIR}/${P}/usr/bin"
	cp "${FILESDIR}/hsoc" "${WORKDIR}/${P}/usr/bin/"
}

src_install() {
    installation() {
		mkdir -p "${WORKDIR}/${P}$(python_get_sitedir)"
		cp -r "${WORKDIR}/${P}/site-packages"/* "${WORKDIR}/${P}/$(python_get_sitedir)"
    }
    python_execute_function installation
	rm -r "${WORKDIR}/${P}/site-packages"

	chmod -R go-w "${WORKDIR}/${P}/usr/"
	chgrp -R uucp "${WORKDIR}/${P}/usr/share/HSOconnect/"
	chmod g+sw "${WORKDIR}/${P}//usr/share/HSOconnect/"
	chmod -R g+w "${WORKDIR}/${P}/usr/share/HSOconnect/HSOconnect.cfg"
	chmod -R g+w "${WORKDIR}/${P}/usr/share/HSOconnect/profiles/"
	chmod g+s "${WORKDIR}/${P}"/usr/share/HSOconnect/profiles/*/
	mv "${WORKDIR}/${P}"/* "${D}"

	insinto /etc/udev/rules.d/
	doins "${FILESDIR}"/91-usb_modeswitch.rules

	echo 'CONFIG_PROTECT="/usr/share/HSOconnect"' > "${T}/50${PN}"
	echo 'CONFIG_PROTECT_MASK="/usr/share/HSOconnect/images /usr/share/HSOconnect/languages"' >> "${T}/50${PN}"
	doenvd "${T}/50${PN}"
}

