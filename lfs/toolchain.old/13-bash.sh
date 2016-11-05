#!/bin/sh
#
# Bash
set -e
cd $LFS/sources
rm -rf bash-4.3
tar -xvf bash-4.3.tar.gz
cd bash-4.3
./configure --prefix=/tools --without-bash-malloc
make -j 5
#make tests
make install
ln -sv bash /tools/bin/sh
cd $LFS/sources
rm -rf bash-4.3


