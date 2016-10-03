#!/bin/bash

# repos

# - kernel/terminal

# -- java
add-apt-repository ppa:webupd8team/java

# - gui/shell

# -- nautilus
add-apt-repository ppa:rabbitvcs/ppa
add-apt-repository ppa:costales/folder-color

# -- programs

# --- spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# --- hipchat
sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list'
wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | sudo apt-key add -

# --- update ---
apt-get update

# install

# -- drivers

apt-get install nvidia-current
apt-get install nvidia-settings

# - kernel/terminal

apt-get install vim
apt-get install git
apt-get install subversion

# -- java
apt-get install oracle-java8-installer

# - gui/shell

# -- nautilus
apt-get install nautilus
apt-get install folder-color
apt-get install rabbitvcs-nautilus rabbitvcs-gedit rabbitvcs-cli

# - enviroment

# -- php

# --- apache2
apt-get install apache2
a2enmod rewrite

# --- mysql
apt-get install mysql-server
apt-get install mysql-workbench

# --- php-engine
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
npm install -g angular-cli

# --- composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# -- programs

apt-get install audacity
apt-get install psensor
apt-get install hipchat4
apt-get install spotify-client
apt-get install steam
apt-get install veracrypt
apt-get install geary
apt-get install chromium-browser

# --- gitkraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
dpkg -i gitkraken-amd64.deb 

# --- latex
install texlive-full
install texmaker

# --- netbeans
wget http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-linux.sh
bash netbeans-8.1-linux.sh

