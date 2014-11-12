#!/bin/bash

clear
read -p "Please enter remote host (like 81.4.106.121): " REMOTE_HOST
read -p "Please enter site name (like google.com): " SITE
VHOST_DIR="/var/vhost/"

echo
echo "Getting params from wp-config.php"
WPDBNAME=`cat ${VHOST_DIR}${SITE}/www/wp-config.php | grep DB_NAME | cut -d \' -f 4`;
WPDBUSER=`cat ${VHOST_DIR}${SITE}/www/wp-config.php | grep DB_USER | cut -d \' -f 4`;
WPDBPASS=`cat ${VHOST_DIR}${SITE}/www/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`;

echo "Create MySQL dump"
mysqldump -u ${WPDBUSER} -p${WPDBPASS} ${WPDBNAME} > ${VHOST_DIR}${SITE}/www/dump.sql

echo "Copy files to ${REMOTE_HOST}"
scp -r ${VHOST_DIR}${SITE}/www/* root@${REMOTE_HOST}:${VHOST_DIR}${SITE}/www/

rm -r ${VHOST_DIR}${SITE}/www/dump.sql

echo
echo "Done)"