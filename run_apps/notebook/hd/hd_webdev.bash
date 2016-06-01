#!/bin/bash

MONITOR0=0
MONITOR1=1720
MONITOR2=3400

function setWindow
{
	sleep $1;
	wmctrl -r :ACTIVE: -e 0,$2,-1,-1,-1;
	sleep 1;
	wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz;
	sleep 1;
}

## workspace 0 ##
wmctrl -s 0;

#hipchat
hipchat4 &
setWindow 5 $MONITOR0

#thunderbird
thunderbird &
setWindow 5 $MONITOR1

#chromium-browser
chromium-browser &
sleep 1;

## workspace 1 ##
wmctrl -s 1;

#veracrypt
veracrypt &
sleep 1;

#nautilus
nautilus &
sleep 1;

#mysql-workbench
mysql-workbench &
setWindow 5 $MONITOR1

#konsole
konsole &
setWindow 1 $MONITOR2

## workspace 2 ##
wmctrl -s 2;

#netbeans
/home/reyzeer/netbeans-8.1/bin/netbeans --jdkhome /usr/lib/jvm/java-8-oracle/ &

#chromium-browser
chromium-browser;

