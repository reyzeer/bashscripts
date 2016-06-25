#!/bin/bash

apt-add-repository ppa:remmina-ppa-team/remmina-next
apt-get update
apt-get install remmina remmina-plugin-rdp libfreerdp-plugins-standard
