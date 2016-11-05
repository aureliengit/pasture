#!/bin/sh
#
# File
set -e
cd $LFS/sources
rm -rf file-5.19
tar -xvf file-5.19.tar.gz
cd file-5.19
./configure --prefix=/tools
make -j 5
#make check
make install
cd $LFS/sources
rm -rf file-5.19

