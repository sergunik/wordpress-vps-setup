#!/bin/bash

clear
read -p "Please enter new database name: " WPDBNAME
read -p "Please enter new database user (no more 16 symbols): " WPDBUSER
read -p "Please enter new database user password: " WPDBPASS
read -p "Please enter root password to MySQL: " MYSQL_ROOT_PASS

read -p "Do you need to create database '${WPDBNAME}' [y/n]? " yn
case ${yn} in
    [Yy]* )
        QUERY="CREATE DATABASE IF NOT EXISTS ${WPDBNAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
        mysql -u root -p${MYSQL_ROOT_PASS} -e "${QUERY}"
        echo "+ Database created"
        ;;
esac

read -p "Do you need to create user '${WPDBUSER}' [y/n]? " yn
case ${yn} in
    [Yy]* )
        QUERY="CREATE USER '${WPDBUSER}'@'localhost' IDENTIFIED BY '${WPDBPASS}'; GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER,LOCK TABLES ON ${WPDBNAME}.* TO '${WPDBUSER}'@'localhost';"
        QUERY_2="FLUSH PRIVILEGES;"
        mysql -u root -p${MYSQL_ROOT_PASS} -e "${QUERY}${QUERY_2}"
        echo "+ User created"
        ;;
esac

read -p "Do you need to import data from file [y/n]? " yn
case ${yn} in
    [Yy]* )
        read -p "Please type path to sql-file: " MYSQL_DUMP
        mysql -u ${WPDBUSER} -p${WPDBPASS} ${WPDBNAME} < ${MYSQL_DUMP}
        echo "+ Data imported"
        ;;
esac

echo
echo "Done!"
