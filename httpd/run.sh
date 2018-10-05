#!/bin/bash

#### move drupal files to apache htdocs directory ####
if [ -d "/var/www/html/sites" ]; then
	echo "Skipping drupal install"
else 

	cp -R /tmp/drupal-7.52/* /var/www/html
	#### remove drupal dl and change sites permissions ####
	rm -rf /tmp/drupal-7.52
        rm -rf /tmp/.htaccess

	#git clone https://github.com/CBIIT/drupal /var/www/html
        cd /var/www/html
        #git checkout nci-multisite
        cp /tmp/.htaccess /var/www/html

	echo "installing database"
	chown -R apache:apache /var/www/html/sites 
	chmod 755 -R /var/www/html/sites
	#drush site-install -y standard --account-name=admin --account-pass=admin --db-url=mysql://mysql:DBAdmin1@$IPADDRESS/$DB
fi
#### execute supervisor to start apache ####
exec supervisord

