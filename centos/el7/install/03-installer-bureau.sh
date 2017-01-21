#!/bin/bash
#
# 03-installer-bureau.sh
#
# Ce script installe une panoplie d'applications pour un bureau GNOME, ainsi
# qu'une poignée de polices TrueType non fournies par les paquets
# 
# (c) Niki Kovacs, 2016

CWD=$(pwd)

# Supprimer le cholestérol
CRUFT=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/cruft)
yum -y remove $CRUFT

# Installer les applications
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/desktop)
yum check-update
yum -y install $PAQUETS

# Installer les polices Apple
if [ ! -d /usr/share/fonts/apple-fonts ]; then
  cd /tmp
  rm -rf /usr/share/fonts/apple-fonts
  wget -c http://www.microlinux.fr/download/FontApple.tar.xz
  mkdir /usr/share/fonts/apple-fonts
  tar xvf FontApple.tar.xz
  mv Lucida*.ttf Monaco.ttf /usr/share/fonts/apple-fonts/
  fc-cache -f -v
  cd -
fi

# Installer la police Eurostile
if [ ! -d /usr/share/fonts/eurostile ]; then
  cd /tmp
  rm -rf /usr/share/fonts/eurostile
  wget -c http://www.microlinux.fr/download/Eurostile.zip
  unzip Eurostile.zip -d /usr/share/fonts/
  mv /usr/share/fonts/Eurostile /usr/share/fonts/eurostile
  fc-cache -f -v
  cd -
fi

exit 0

