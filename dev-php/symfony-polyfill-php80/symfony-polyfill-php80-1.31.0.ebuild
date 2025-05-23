# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Symfony polyfill backporting some PHP 8.0+ features to lower PHP versions"
HOMEPAGE="https://github.com/symfony/polyfill-php80"
SRC_URI="https://github.com/symfony/polyfill-php80/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/polyfill-php80-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

BDEPEND="dev-php/theseer-Autoload"

RDEPEND="
	>=dev-lang/php-7.2:*
	dev-php/fedora-autoloader
"

src_prepare() {
	default

	phpab \
		--quiet \
		--output autoload.php \
		--template fedora2 \
		--basedir . \
		. \
		|| die
	echo "require_once __DIR__ . \"/bootstrap.php\";" >> autoload.php

}

src_install() {
	insinto "/usr/share/php/Symfony/Polyfill/Php80"
	doins -r *.php LICENSE Resources
}
