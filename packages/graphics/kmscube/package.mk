# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kmscube"
PKG_VERSION="9f63f359fab1b5d8e862508e4e51c9dfe339ccb0"
PKG_SHA256="8c88f779a635c424507bf9beb68147ff34a2f0bede591846000a07d25f6ac9f1"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.freedesktop.org/mesa/kmscube"
PKG_URL="https://gitlab.freedesktop.org/mesa/kmscube/-/archive/master/kmscube-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Example KMS/GBM/EGL application"

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
elif [ "${OPENGL_SUPPORT}" = "yes" ]; then
  echo "kmscube only supports OpenGLESv2"
  exit 0
fi
