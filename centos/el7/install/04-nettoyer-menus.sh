#!/bin/bash
#
# 04-nettoyer-menus.sh
#
# Ce script remplace les entrées de menu KDE par défaut par une panoplie
# d'entrées de menu personnalisées.
# 
# (c) Niki Kovacs, 2016

CWD=$(pwd)
ENTRIESDIR=$CWD/../desktop
ENTRIES=`ls $ENTRIESDIR` 
MENUDIRS="/usr/share/applications"

echo
echo ":: Configuration des catégories de menu."
cat $ENTRIESDIR/gnome-applications.menu.custom > \
  /etc/xdg/menus/gnome-applications.menu

for MENUDIR in $MENUDIRS; do
	for ENTRY in $ENTRIES; do
		if [ -r $MENUDIR/$ENTRY ]; then
			echo ":: Configuration de l'entrée de menu $ENTRY."
			cat $ENTRIESDIR/$ENTRY > $MENUDIR/$ENTRY
		fi
	done
done

# L'entrée de menu pour OpenJDK est une cible mouvante
OPENJDK=$(find /usr/share/applications -name 'java*openjdk*.desktop')
if [ ! -z "$OPENJDK" ]; then
  if ! grep -q "NoDisplay" "$OPENJDK" ; then
    echo "NoDisplay=true" >> $OPENJDK
	  echo ":: Configuration de l'entrée de menu $(basename $OPENJDK)."
  fi
fi

echo 

exit 0
