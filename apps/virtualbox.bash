#!/bin/bash

sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list" wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add - 
apt-get update 
apt-get install virtualbox
