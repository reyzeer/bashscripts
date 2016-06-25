#!/bin/bash

add-apt-repository ppa:ondrej/php
apt-get update

apt-get install php5.6

#sudo a2dismod php5.6
#sudo a2enmod php7.0
#sudo service apache2 restart

apt-get install php5.6-xml
apt-get install php5.6-simplexml
apt-get install php5.6-mysql
apt-get install php5.6-mysqli
apt-get install php5.6-mbstring
apt-get install php5.6-gd
apt-get install php5.6-curl
apt-get install php5.6-xdebug

apt-get install imagemagick
apt-get install php5.6-imagick

service apache2 restart
