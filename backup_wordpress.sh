#!/bin/bash

clear
read -p "Please enter site name (like google.com): " SITE
VHOST_DIR="/var/vhost/"
WWW_DIR=${VHOST_DIR}${SITE}/www
TMP_DIR=${VHOST_DIR}${SITE}/tmp

echo "+ Creating temporary directory for dumps (${TMP_DIR})"
mkdir ${TMP_DIR}

echo "+ Getting params from wp-config.php"
WPDBNAME=`cat ${WWW_DIR}/wp-config.php | grep DB_NAME | cut -d \' -f 4`;
WPDBUSER=`cat ${WWW_DIR}/wp-config.php | grep DB_USER | cut -d \' -f 4`;
WPDBPASS=`cat ${WWW_DIR}/wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`;

echo "+ Backing up database ${WPDBNAME}"
mysqldump -u ${WPDBUSER} -p${WPDBPASS} ${WPDBNAME} > ${TMP_DIR}/dump.sql

echo "+ Backing up files (${WWW_DIR})"
tar -czf ${TMP_DIR}/${SITE}.tar.gz ${WWW_DIR}

echo
echo "Done!"
