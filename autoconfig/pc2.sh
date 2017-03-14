#!/bin/bash

 # Repos
add-apt-repository ppa:webupd8team/java #java
# --- spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
# --- hipchat
sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list'
wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | sudo apt-key add -
# --- playonlinux
wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
sudo wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list

# Repo update
apt update

# Upgrade distro
apt dist-upgrade -y

# Apps
apt install -y chromium-browser
apt install -y git
apt install -y subversion
apt install -y vim nano
apt install -y psensor lm-sensors

apt install -y steam
apt install -y playonlinux
apt install -y spotify-client
apt install -y thunderbird
apt install -y hipchat

apt install -y apache2
apt install -y mysql-server mysql-client mysql-workbench
apt install -y memcached php libapache2-mod-php php-cli php-mcrypt php-curl php-intl php-dom php-mysql php-mysqli php-mbstring php-xml php-simplexml php-gd php-xdebug php-memcached

apt install -y texlive-full
apt install -y texmaker

apt install -y oracle-java8-installer
apt install -y npm

# Deb packs

if ! type "atom" > /dev/null; then
  wget https://atom.io/download/deb
  dkpg -i atom-deb64.deb
  rm atom-deb64.deb
fi

if ! type "gitkraken" > /dev/null; then
  wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
  dpkg -i gitkraken-amd64.deb
  rm gitkraken-amd64.deb
fi

# First run JetBrains apps

if ! type "phpstorm" > /dev/null; then
  bash ~/bin/phpstorm/bin/phpstorm.sh
fi

if ! type "clion" > /dev/null; then
  bash ~/bin/clion/bin/clion.sh
fi

if ! type "webstorm" > /dev/null; then
  bash ~/bin/webstorm/bin/webstorm.sh
fi

if ! type "ideaiu" > /dev/null; then
  bash ~/bin/ideaiu/idea.sh
fi

# Composer
if [ ! -e ~/bin/composer ]
then
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php
  php -r "unlink('composer-setup.php');"
  mv composer.phar ~/bin/composer
  chmod 755 composer
else
  composer self-update
fi
