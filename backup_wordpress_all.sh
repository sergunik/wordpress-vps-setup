#!/bin/bash

VERBOSE=0
BACKUP_DIR=/tmp/dump
MYSQL_CFG="./mysql.cfg"

show_help() {
cat << EOF
Usage: ${0##*/} [-hv] [-p PATH] [-m mysql.cfg]

    -h          display this help and exit
    -p PATH     path to backup directory (default: ${BACKUP_DIR})
    -v          verbose mode (default: ${VERBOSE})
    -m PATH     path to mysql.cfg file (default: ${MYSQL_CFG})

EOF
}

log() {
    if [ ${VERBOSE} -eq 1 ]
        then
            echo "$@"
    fi
}

OPTIND=1 # Reset is necessary if getopts was used previously in the script
while getopts "hvp:" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        v)  VERBOSE=1
            ;;
        p)  BACKUP_DIR=$OPTARG
            ;;
        m)  MYSQL_CFG=$OPTARG
            ;;
    esac
done


log "BackUp started"
log ""

mkdir -p ${BACKUP_DIR}

for SITE_PATH in /var/vhost/*
do
	SITE=$(basename $SITE_PATH)
	log ${SITE}

	DATE=`date "+%Y-%m-%d_%H:%M"`
	MYSQL_FILE="${BACKUP_DIR}/${SITE}_${DATE}.sql.gz"
	SITE_FILE="${BACKUP_DIR}/${SITE}_${DATE}.tar.gz"

	WPDBNAME=`cat ${SITE_PATH}/www/wp-config.php | grep DB_NAME | cut -d \' -f 4`;

	mysqldump --defaults-extra-file=${MYSQL_CFG} ${WPDBNAME} | gzip -c > ${MYSQL_FILE}
	log "+ MySQL dump created"

	tar -cvf dump.tar ${SITE_PATH}/www/ > /dev/null 2>&1
	gzip -c dump.tar > ${SITE_FILE}
	rm dump.tar
	log "+ Site dump created"

	log "${SITE} - Done"
	log ""
done

log "All backUps done!"