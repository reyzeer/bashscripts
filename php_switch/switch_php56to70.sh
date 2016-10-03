#!/bin/bash

a2dismod php5.6
a2enmod php7.0
service apache2 restart
