#!/bin/bash

a2dismod php5.6
a2enmod php7.1
service apache2 restart
