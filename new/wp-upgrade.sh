#!/bin/bash

clear

read -p "Please enter site name (like google.com): " SITE
VHOST_DIR="/var/vhost/"
wp_root=${VHOST_DIR}${SITE}/www

echo
echo "Getting latest version of WordPress"
read -p "Do you wish to get WordPress from https://wordpress.org/latest.tar.gz? " yn
case ${yn} in
    [Yy]* )
        WP_URL="https://wordpress.org/latest.tar.gz"
        ;;
    [Nn]* )
        read -p "Please enter url to your latest WordPress: " WP_URL
        ;;
    * )
        echo "Please answer yes or no."
        exit
        ;;
esac

curl ${WP_URL} > latest.tar.gz && tar -xmzf latest.tar.gz

echo "Getting params from wp-config.php"
WPDBNAME=`cat ${wp_root}/wp-config.php | grep DB_NAME | cut -d \' -f 4`;
WPDBUSER=`cat ${wp_root}/wp-config.php | grep DB_USER | cut -d \' -f 4`;
WPDBPASS=`cat ${wp_root}/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`;

#Backup the database for the site.
echo "Making backup at /var/wp_upgrade/${SITE}/"
mkdir -p /var/wp_upgrade/${SITE}
mysqldump -u ${WPDBUSER} -p${WPDBPASS} ${WPDBNAME} > /var/wp_upgrade/${SITE}/dump.sql &&
tar -czf /var/wp_upgrade/${SITE}/wp.tar.gz ${wp_root}

echo "Enable maintenance mode"
echo '<?php $upgrading = time(); ?>' > ${wp_root}/.maintenance

echo "Copying files over"
rm -r ${wp_root}/wp-includes
rm -r ${wp_root}/wp-admin
cp -a ./wordpress/* ${wp_root}/

echo "Chmod dirs in '${wp_root}'"
chown -R www-data:www-data ${wp_root}/*
chmod -R 755 ${wp_root}
chmod -R 777 ${wp_root}/wp-content/uploads

echo "Disable maintenance mode"
rm -r ${wp_root}/.maintenance

echo "Please go to ${SITE}/wp-admin"

echo
echo "Done)"