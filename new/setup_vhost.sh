#!/bin/bash

clear
read -p "Please enter site name (like google.com): " SITE
VHOST_DIR="/var/vhost/"
NGINX_DIR="/etc/nginx/"

echo
echo "Set up vhost"
echo

echo "Create vhost file"
VHOST_FILE=${SITE}
sed "s/%SITE%/$SITE/g" prototype.host > ${NGINX_DIR}sites-available/${VHOST_FILE}

echo "Create symlink for vhost file"
ln -s ${NGINX_DIR}sites-available/${VHOST_FILE} ${NGINX_DIR}sites-enabled/${VHOST_FILE}

echo "Create dirs in '$VHOST_DIR$SITE'"
mkdir ${VHOST_DIR}${SITE}
mkdir ${VHOST_DIR}${SITE}/www
mkdir ${VHOST_DIR}${SITE}/log
mkdir ${VHOST_DIR}${SITE}/tmp

echo "Chmod dirs"
chmod 755 ${VHOST_DIR}${SITE}/www
chmod 777 ${VHOST_DIR}${SITE}/log
chmod 777 ${VHOST_DIR}${SITE}/tmp

echo "Generate htpasswd"
read -p "Please enter username for basic auth (like adminko): " BASIC_USER
htpasswd -c ${VHOST_DIR}${SITE}/www/.htpasswd ${BASIC_USER}

echo "Restart and apply php-server"
/etc/init.d/nginx restart

echo
echo "Done)"