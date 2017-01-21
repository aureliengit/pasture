#!/bin/bash
#
# 04-nettoyer-menus.sh
#
# Ce script remplace les entrées de menu GNOME par défaut par une panoplie
# d'entrées de menu personnalisées.
# 
# (c) Niki Kovacs, 2016

CWD=$(pwd)
ENTRIESDIR=$CWD/../desktop
ENTRIES=`ls $ENTRIESDIR` 
MENUDIRS="/usr/share/applications"

for MENUDIR in $MENUDIRS; do
	for ENTRY in $ENTRIES; do
		if [ -r $MENUDIR/$ENTRY ]; then
			echo ":: Configuration de l'entrée de menu $ENTRY."
			cat $ENTRIESDIR/$ENTRY > $MENUDIR/$ENTRY
		fi
	done
done

