#!/bin/bash
#
# emmenager.sh
# 
# (c) Niki Kovacs, 2014

CWD=$(pwd)

# Configuration de Bash
echo ":: Configuration de Bash pour l'administrateur."
cat $CWD/../bash/root-bash_aliases > /root/.bash_aliases
chown root:root /root/.bash_aliases
chmod 0644 /root/.bash_aliases

echo ":: Configuration de Bash pour les utilisateurs."
cat $CWD/../bash/user-bash_aliases > /etc/skel/.bash_aliases
chown root:root /etc/skel/.bash_aliases
chmod 0644 /etc/skel/.bash_aliases

# Configuration de Vim
echo ":: Configuration de Vim."
cat $CWD/../vim/vimrc.local > /etc/vim/vimrc.local
chmod 0644 /etc/vim/vimrc.local

# Configurer APT
echo ":: Configuration des dépôts de base pour APT."
cat $CWD/../apt/sources.list > /etc/apt/sources.list
chmod 0644 /etc/apt/sources.list

REPOSITORIES="tweaks-freya"

echo ":: Configuration des dépôts supplémentaires pour APT."
for REPOSITORY in $REPOSITORIES; do
  cat $CWD/../apt/$REPOSITORY.list > /etc/apt/sources.list.d/$REPOSITORY.list
  chmod 0644 /etc/apt/sources.list.d/$REPOSITORY.list
done

# Dépôt de paquets     clé GPG
# ------------------------------
# tweaks-freya         86F4A1C5

GPGKEYS="86F4A1C5"

for GPGKEY in $GPGKEYS; do
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $GPGKEY
done

# Recharger les informations et mettre à jour
apt-get update
apt-get -y dist-upgrade

# Supprimer les paquets inutiles
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/cholesterol)
apt-get -y autoremove --purge $CHOLESTEROL

# Installer les paquets supplémentaires
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/paquets)
apt-get -y install $PAQUETS

# Nettoyer les entrées de menu
cd ../cleanmenu/
./cleanmenu.sh
cd -

exit 1
