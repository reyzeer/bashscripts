#!/bin/bash

# --------------------- #
#	Settings	#
# --------------------- #

WWW_PATH=~/WWW
APACHE2_SITES_PATH=/etc/apache2/sites-available
APACHE_LOG_DIR=~/WWW/logs
USER=reyzeer

CMD_USR="sudo -u ${USER}"
CMD_ROOT="sudo"

# --------------------- #
#	Funcs		#
# --------------------- #

# --- repository ---

# $1 - string - svn checkout address
function repository_cloneGIT
{
	$CMD_USR git clone $1
}

# $1 - string - git clone address
function repository_cloneSVN
{
	$CMD_USR svn checkout $1
}

# $1 - integer - select repo type ( 1 - git | 2 - svn )
# $2 - string - git/svn clone/checkout address
function repository_select
{

	case "$1" in
		1) #git
			repository_cloneGIT $2
		;;
		2) #svn
			repository_cloneSVN $2
		;;
		*)
			echo "You choose wrong repo type!"
			exit
		;;
	esac

}

# $1 - integer - select repo type ( 1 - git | 2 - svn )
# $2 - string - git/svn clone/checkout address
function repository_clone
{
	cd $WWW_PATH
	repository_select $1 $2
}

# --- path ---

# $1 - string - github address
function path_getRepoDirGithub
{
	echo `expr "$1" : '^https:\/\/github\.com\/.[a-z0-9]*\/\(.[a-z0-9]*\)\.git$'`
}

# $1 - string - project.coop-svn address
function path_getRepoDirProjectcoopSVN
{
        echo `expr "$1" : '^https:\/\/svn\.project\.coop\/svn\/\(.[a-z0-9]*\)$'`
}

# $1 - integer - repository link type ( 1 - github | 2 - project.coop-svn )
# $2 - string - address
function path_getRepoDir
{

	case "$1" in
                1) #github
                	dirName=$(path_getRepoDirGithub $2) 
                ;;  
                2) #project.coop-svn
                	dirName=$(path_getRepoDirProjectcoopSVN $2)
                ;;  
        esac

	echo $dirName

}

# --- ch* ---

# $1 - string path
function ch_addWww
{
	$CMD_ROOT chgrp -R www-data $1
	$CMD_ROOT chmod g+rwx $1
}

# --- frameworks ---

function framework_yii2
{
	$CMD_USR php init
	$CMD_USR composer update
}

function framework_onlyComposer
{
	$CMD_USR composer update
}

# $1 - integer - check framework ( 1 - Yii2.0 | 2 - Only Composer )
# $2 - string - dir with project
function framework_choose
{

	cd $2

	case "$1" in
		1) #Yii2.0
			framework_yii2	
		;;
		2) #Only Composer
			framework_onlyComposer
		;;
	esac

}

# --- Add domain hosts&apache2 ---

# $1 - string - rootDir in dir
# $2 - string - dir with project
function addDomain_path
{
	echo ${2}/${1}
}

# $1 - string - domain
function addDomain_add2hosts
{
	$CMD_ROOT echo "127.0.0.1	 ${1}.loc" >> /etc/hosts
	$CMD_ROOT echo "127.0.0.1        www.${1}.loc" >> /etc/hosts

}

# $1 - string - domain
# $2 - string - path to root
function addDomain_add2apache
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
        ServerName www.${1}.loc
        ServerAlias ${1}.loc

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

	$CMD_ROOT echo "${vhosts}" >> ${APACHE2_SITES_PATH}${1}.conf
	$CMD_ROOT a2ensite ${1}

}

# $1 - string - dir with project
function addDomain_do
{

	isAll="n"
	while [ "$isAll" != "y" ]; do
		
		# get dir for once www root (yii may has some of roots f.e. frontend, backend)
		dirIsOk="n"
		while [ "$dirIsOk" != "y" ]; do

			echo "Get relative dir for ${1}/:"
			read rootDir

			rootDir=$(addDomain_path $rootDir $1)

			echo "Path $rootDir is ok?[y/n]"
			read dirIsOk
		done
	
                # domainMe 
                domainIsOk="n"
                while [ "$dirIsOk" != "y" ]; do

                        echo "Get domain name for ${rootDir}:"
                        read domain

                        echo "Path $domain is ok?[y/n]"
                        read domainIsOk
                done

		addDomain_add2hosts $domain
		addDomain_add2apache $domain $rootDir

		$CMD_ROOT service apache2 restart
		open "http://${domain}/"

		echo "Is all r ots?"
		read isAll

	done
	
}

# --------------------- #
#	main		#
# --------------------- #

echo "Choose repository type (git - [1] / svn - [2]):"
read repoTypeSelect

echo "Get repository address:"
read repoAddress

echo "Choose repository link type (github - [1] / project.coop-svn - [2]):"
read repoLinkTypeSelect

repository_clone $repoTypeSelect $repoAddress
dirName=$(path_getRepoDir $repoLinkTypeSelect $repoAddress)
dir=${WWW_PATH}/${dirName}

ch_addWww $dir

printf "Choose framework:\n1. Yii2.0\n2. Only Composer\n0. None\n"
read selectFramework

framework_choose $selectFramework

addDomain_do $dir

echo "Finish."

