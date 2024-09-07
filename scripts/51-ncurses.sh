#!/bin/bash

(
  NCURSES_VERSION=${NCURSES_VERSION:-"6.5"}
  PREFIX=${PREFIX:-"/opt/prefix"}

  URL="https://invisible-mirror.net/archives/ncurses/ncurses-${NCURSES_VERSION}.tar.gz"
  ARCHIVE_FILENAME="${URL##*/}"
  ARCHIVE_PATH="${ARCHIVE_BASE}/${ARCHIVE_FILENAME}"
  BUILD_BASE=${BUILD_BASE:-"/opt/base"}
  BUILD_DIR=${BUILD_BASE:-"/opt/base"}/ncurses-${NCURSES_VERSION}

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

  ./configure \
    --prefix=$PREFIX \
    --with-install-prefix=$PREFIX \
    --with-pkg-config \
    --with-pkg-config-libdir="${PREFIX}/lib/pkgconfig" \
    --enable-pc-files \
    --without-manpages \
    --with-libtool \
    --with-termlib \
    --enable-rpath \
    --with-gpm \
    --with-pcre2 \
    --with-sysmouse \
    --enable-termcap \
    --enable-getcap \
    --enable-getcap-cache \
    --enable-symlinks \
    --enable-wattr-macros \
    --enable-signed-char \
    --with-rcs-ids \
    --enable-sp-funcs \
    --enable-const \
    --enable-ext-colors \
    --enable-ext-mouse \
    --enable-ext-putwin \
    --enable-no-padding \
    --enable-sigwinch \
    --enable-tcap-names \
    --with-pthread \
    --enable-pthreads-eintr \
    --enable-weak-symbols \
    --enable-reentrant \
    --enable-check-size \
    --enable-hard-tabs \
    --enable-xmc-glitch \
    --enable-colorfgbg \
    --enable-interop \
    --enable-safe-sprintf \
    --enable-wgetch-events \
    --enable-stdnoreturn \
    --enable-string-hacks

  make -j$(nproc)
  make install
)
