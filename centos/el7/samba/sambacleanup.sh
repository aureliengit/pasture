#!/bin/sh
#
# sambacleanup.sh

FIND=/usr/bin/find
RM=/usr/bin/rm

SHARES="/srv/samba/public \
        /srv/samba/confidentiel"

for SHARE in $SHARES; do
  if [ -d $SHARE/.Corbeille ]; then
    $FIND $SHARE/.Corbeille -mtime +60 -exec $RM -rf {} \;
  fi
done
