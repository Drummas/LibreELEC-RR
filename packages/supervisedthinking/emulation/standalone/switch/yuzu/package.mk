# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="yuzu"
PKG_VERSION="mainline-0-1270" #r0.1270
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://yuzu-emu.org/"
PKG_URL="https://github.com/yuzu-emu/yuzu-mainline.git"
PKG_DEPENDS_TARGET="toolchain enet-system libfmt lz4 opus-system zlib zstd nlohmann-json qt5"
PKG_LONGDESC="Nintendo Switch Emulator"
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="+gold -sysroot"

configure_package() {
  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # Vulkan Support
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${VULKAN}"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-D ENABLE_SDL2=ON \
                         -D YUZU_USE_BUNDLED_SDL2=OFF \
                         -D YUZU_USE_EXTERNAL_SDL2=OFF \
                         -D ENABLE_QT=ON \
                         -D ENABLE_QT6=OFF \
                         -D ENABLE_QT_TRANSLATION=OFF \
                         -D ENABLE_WEB_SERVICE=OFF \
                         -D YUZU_USE_QT_MULTIMEDIA=ON \
                         -D YUZU_USE_QT_WEB_ENGINE=OFF \
                         -D ENABLE_CUBEB=ON \
                         -D USE_DISCORD_PRESENCE=OFF \
                         -D YUZU_TESTS=OFF \
                         -D YUZU_USE_PRECOMPILED_HEADERS=ON \
                         -D YUZU_USE_BUNDLED_VCPKG=OFF \
                         -D YUZU_CHECK_SUBMODULES=OFF \
                         -Wno-dev"

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_OPENGL=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_OPENGL=OFF"
  fi
}

post_makeinstall_target() {
  # Copy binary, scripts & config files
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/

  mkdir -p ${INSTALL}/usr/config/yuzu
    cp -PR ${PKG_DIR}/config/* ${INSTALL}/usr/config/yuzu

  # Clean up
  safe_remove ${INSTALL}/usr/bin/yuzu-cmd
  safe_remove ${INSTALL}/usr/share
}
