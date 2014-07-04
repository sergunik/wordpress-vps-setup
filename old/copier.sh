#!/bin/bash

REMOTE_HOST="81.4.106.121"
SITE="studioz.lviv.ua"
MYSQL_DB="web_studioz"

clear
echo
echo "Create MySQL dump"
mysqldump -u root -p ${MYSQL_DB} > /var/vhost/${SITE}/www/dump.sql

echo "Copy files to ${REMOTE_HOST}"
scp -r /var/vhost/${SITE}/www/* root@${REMOTE_HOST}:/var/vhost/${SITE}/www/
