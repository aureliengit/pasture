#!/bin/bash
#
# 01-installer-outils.sh
#
# Ce script installe une panoplie d'outils de base sur un système minimal
# 
# (c) Niki Kovacs, 2016

CWD=$(pwd)

# Installer les outils de base
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/base)
yum check-update
yum -y install $PAQUETS

exit 0

