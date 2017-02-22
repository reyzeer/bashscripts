#!/bin/bash

add-apt-repository ppa:ondrej/php
apt-get update

apt-get install -y php5.6 php5.6-xml php5.6-simplexml php5.6-mysql php5.6-mysqli php5.6-mbstring php5.6-gd php5.6-curl php5.6-xdebug
