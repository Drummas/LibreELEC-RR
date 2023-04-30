# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)


PKG_NAME="eminence"
PKG_VERSION="v4.1.20b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SHA256="38da3342e2c0d4d597fd2a2833b046c7fc98c82a454e5396d70e07bc2eb953d4"
PKG_SITE="https://github.com/jurialmunkey/skin.eminence.2"
PKG_URL="https://github.com/jurialmunkey/skin.eminence.2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform pugixml zlib xz"
PKG_DEPENDS_UNPACK="kodi"
PKG_SECTION="skin"
PKG_SHORTDESC="Kodi skin Eminence"
PKG_LONGDESC="Kodi skin Eminence"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Eminence"
PKG_ADDON_TYPE="xbmc.gui.skin"
