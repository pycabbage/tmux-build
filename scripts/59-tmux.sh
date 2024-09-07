#!/bin/bash

(
  TMUX_VERSION=${TMUX_VERSION:-"3.4"}
  PREFIX=${PREFIX:-"/opt/prefix"}

  URL="https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"
  ARCHIVE_FILENAME="${URL##*/}"
  ARCHIVE_PATH="${ARCHIVE_BASE}/${ARCHIVE_FILENAME}"
  BUILD_BASE=${BUILD_BASE:-"/opt/base"}
  BUILD_DIR=${BUILD_BASE:-"/opt/base"}/tmux-${TMUX_VERSION}

  if [ -d "${BUILD_DIR}" ]; then
    echo "Directory ${BUILD_DIR} exists, removing"
    rm -fr "${BUILD_DIR}"
  fi

  if [ ! -f "${ARCHIVE_PATH}" ]; then
    echo "File ${ARCHIVE_PATH} not found, downloading ..."
    curl -kLo "${ARCHIVE_PATH}" "${URL}"
  else
    echo "File ${ARCHIVE_PATH} exists"
  fi

  tar axf "${ARCHIVE_PATH}" -C "${BUILD_BASE}"
  cd "${BUILD_DIR}"
  ./configure --prefix=$PREFIX --enable-static --enable-utempter --enable-utf8proc --enable-sixel PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
  make -j$(nproc)
  make install
)
