#!/bin/bash

a2dismod php7.1
a2enmod php5.6
service apache2 restart
