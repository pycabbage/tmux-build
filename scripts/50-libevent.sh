#!/bin/bash

(

  LIBEVENT_VERSION=${LIBEVENT_VERSION:-"2.1.12-stable"}
  PREFIX=${PREFIX:-"/opt/prefix"}

  # ex. https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
  URL="https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz"
  ARCHIVE_FILENAME="${URL##*/}"
  ARCHIVE_PATH="${ARCHIVE_BASE}/${ARCHIVE_FILENAME}"
  BUILD_BASE=${BUILD_BASE:-"/opt/base"}
  BUILD_DIR=${BUILD_BASE:-"/opt/base"}/libevent-${LIBEVENT_VERSION}

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
  ./configure --prefix="${PREFIX}" --enable-static --enable-gcc-hardening --enable-function-sections --with-gnu-ld PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
  make -j$(nproc)
  make install
)
