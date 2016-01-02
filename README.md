wordpress-vps-setup
===================

Bash scripts for setup VPS for sites on WordPress.

#How to run?
```
sh setup_vps.sh
```

## Setup
- **setup_vps.sh** - Install mc, nano, nginx, mysql and start them
- **setup_vhost.sh** - Create virtual host (from prototype.host) and create directories in _/var/vhost_
- **setup_mysql.sh** - Create new database and user  
- **setup_wordpress.sh** - Download and unpack latest version of WordPress

##BackUp
- **backup_wordpress.sh** - BackUp database and files (Script could be used via Cron or manually)
- **backup_wordpress_all.sh** - BackUp all sites in _/var/vhost/*_ (Script has extra parameters. Run `sh backup_wordpress_all.sh -h`)

##Upgrade
- **upgrade_wordpress.sh** - Download and replace files of new WordPress _(Could be used after some time you for upgrade WordPress to more newest)_

##Uninstall
- _in progress..._