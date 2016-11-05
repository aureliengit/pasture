#!/bin/sh
#
# Gettext
set -e
cd $LFS/sources
rm -rf gettext-0.19.2
tar -xvf gettext-0.19.2.tar.xz
cd gettext-0.19.2
cd gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared
make -j 5 -C gnulib-lib
make -j 5 -C src msgfmt
make -j 5 -C src msgmerge
make -j 5 -C src xgettext
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
cd $LFS/sources
rm -rf gettext-0.19.2


