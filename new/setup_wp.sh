#!/bin/bash

clear
read -p "Please enter site name (like google.com): " SITE
VHOST_DIR="/var/vhost/"

echo
echo "Getting params from wp-config.php"
WPDBNAME=`cat ${VHOST_DIR}${SITE}/www/wp-config.php | grep DB_NAME | cut -d \' -f 4`;
WPDBUSER=`cat ${VHOST_DIR}${SITE}/www/wp-config.php | grep DB_USER | cut -d \' -f 4`;
WPDBPASS=`cat ${VHOST_DIR}${SITE}/www/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`;

echo "Create database '$WPDBNAME' (need mysql root password)"
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS $WPDBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

echo "Create user '$WPDBUSER' with privileges (need mysql root password)"
mysql -u root -p -e "CREATE USER '$WPDBUSER'@'localhost' IDENTIFIED BY '$WPDBPASS'; GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER,LOCK TABLES ON $WPDBNAME.* TO '$WPDBUSER'@'localhost';"

echo "Import data to database from dump"
mysql -u ${WPDBUSER} -p${WPDBPASS} ${WPDBNAME} < ${VHOST_DIR}${SITE}/www/dump.sql
rm -rf ${VHOST_DIR}${SITE}/www/dump.sql

echo "Chmod dirs in '$VHOST_DIR$SITE/www'"
chown -R www-data:www-data ${VHOST_DIR}${SITE}/www/*
chmod -R 755 ${VHOST_DIR}${SITE}/www
chmod -R 777 ${VHOST_DIR}${SITE}/www/wp-content/uploads

echo
echo "Done)"
