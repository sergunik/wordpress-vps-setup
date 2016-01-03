#!/bin/bash

clear
read -p "Please enter site name (like google.com): " SITE
VHOST_DIR="/var/vhost/"
WWW_DIR=${VHOST_DIR}${SITE}/www

echo
echo "+ Getting latest version of WordPress"
read -p "Do you wish to get WordPress from https://wordpress.org/latest.tar.gz [y/n]? " yn
case ${yn} in
    [Yy]* )
        WP_URL="https://wordpress.org/latest.tar.gz"
        ;;
    [Nn]* )
        read -p "Please enter url to your latest WordPress: " WP_URL
        ;;
    * )
        echo "Just y or n. Exit"
        exit
        ;;
esac

curl ${WP_URL} > latest.tar.gz && tar -xmzf latest.tar.gz
rm -rf latest.tar.gz

echo "+ Getting params from wp-config.php"
WPDBNAME=`cat ${WWW_DIR}/wp-config.php | grep DB_NAME | cut -d \' -f 4`;
WPDBUSER=`cat ${WWW_DIR}/wp-config.php | grep DB_USER | cut -d \' -f 4`;
WPDBPASS=`cat ${WWW_DIR}/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`;

#Backup the database for the site.
echo "+ Making backup at /var/wp_upgrade/${SITE}/"
mkdir -p /var/wp_upgrade/${SITE}
mysqldump -u ${WPDBUSER} -p${WPDBPASS} ${WPDBNAME} > /var/wp_upgrade/${SITE}/dump.sql &&
tar -czf /var/wp_upgrade/${SITE}/wp.tar.gz ${WWW_DIR}

echo "+ Enable maintenance mode"
echo '<?php $upgrading = time(); ?>' > ${WWW_DIR}/.maintenance

echo "+ Copying files over"
rm -r ${WWW_DIR}/wp-includes
rm -r ${WWW_DIR}/wp-admin
cp -a ./wordpress/* ${WWW_DIR}/

echo "+ Chmod dirs in '${WWW_DIR}'"
chown -R www-data:www-data ${WWW_DIR}/*
chmod -R 755 ${WWW_DIR}
chmod -R 777 ${WWW_DIR}/wp-content/uploads

echo "+ Disable maintenance mode"
rm -r ${WWW_DIR}/.maintenance

echo "Done!"
echo "Please go to ${SITE}/wp-admin"