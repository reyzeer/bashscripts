#!/bin/bash

apt-get install apache2
#Apache2 Rewrite Mod
a2enmod rewrite

apt-get install mysql-server
apt-get install mysql-workbench
apt-get install php
apt-get install php-curl
apt-get install php-intl
apt-get install php-dom
apt-get install php-xdebug
apt-get install libapache2-mod-auth-mysql
apt-get install php-mysql
apt-get install libapache2-mod-php
apt-get install php-mcrypt
apt-get install php-mbstring

#node/npm
apt-get install nodejs-legacy
apt-get install npm
npm install apidoc -g

#npm
#apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-#openssl-dev libexpat-dev libncurses-dev zlib1g-dev

#apt install linuxbrew-wrapper

#brew install node

#export PATH="$HOME/.linuxbrew/bin:$PATH"
#export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
#export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
