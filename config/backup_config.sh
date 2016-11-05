#!/bin/sh
# backup_config.sh
#
# Ce script effectue une sauvegarde des fichiers de configuration essentiels du
# système.
#
# (c) Niki Kovacs, 2014

CWD=$(pwd)

FILES=$(egrep -v '(^\#)|(^\s+$)' $CWD/files)

NETWORK=$(hostname --domain) 

MACHINE=$(hostname --short)

BACKUPDIR=$CWD/$NETWORK/$MACHINE

if [ ! -d $BACKUPDIR ]; then
  echo ":: Création du répertoire de sauvegarde local."
  mkdir -p $BACKUPDIR
else
  echo ":: Le répertoire de sauvegarde local existe déjà."
fi

for FILE in $FILES; do
  if [ -r $FILE ]; then
    BASENAME=$(basename $FILE)
    ABSPATH=$(dirname $FILE)
    RELPATH=$(echo $ABSPATH | cut -c2- )
    if [ ! -d $BACKUPDIR/$RELPATH ]; then
      mkdir -p $BACKUPDIR/$RELPATH
    fi
    echo ":: Sauvegarde du fichier $FILE"
    cp -af $FILE $BACKUPDIR/$RELPATH/
  else
    echo "Le fichier $FILE n'existe pas sur cette machine."
  fi
done



