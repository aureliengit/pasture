#!/bin/bash
#
# menus.sh
# (c) Niki Kovacs, 2008

CWD=$(pwd)
ENTRIESDIR=$CWD/../menus
ENTRIES=`ls $ENTRIESDIR` 
MENUDIRS="  /usr/share/applications \
            /usr/share/applications/kde4"

for MENUDIR in $MENUDIRS; do
	for ENTRY in $ENTRIES; do
		if [ -r $MENUDIR/$ENTRY ]; then
			echo ":: Mise à jour de l'entrée de menu $ENTRY."
			cat $ENTRIESDIR/$ENTRY > $MENUDIR/$ENTRY
		fi
	done
done

