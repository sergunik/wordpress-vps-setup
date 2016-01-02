wordpress-vps-setup
===================

Bash scripts for setup VPS for sites on WordPress.

#How to run?
```
sh setup_vps.sh
```

## Setup
- *setup_vps* - Install mc, nano, nginx, mysql and start them
- *setup_vhost* - Create virtual host (from prototype.host) and create directories in _/var/vhost_
- *setup_mysql* - Create new database and user  
- *setup_wordpress* - Download and unpack latest version of WordPress

##BackUp
- *backup_wordpress* - BackUp database and files _(Script could be used via Cron or manually)_

##Upgrade
- *upgrade_wordpress* - Download and replace files of new WordPress _(Could be used after some time you for upgrade WordPress to more newest)_


