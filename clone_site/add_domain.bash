#!/bin/bash

CMD_USR="sudo -u ${USER}"
CMD_ROOT="sudo"

# --------------------- #
#         Settings	    #
# --------------------- #

APACHE2_SITES_PATH=/etc/apache2/sites-available
APACHE_LOG_DIR=~/WWW/logs

# --------------------- #
#	        Funcs		      #
# --------------------- #

# --- ch* ---

# $1 - string path
function ch_addWww
{

	$CMD_ROOT chgrp -R www-data $1
	$CMD_ROOT chmod g+rwx $1
}

# --- Add domain hosts&apache2 ---

# $1 - string - rootDir in dir
# $2 - string - dir with project
function path
{
	echo ${2}/${1}
}

# $1 - string - domain
function add2hosts
{
	$CMD_ROOT echo "127.0.0.1		${1}" >> /etc/hosts
	$CMD_ROOT echo "127.0.0.1		www.${1}" >> /etc/hosts

}

# $1 - string - domain
# $2 - string - path to root
function add2apache
{

	read -r -d '' vhosts << EOM

<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        ServerName www.${1}
        ServerAlias ${1}

        DocumentRoot ${2}

        <Directory "${2}">
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

        ErrorLog ${APACHE_LOG_DIR}/${1}-error.log
        CustomLog ${APACHE_LOG_DIR}/${1}-access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

EOM

	$CMD_ROOT echo "${vhosts}" >> ${APACHE2_SITES_PATH}/${1}.conf
	$CMD_ROOT a2ensite ${1}

}

# $1 - string - dir with project
# $2 - string - domains
function doAddDomain
{

	domains=$(echo $2 | tr ";" "\n")
	for domain in $domains
	do

		domain=(${domain/,/ })
		subDir=${domain[1]}
		domain=${domain[0]}

		add2hosts $domain
		add2apache $domain ${dir}${subDir}

		$CMD_ROOT service apache2 restart
		open "http://${domain}/"

	done

}

# --------------------- #
#	        main          #
# --------------------- #

attrs()
{
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in
      "-h"|"--help")
				cat add_domain.md
				exit
			;;
      -U|--user)
        user="$2"
        shift # past argument
      ;;
			-di|--dir)
      	dir="$2"
      	shift # past argument=value
      ;;
			-do|--domains)
				domains="$2"
				shift # past argument
			;;
      *)
        # unknown option
      ;;
    esac
    shift # past argument or value
  done
}

run()
{

	ch_addWww $dir
  doAddDomain $dir $domains

  #return
	 #null

}

attrs $@
run
