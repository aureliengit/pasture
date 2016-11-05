#!/bin/bash
#
# emmenager.sh
# 
# (c) Niki Kovacs, 2014

CWD=$(pwd)

# Configuration de Bash
echo ":: Configuration de Bash pour l'administrateur."
cat $CWD/../bash/root-bashrc > /root/.bashrc

echo ":: Configuration de Bash pour les utilisateurs."
cat $CWD/../bash/user-alias > /etc/skel/.alias

echo ":: Configuration de XTerm."
cat $CWD/../xterm/Xresources > /etc/skel/.Xresources

echo ":: Configuration de Vim."
cat $CWD/../vim/vimrc > /etc/vimrc

echo ":: Configuration des dépôts de paquets."
rm -f /etc/zypp/repos.d/*.repo
cp -a $CWD/../repos/*.repo /etc/zypp/repos.d/
zypper refresh

echo ":: Suppression des paquets inutiles."
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/kde-remove)
zypper remove -y --clean-deps $CHOLESTEROL

echo ":: Installation des paquets supplémentaires."
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/kde-add)
zypper install -y $PAQUETS





