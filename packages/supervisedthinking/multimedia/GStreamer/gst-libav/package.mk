# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="gst-libav"
PKG_VERSION="$(get_pkg_version gstreamer)"
PKG_SHA256="0e48407b4905227a260213dbda84cba3812f0530fc7a75b43829102ef82810f1"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://gstreamer.freedesktop.org/modules/gst-libav.html"
PKG_URL="https://gstreamer.freedesktop.org/src/gst-libav/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gstreamer gst-plugins-base ffmpeg"
PKG_LONGDESC="GStreamer plugin for the FFmpeg libav library"
