#!/bin/sh
#
# 04-nettoyer-menus.sh
#
# Ce script installe les entrées de menus personnalisées
#
# (c) Niki Kovacs, 2016

CWD=$(pwd)
ENTRIESDIR=$CWD/../desktop
ENTRIES=`ls $ENTRIESDIR` 
MENUDIRS="  /usr/share/applications \
            /usr/share/gimp/2.0/misc"

for MENUDIR in $MENUDIRS; do
	for ENTRY in $ENTRIES; do
		if [ -r $MENUDIR/$ENTRY ]; then
			echo ":: Updating $ENTRY."
			cat $ENTRIESDIR/$ENTRY > $MENUDIR/$ENTRY
		fi
	done
done

/usr/bin/update-desktop-database

