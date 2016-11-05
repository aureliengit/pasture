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

# Dépôt MATE (non signé)
echo ":: Configuration des dépôts supplémentaires pour APT."
cat $CWD/../apt/mate.list > /etc/apt/sources.list.d/mate.list
chmod 0644 /etc/apt/sources.list.d/mate.list

# Recharger les informations et mettre à jour
apt-get update
apt-get -y dist-upgrade

# Supprimer les paquets inutiles
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/cholesterol)
apt-get -y autoremove --purge $CHOLESTEROL

# Installer les paquets supplémentaires
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/paquets)
apt-get -y --force-yes install $PAQUETS

# Ranger les fonds d'écran à leur place
echo ":: Installation des fonds d'écran supplémentaires."
if [ -d /usr/share/backgrounds ]; then
	cp -f $CWD/../backgrounds/* /usr/share/backgrounds/
fi

# Ranger les icônes à leur place
echo ":: Installation des icônes supplémentaires."
if [ -d /usr/share/pixmaps ]; then
  cp -f $CWD/../pixmaps/* /usr/share/pixmaps/
fi

# Activer les polices Bitmap
echo ":: Activation des polices Bitmap."
if [ -h /etc/fonts/conf.d/70-no-bitmaps.conf ]; then
	rm -f /etc/fonts/conf.d/70-no-bitmaps.conf
	ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/
	dpkg-reconfigure fontconfig
fi

# Polices TrueType Windows Vista & Eurostile
cd /tmp
rm -rf /usr/share/fonts/truetype/{Eurostile,vista}
wget -c http://www.microlinux.fr/download/Eurostile.zip
wget -c http://avi.alkalay.net/software/webcore-fonts/webcore-fonts-3.0.tar.gz
tar xvzf webcore-fonts-3.0.tar.gz
mv webcore-fonts/vista /usr/share/fonts/truetype/
unzip Eurostile.zip -d /usr/share/fonts/truetype/
fc-cache -f -v
cd -

# Nettoyer les entrées de menu
cd ../cleanmenu/
./cleanmenu.sh
cd -

# Installer le profil par défaut
rm -rf /etc/skel/.config/
cd ../skel/
tar xvjf config.tar.bz2 -C /etc/skel/
cd -

exit 1
