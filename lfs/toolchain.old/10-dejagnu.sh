#!/bin/sh
#
# DejaGNU
set -e
cd $LFS/sources
rm -rf dejagnu-1.5.1
tar -xvf dejagnu-1.5.1.tar.gz
cd dejagnu-1.5.1
./configure --prefix=/tools
make -j 5
make install
#make check
cd $LFS/sources
rm -rf dejagnu-1.5.1


