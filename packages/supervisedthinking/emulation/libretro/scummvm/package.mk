# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="scummvm"
PKG_VERSION="a0554745e87361643f1ca3aa820a5073214de935" #v2.6.1.3
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="https://github.com/libretro/scummvm.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ScummVM is an interpreter for point-and-click adventure games that can be used as a libretro core."
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-sysroot +speed"

PKG_LIBNAME="scummvm_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    if [ "${DEVICE}" = "RPi2" ]; then
      PKG_MAKE_OPTS_TARGET+=" platform=armv7"
    else
      PKG_MAKE_OPTS_TARGET+=" platform=armv8"
    fi
    # ARM NEON support
    if target_has_feature neon; then
      PKG_MAKE_OPTS_TARGET+="-neon"
    fi
    PKG_MAKE_OPTS_TARGET+="-${TARGET_FLOAT}float-${TARGET_CPU}"
  else
    PKG_MAKE_OPTS_TARGET+=" BUILD_64BIT=1"
  fi
}

pre_make_target() {
  # Fix build path
  cd ${PKG_BUILD}

  if [ ! "${ARCH}" = "x86_64" ]; then
    CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  fi
}

pre_makeinstall_target() {
  # Rebuild ScummVM auxiliary data
  echo -e "\n### Rebuild ScummVM auxiliary data ####\n"
  make datafiles
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch/bios
  unzip ${PKG_BUILD}/scummvm.zip -d ${INSTALL}/usr/share/retroarch/bios
  cat << EOF > ${INSTALL}/usr/share/retroarch/bios/scummvm.ini
[scummvm]
soundfont=/storage/.config/soundfonts/MuseScore_General.sf3
extrapath=/tmp/emulation/bios/scummvm/extra
browser_lastpath=/tmp/emulation/bios/scummvm/extra
themepath=/tmp/emulation/bios/scummvm/theme
guitheme=scummmodern
EOF
}
