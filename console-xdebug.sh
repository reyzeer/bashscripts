#!/bin/bash

serverName=$1
idekey=$2

if [ -z "$serverName"] || [ "$serverName" == " " ]; then 
    serverName='localhost'
fi

if [ -z "$idekey" ]; then 
    idekey='PHPSTORM'
fi

export PHP_IDE_CONFIG=serverName=serverName ; export XDEBUG_CONFIG=idekey=$idekey
echo "Set for domian $serverName with idekey $idekey."
