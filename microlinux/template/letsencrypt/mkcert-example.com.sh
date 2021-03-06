#!/bin/bash
#
# Create/renew SSL/TLS certificates for example.com

DOMAIN="example.com"
DIRNAM="example"
ENCRYPT="/usr/bin/letsencrypt"
CHGRP="/usr/bin/chgrp"
CHMOD="/usr/bin/chmod"
CERTGRP="certs"
EMAIL="info@microlinux.fr"
OPTIONS="certonly \
         --standalone-supported-challenges tls-sni-01 \
         --email $EMAIL \
         --renew-by-default \
         --agree-tos \
         --text \
         --standalone"

# Create $CERTGRP group 
if ! grep -q "^$CERTGRP:" /etc/group ; then
  groupadd -g 240 $CERTGRP
  echo ":: Added $CERTGRP group."
  sleep 3
fi

# Stop Apache
echo ":: Stopping Apache."
if ps ax | grep -v grep | grep httpd > /dev/null ; then
  /etc/rc.d/rc.httpd stop 1 > /dev/null 2>&1
  sleep 5
fi

$ENCRYPT $OPTIONS -d www.$DOMAIN -d $DOMAIN \
  --webroot-path /srv/httpd/vhosts/$DIRNAM-secure/htdocs

$ENCRYPT $OPTIONS -d mail.$DOMAIN \
  --webroot-path /srv/httpd/vhosts/$DIRNAM-webmail/htdocs

$ENCRYPT $OPTIONS -d cloud.$DOMAIN \
  --webroot-path /srv/httpd/vhosts/$DIRNAM-owncloud/htdocs

# Fix permissions
echo ":: Setting permissions."
$CHGRP -R $CERTGRP /etc/letsencrypt
$CHMOD -R g=rx /etc/letsencrypt

# Start Apache
echo ":: Starting Apache."
/etc/rc.d/rc.httpd start

