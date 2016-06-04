#!/bin/bash



# --------------------- #
#         Settings	    #
# --------------------- #

WWW_PATH=~/WWW
APACHE2_SITES_PATH=/etc/apache2/sites-available
APACHE_LOG_DIR=~/WWW/logs
USER=reyzeer

CMD_USR="sudo -u ${USER}"
CMD_ROOT="sudo"

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
#	        main          #
# --------------------- #

attrs()
{
  while [[ $# > 1 ]]
  do
    key="$1"
    case $key in
        -rt|--repositoryType)
          repositoryType="$2"
          shift # past argument
        ;;
        -ru|--repositoryUrl)
          repositoryUrl="$2"
          shift # past argument
        ;;
        -ut|--urlType)
          urlType="$2"
          shift # past argument
        ;;
        *)
          # unknown option
        ;;
    esac
    shift # past argument or value
  done
}

main()
{

  #bash repository.bash -U $USER -w $WWW_PATH -t $repositoryType -u $repositoryUrl

  dirName=$(bash path.bash -t $urlType -u $repositoryUrl)
  dir=${WWW_PATH}/${dirName}

  bash framework.bash -U $USER -

  echo $dir

  # echo "Choose repository type (git - [1] / svn - [2]):"
  # read repoTypeSelect
  #
  # echo "Get repository address:"
  # read repoAddress
  #
  # echo "Choose repository link type (github - [1] / project.coop-svn - [2]):"
  # read repoLinkTypeSelect
  #
  # repository_clone $repoTypeSelect $repoAddress
  # dirName=$(path_getRepoDir $repoLinkTypeSelect $repoAddress)
  # dir=${WWW_PATH}/${dirName}
  #
  # ch_addWww $dir
  #
  # printf "Choose framework:\n1. Yii2.0\n2. Only Composer\n0. None\n"
  # read selectFramework
  #
  # framework_choose $selectFramework
  #
  # addDomain_do $dir
  #
  # echo "Finish."

}

attrs $@
main
