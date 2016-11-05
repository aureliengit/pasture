#!/bin/bash
RSYNC=$(which rsync)
CWD=$(pwd)
LOCALSTUFF=$CWD/..
RSYNCUSER=kikinovak
SERVER=localhost
SERVERDIR=/mnt/sda2/home/kikinovak/slick
$RSYNC -av $LOCALSTUFF --exclude '.git*' $RSYNCUSER@$SERVER:$SERVERDIR 

