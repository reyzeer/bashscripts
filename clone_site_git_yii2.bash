#!/bin/bash

#https://github.com/zbigniewczarnecki/menedzerpostepowtreningowych.git

WWW_PATH=~/WWW/

cd $WWW_PATH

echo "Get git repository address:"
#read gitaddress

gitaddress=https://github.com/zbigniewczarnecki/menedzerpostepowtreningowych.git

DIR_NAME=`expr "$gitaddress" : '^https:\/\/github\.com\/.[a-z0-9]*\/\(.[a-z0-9]*\)\.git$'`

echo ${PROJECT_DIR[0]}
echo ${PROJECT_DIR[1]}

#awk -v var=$gitaddress 'BEGIN{print var}'

#awk -v var=$gitaddress 'BEGIN{/https\:\/\/github.com\/\(.[a-z]*\)\/\(.[a-z]*\)\.git/}END{print $1}'

#awk -v var=$gitaddress 'BEGIN /https\:\/\/github.com\/\(.[a-z]*\)\/\(.[a-z]*\)\.git/{
#print $1
#print $2
#}'

#PROJECT_DIR=`expr "$gitaddress" : '^\(.[a-z]*\)'`
#echo ${PROJECT_DIR[1]}

#echo $1
#echo $2

#PROJECT_DIR=$(echo $gitaddress | tr "/" "\n")
#echo ${PROJECT_DIR[0]}
#echo ${PROJECT_DIR[1]}
#echo ${PROJECT_DIR[2]}

exit

git clone $gitaddress

echo "Get names of modules (separate by ;):"
read modules

modules=$(echo $modules | tr ";" "\n")
for module in $modules
do
	
done

