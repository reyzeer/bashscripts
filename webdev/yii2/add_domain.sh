#!/bin/bash

# example:
# sudo bash add_domain.sh -D my_domain.domain -P /var/www/my_domain/

#cons
APACHE_LOG_DIR="/home/reyzeer/www/logs/"

# get attributes

attrs()
{
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in
        -D|--domain)
          domain="$2"
          shift # past argument
        ;;
        -P|--path)
          path="$2"
          shift # past argument
        ;;
        *)
          # unknown option
        ;;
    esac
    shift # past argument or value
  done
}

attrs $@

printf "
  Domains:\t\t$domain
  Path:\t\t\t$path
\n"

echo "All is ok?[y/n]"
read isOk

if [ "$isOk" != "y" ]
then
  exit
fi

#add to hosts

echo "127.0.0.1	 ${domain}" >> /etc/hosts
echo "127.0.0.1	 www.${domain}" >> /etc/hosts

#add to apache2

read -r -d '' siteconf << EOM

<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        ServerName www.${domain}
        ServerAlias ${domain}

        ServerAdmin webmaster@localhost
        DocumentRoot "${path}"

        <Directory "${path}">
                Options Indexes FollowSymLinks Includes ExecCGI
                AllowOverride All
                Require all granted
                Allow from all

		RewriteEngine on
		# If a directory or a file exists, use it directly
		RewriteCond %{REQUEST_FILENAME} !-f
		RewriteCond %{REQUEST_FILENAME} !-d
		# Otherwise forward it to index.php
		RewriteRule . index.php
        </Directory>

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/${domain}-error.log
        CustomLog ${APACHE_LOG_DIR}/${doamin}-access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

EOM

echo "${siteconf}" >> /etc/apache2/sites-available/${domain}.conf
a2ensite ${domain}

service apache2 restart

