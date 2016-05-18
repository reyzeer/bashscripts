#!/bin/bash

repoType=$1
repoAddress=$2

case "$repoType" in
"git")
	echo "Wybrano gita"
    ;;
"svn" | "3")
	echo "Wyrabno svn"
    ;;
*)
	echo "Nie wybrano nic"
	exit
    ;;
esac


#if [ $repoType='git' ]
#echo $repoType
#echo $repoAddress
