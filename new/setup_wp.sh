#!/bin/bash

SITE="studioz.lviv.ua"
VHOST_DIR="/var/vhost/"

clear
echo
echo "Getting params from wp-config.php"
WPDBNAME=`cat $VHOST_DIR$SITE/www/wp-config.php | grep DB_NAME | cut -d \' -f 4`;
WPDBUSER=`cat $VHOST_DIR$SITE/www/wp-config.php | grep DB_USER | cut -d \' -f 4`;
WPDBPASS=`cat $VHOST_DIR$SITE/www/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`;

echo "Create database '$WPDBNAME'"
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS $WPDBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

echo "Create user '$WPDBUSER' with privileges"
mysql -u root -p -e "CREATE USER '$WPDBUSER'@'localhost' IDENTIFIED BY '$WPDBPASS'; GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,LOCK TABLES ON $WPDBNAME.* TO '$WPDBUSER'@'localhost';"

echo "Import data to database from dump"
mysql -u root -p $WPDBNAME < $VHOST_DIR$SITE/www/dump.sql
rm -rf $VHOST_DIR$SITE/www/dump.sql

echo "Chmod dirs"
chmod -r 755 $VHOST_DIR$SITE/www
chmod -r 777 $VHOST_DIR$SITE/www/wp-content/uploads

echo
echo "Done)"