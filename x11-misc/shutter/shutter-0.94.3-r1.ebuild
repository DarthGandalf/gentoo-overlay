# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit xdg-utils desktop

DESCRIPTION="Feature-rich screenshot program"
HOMEPAGE="http://shutter-project.org/"
#SRC_URI="http://shutter-project.org/wp-content/uploads/releases/tars/${P}.tar.gz"
SRC_URI="https://launchpad.net/shutter/0.9x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="dev-lang/perl
	dev-perl/libxml-perl
	dev-perl/gnome2-canvas
	dev-perl/gnome2-perl
	dev-perl/gnome2-wnck
	dev-perl/Gtk2-Unique
	dev-perl/Gtk2-ImageView
	dev-perl/File-DesktopEntry
	dev-perl/File-HomeDir
	dev-perl/File-Which
	dev-perl/JSON
	dev-perl/File-Copy-Recursive
	dev-perl/File-MimeInfo
	dev-perl/Locale-gettext
	dev-perl/Net-DBus
	dev-perl/Proc-Simple
	dev-perl/Proc-ProcessTable
	dev-perl/Sort-Naturally
	dev-perl/WWW-Mechanize
	dev-perl/X11-Protocol
	dev-perl/XML-Simple
	dev-perl/libwww-perl
	virtual/imagemagick-tools[perl]
	!minimal? (
		dev-libs/libappindicator
		dev-perl/Goo-Canvas
		dev-perl/JSON-MaybeXS
		dev-perl/Net-OAuth
		dev-perl/Path-Class
		media-libs/exiftool
	)
"

src_prepare() {
	default

	use minimal && eapply "${FILESDIR}"/${PN}-0.90-goocanvas.patch

	#Fix tray icon because it doesn't pick the right icon using various themes
	sed -i -e "/\$tray->set_from_icon_name/s:set_from_icon_name:set_from_file:" \
	-e "s:shutter-panel:/usr/share/icons/hicolor/scalable/apps/&.svg:" \
	bin/shutter || die "failed to fix trayicon"
}

src_install() {
	dobin bin/${PN}
	insinto /usr/share/${PN}
	doins -r share/${PN}/*
	dodoc README
	domenu share/applications/${PN}.desktop
	# Man page is broken. Reconstruct it.
	gunzip share/man/man1/${PN}.1.gz || die "gunzip failed"
	doman share/man/man1/${PN}.1
	doicon share/pixmaps/${PN}.png
	doins -r share/locale
	insinto /usr/share/icons/hicolor
	doins -r share/icons/hicolor/*
	find "${D}"/usr/share/shutter/resources/system/plugins/ -type f ! -name '*.*' -exec chmod 755 {} \; \
		|| die "failed to make plugins executables"
	find "${D}"/usr/share/shutter/resources/system/upload_plugins/upload -type f \
		-name "*.pm" -exec chmod 755 {} \; || die "failed to make upload plugins executables"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
