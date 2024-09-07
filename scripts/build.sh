#!/bin/bash -e

PREFIX=${PREFIX:-"/opt/prefix"}
OUTPUT_DIR=${OUTPUT_DIR:-"/opt/output"}

LIBEVENT_VERSION=${LIBEVENT_VERSION:-"2.1.12-stable"}
NCURSES_VERSION=${NCURSES_VERSION:-"6.5"}
TMUX_VERSION=${TMUX_VERSION:-"3.4"}

LIBEVENT_VERSION=2.1.12-stable
NCURSES_VERSION=6.5
TMUX_VERSION=3.4


echo "libevent: ${LIBEVENT_VERSION}"
echo "ncurses: ${NCURSES_VERSION}"
echo "tmux: ${TMUX_VERSION}"

mkdir -p ./prefix ./base

# Fix install bug
mkdir -p $(dirname "${PREFIX}${PREFIX}")
ln -s "${PREFIX}" "${PREFIX}${PREFIX}"

./scripts/50-libevent.sh
./scripts/51-ncurses.sh
./scripts/59-tmux.sh

# After install, remove symbolic link for prefix
PREFIXS=(${PREFIX//// })
rm -fr "${PREFIX}/${PREFIXS[0]}"

echo cp $PREFIX/bin/tmux $OUTPUT_DIR/tmux
cp $PREFIX/bin/tmux $OUTPUT_DIR/tmux

ls -l $PREFIX/bin/tmux $OUTPUT_DIR/tmux
