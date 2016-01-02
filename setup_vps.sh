#!/bin/bash

clear
echo "+ Update repositories"
apt-get update

echo "+ Instal MC"
apt-get install mc

echo "+ Instal nano editor"
apt-get install nano

echo "+ Install MySQL"
apt-get install mysql-server mysql-client

echo "+ Install nginx"
apt-get install nginx

echo "+ Install php5-fpm"
apt-get install php5-fpm
apt-get install php5-mysql php5-curl php5-gd php5-mcrypt php5-xmlrpc php5-cli

echo "+ Start nginx"
/etc/init.d/nginx start

echo "+ Start MySQL"
/etc/init.d/mysql start

echo "Done!"
echo "Please configure NGINX (nano /etc/nginx/nginx.conf)"