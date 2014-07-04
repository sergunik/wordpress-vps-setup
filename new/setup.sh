#!/bin/bash

clear
echo "Set up VPS"
echo

echo "Update repos"
apt-get update

echo "Instal MC"
apt-get install mc

echo "Install MYSQL"
apt-get install mysql-server mysql-client

echo "Install nginx"
apt-get install nginx

echo "Start nginx"
/etc/init.d/nginx start

echo "Install php5-fpm"
apt-get install php5-fpm
apt-get install php5-mysql php5-curl php5-gd php5-mcrypt php5-xmlrpc php5-cli

echo
echo "Please configure NGINX (/etc/nginx/nginx.conf)"
echo

# echo "Add group"
# addgroup wordpress

# echo "Install FTP"
# apt-get install vsftpd
