#!/bin/bash
#
# emmenager.sh
# 
# (c) Niki Kovacs, 2015

CWD=$(pwd)

# Configuration de Bash
echo ":: Configuration de Bash pour l'administrateur."
cat $CWD/../bash/root-bashrc > /root/.bashrc

echo ":: Configuration de Bash pour les utilisateurs."
cat $CWD/../bash/user-alias > /etc/skel/.alias

echo ":: Configuration de Vim."
cat $CWD/../vim/vimrc > /etc/vimrc

echo ":: Configuration des dépôts de paquets."
rm -f /etc/zypp/repos.d/*.repo
cp -a $CWD/../repos/*.repo /etc/zypp/repos.d/
zypper refresh

#echo ":: Remplacements des paquets de base."
#zypper --non-interactive dist-upgrade

echo ":: Suppression des paquets inutiles."
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/gnome-remove)
zypper --non-interactive remove --clean-deps $CHOLESTEROL

echo ":: Installation des paquets supplémentaires."
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/gnome-add)
zypper --non-interactive install $PAQUETS





