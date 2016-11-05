#!/bin/sh
#
# Glibc
set -e
cd $LFS/sources
rm -rf glibc-2.20 glibc-build
tar -xvf glibc-2.20.tar.xz
mkdir glibc-build
cd glibc-build
../glibc-2.20/configure                             \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.20/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes
make -j 5
make install
cd $LFS/sources
rm -rf glibc-2.20 glibc-build
echo "######## TEST ########"
echo 'main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out
echo "######################"




