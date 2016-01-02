#!/bin/bash

clear
read -p "Please enter site name (like google.com): " SITE
VHOST_DIR="/var/vhost/"
WWW_DIR=${VHOST_DIR}${SITE}/www

echo "+ Getting latest version of WordPress"
read -p "Do you wish to get WordPress from https://wordpress.org/latest.tar.gz [y/n]? " yn
case ${yn} in
    [Yy]* )
        WP_URL="https://wordpress.org/latest.tar.gz"
        ;;
    [Nn]* )
        read -p "Please enter url to your latest WordPress in tar.gz archive: " WP_URL
        ;;
    * )
        echo "Just y or n. Exit"
        exit
        ;;
esac

curl ${WP_URL} > latest.tar.gz && tar -xmzf latest.tar.gz
rm -rf latest.tar.gz

echo "+ Copying files over"
cp -a ./wordpress/* ${WWW_DIR}/

echo "+ Chmod dirs in '${wp_root}'"
chown -R www-data:www-data ${WWW_DIR}/*
chmod -R 755 ${WWW_DIR}
chmod -R 777 ${WWW_DIR}/wp-content/uploads

echo "Done!"
echo "Please go to ${SITE}/wp-admin"