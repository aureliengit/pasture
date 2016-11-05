#!/bin/sh
#
# Patch
set -e
cd $LFS/sources
rm -rf patch-2.7.1
tar -xvf patch-2.7.1.tar.xz
cd patch-2.7.1
./configure --prefix=/tools
make -j 5
#make check
make install
cd $LFS/sources
rm -rf patch-2.7.1
