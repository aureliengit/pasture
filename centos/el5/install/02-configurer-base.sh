#!/bin/bash
#
# 02-configurer-base.sh
#
# Ce script configure Bash et Vim pour root et les utilisateurs
# 
# (c) Niki Kovacs, 2016

CWD=$(pwd)

echo

echo ":: Configuration de Bash pour l'administrateur."
cat $CWD/../bash/bashrc-root > /root/.bashrc

echo ":: Configuration de Bash pour les utilisateurs."
cat $CWD/../bash/bashrc-users > /etc/skel/.bashrc

echo ":: Configuration de Vim."
cat $CWD/../vim/vimrc > /etc/vimrc

echo

exit 0
