#!/bin/sh
#
# Util-linux
set -e
cd $LFS/sources
rm -rf util-linux-2.25.1
tar -xvf util-linux-2.25.1.tar.xz
cd util-linux-2.25.1
./configure --prefix=/tools                \
            --without-python               \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG=""
make -j 5
make install
cd $LFS/sources
rm -rf util-linux-2.25.1

