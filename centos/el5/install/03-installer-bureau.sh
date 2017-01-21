#!/bin/bash
#
# 03-installer-bureau.sh
#
# Ce script installe une panoplie d'applications pour un bureau GNOME
# 
# (c) Niki Kovacs, 2016

CWD=$(pwd)

# Installer les applications
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/desktop)
yum check-update
yum -y install $PAQUETS

exit 0

