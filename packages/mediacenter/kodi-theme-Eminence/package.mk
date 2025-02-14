# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="kodi-theme-Eminence"
PKG_VERSION="1.0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="kodi eminence"
PKG_DEPENDS_UNPACK="kodi"
PKG_LONGDESC="Kodi Mediacenter Eminence theme."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/kodi/addons/skin.eminence
    cp -a $(get_build_dir eminence)/* ${INSTALL}/usr/share/kodi/addons/skin.eminence

  # Add Brave & Spotify shortcuts to menu
  if [ ! "${OEM_APPLICATIONS}" = "no" ] && [ "$PROJECT" = "Generic" ]; then
    echo "### Adding Brave & Spotify to Eminence menu ###"
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.eminence -l -p1 < ${PKG_DIR}/files/kodi-theme-Eminence-100.01-application-menu.patch
  fi

  # Add Moonlight shortcut to menu 
  if [ ! "${OEM_STREAMING_CLIENTS}" = "no" ]; then
    echo "### Adding Moonlight-Qt to Eminence menu ###"
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.eminence -l -p1 < ${PKG_DIR}/files/kodi-theme-Eminence-100.05-moonlight-qt-menu.patch
  fi

  # Add Emulationstation shortcut to menu 
  if [ ! "${OEM_EMULATORS}" = "no" ]; then
    echo "### Adding Emulationstation to Eminence menu ###"
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.eminence -l -p1 < ${PKG_DIR}/files/kodi-theme-Eminence-100.02-emulationstation-menu.patch
  fi

  # Add Retroarch shortcut to menu 
  if [ ! "${OEM_LIBRETRO}" = "no" ]; then
    echo "### Adding Retroarch to Eminence menu ###"
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.eminence -l -p1 < ${PKG_DIR}/files/kodi-theme-Eminence-100.03-retroarch-menu.patch
  fi

  # Add Pegasus Frontend shortcut to menu 
  if [ ! "${OEM_FRONTENDS_EXTRA}" = "no" ]; then
    echo "### Adding Pegasus-Frontend to Eminence menu ###"
    patch -d ${INSTALL}/usr/share/kodi/addons/skin.eminence -l -p1 < ${PKG_DIR}/files/kodi-theme-Eminence-100.04-pegasus-menu.patch
  fi
}
