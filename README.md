wordpress-vps-setup
===================

Bash scripts for setup VPS for sites on WordPress.

#How to run?
```
sh setup_vps.sh
```

## Setup
1. *setup_vps* - Install mc, nano, nginx, mysql and start them
2. *setup_vhost* - Create virtual host (from prototype.host) and create directories in _/var/vhost_
3. *setup_mysql* - Create new database and user  
4. *setup_wordpress* - Download and unpack latest version of WordPress

##BackUp
5. *backup_wordpress* - BackUp database and files of WordPress site
_Script could be used via Cron or manually_

##Upgrade
6. *upgrade_wordpress* - Download and replace files of new WordPress
_After some time you can upgrade WordPress to more newest_


