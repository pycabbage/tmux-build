#!/bin/bash

(
  CACHEDIR=${CACHEDIR:-"/tmp/cache"}
  VERSION=${VERSION:-"1-alpha-20240109-1"}
  ARCHIVE_FILENAME="linuxdeploy-x86_64.AppImage"
  ARCHIVE_FILEPATH="${CACHEDIR}/${ARCHIVE_FILENAME}"
  # https://github.com/linuxdeploy/linuxdeploy/releases/download/1-alpha-20240109-1/linuxdeploy-x86_64.AppImage
  URL="https://github.com/linuxdeploy/linuxdeploy/releases/download/1-alpha-20240109-1/${ARCHIVE_FILENAME}"

  DEPLOY_PATH="/opt/linuxdeploy"

  if [ ! -d "${DEPLOY_PATH}" ]; then
    echo "${DEPLOY_PATH} does not exists"
    if [ ! -f "${ARCHIVE_FILEPATH}" ]; then
      echo "Downloading to ${ARCHIVE_FILEPATH} ..."
      curl -kLo "${ARCHIVE_FILEPATH}" "${URL}"
    else
      echo "File ${ARCHIVE_FILEPATH} already exists"
    fi
    chmod +x "${ARCHIVE_FILEPATH}"
    cd "${DEPLOY_PATH}/.."
    "${ARCHIVE_FILEPATH}" --appimage-extract
    mv squashfs-root "${DEPLOY_PATH}"
    chmod 
  else
    echo "Directory ${DEPLOY_PATH} already exists"
  fi
)
