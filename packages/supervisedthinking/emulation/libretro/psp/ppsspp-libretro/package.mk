# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="ppsspp-libretro"
#PKG_VERSION="$(get_pkg_version ${PKG_NAME::-9})"
PKG_VERSION="5fef404946411573545908cfd08bbcb64718dcf7"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="https://github.com/hrydgard/ppsspp.git"
PKG_DEPENDS_TARGET="toolchain sdl2 zlib ffmpeg bzip2 openssl speex"
PKG_LONGDESC="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"
PKG_NEED_UNPACK="$(get_pkg_directory ppsspp)"
PKG_BUILD_FLAGS="-sysroot"

PKG_LIBNAME="ppsspp_libretro.so"
PKG_LIBPATH="lib/${PKG_LIBNAME}"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi

  # Vulkan Support
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${VULKAN}"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                         -DUSE_DISCORD=OFF \
                         -DUSE_MINIUPNPC=OFF \
                         -DUSE_FFMPEG=ON \
                         -DUSE_SYSTEM_FFMPEG=OFF"

  if [ "${ARCH}" = "arm" ] && [ ! "${TARGET_CPU}" = "arm1176jzf-s" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DARMV7=ON"
  elif [ "${TARGET_CPU}" = "arm1176jzf-s" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DARM=ON"
  fi

  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DUSING_FBDEV=ON \
                             -DUSING_EGL=ON \
                             -DUSING_GLES2=ON"
  fi

  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    if [ "$DISPLAYSERVER" = "x11" ]; then
      PKG_CMAKE_OPTS_TARGET+=" -DUSING_X11_VULKAN=ON"
    elif [ "$DISPLAYSERVER" = "wl" ]; then
      PKG_CMAKE_OPTS_TARGET+=" -DUSING_X11_VULKAN=OFF \
                               -DUSE_WAYLAND_WSI=ON \
                               -DUSE_VULKAN_DISPLAY_KHR=ON"
    else
      PKG_CMAKE_OPTS_TARGET+=" -DUSING_X11_VULKAN=OFF \
                               -DUSE_VULKAN_DISPLAY_KHR=ON"
    fi
  else
    PKG_CMAKE_OPTS_TARGET+=" -DUSING_X11_VULKAN=OFF"
  fi
}

pre_make_target() {
  # fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed  -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch/bios/PPSSPP
    cp -rv assets/* ${INSTALL}/usr/share/retroarch/bios/PPSSPP/
}
