#!/bin/bash

# repos

# - kernel/terminal

# -- java
add-apt-repository ppa:webupd8team/java

# - gui/shell

# -- nautilus
#add-apt-repository ppa:rabbitvcs/ppa
#add-apt-repository ppa:costales/folder-color

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

#apt-get install nvidia-current
#apt-get install nvidia-settings

# - kernel/terminal

apt-get install -y vim
apt-get install -y git
apt-get install -y subversion

# -- java
apt-get install -y oracle-java8-installer

# - gui/shell

# -- nautilus
#apt-get install nautilus
#apt-get install folder-color
#apt-get install rabbitvcs-nautilus rabbitvcs-gedit rabbitvcs-cli

# - enviroment

# -- php

# --- apache2
apt-get install -y apache2
a2enmod rewrite

# --- mysql
apt-get install -y mysql-server
apt-get install -y mysql-workbench

# --- php-engine
apt-get install -y php php-curl php-intl php-dom php-xdebug libapache2-mod-auth-mysql php-mysql libapache2-mod-php php-mcrypt php-mbstring

#node/npm
#apt-get install nodejs-legacy
#apt-get install npm
#npm install apidoc -g
#npm install -g angular-cli

# --- composer
#php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#php -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer #corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#php composer-setup.php
#php -r "unlink('composer-setup.php');"
#mv composer.phar /usr/local/bin/composer

# -- programs

#apt-get install audacity
apt-get install -y psensor
apt-get install -y hipchat4
apt-get install -y spotify-client
#apt-get install steam
#apt-get install veracrypt
#apt-get install geary
apt-get install -y chromium-browser

# --- gitkraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
dpkg -i gitkraken-amd64.deb 

# --- latex
#install texlive-full
#install texmaker

# --- netbeans
#wget http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-linux.sh
#bash netbeans-8.1-linux.sh

