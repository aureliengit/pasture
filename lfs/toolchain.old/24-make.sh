#!/bin/sh
#
# Make
set -e
cd $LFS/sources
rm -rf make-4.0
tar -xvf make-4.0.tar.bz2
cd make-4.0
./configure --prefix=/tools --without-guile
make -j 5
#make check
make install
cd $LFS/sources
rm -rf make-4.0
