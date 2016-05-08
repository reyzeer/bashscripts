#!/bin/bash

WWW_PATH=~/WWW/
APACHE2_SITES_PATH=/etc/apache2/sites-available/
USER=reyzeer

cd $WWW_PATH

echo "Get git repository address:"
read gitaddress

dirName=`expr "$gitaddress" : '^https:\/\/github\.com\/.[a-z0-9]*\/\(.[a-z0-9]*\)\.git$'`

sudo -u $USER git clone $gitaddress

echo "Get names of modules (separate by ;):"
read modules

modules="frontend;backend"

modules=$(echo $modules | tr ";" "\n")
for module in $modules
do

	echo "127.0.0.1	 ${dirName}-${module}.loc" >> /etc/hosts
	read -r -d '' vhosts << EOM

<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        ServerName www.${dirName}-${module}.loc
        ServerAlias ${dirName}-${module}.loc

        ServerAdmin webmaster@localhost
        DocumentRoot /home/reyzeer/WWW/${dirName}/${module}/web

        <Directory "/home/reyzeer/WWW/${dirName}/${module}/web">
                Options Indexes FollowSymLinks Includes ExecCGI
                AllowOverride All
                Require all granted
                Allow from all
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/${dirName}-${module}-error.log
        CustomLog ${APACHE_LOG_DIR}/${dirName}-${module}-access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

EOM
	echo "${vhosts}" >> ${APACHE2_SITES_PATH}${dirName}-${module}.conf
	a2ensite ${dirName}-${module}

	sudo -u $USER mkdir ${WWW_PATH}${dirName}/${module}/runtime
	sudo -u $USER mkdir ${WWW_PATH}${dirName}/${module}/web/assets

done

sudo -u $USER mkdir ${WWW_PATH}${dirName}/common/runtime

chgrp -R www-data ${WWW_PATH}${dirName}
chmod -R g+rwx ${WWW_PATH}${dirName}

cd ${WWW_PATH}${dirName}

sudo -u $USER php init
sudo -u $USER composer update

service apache2 restart


