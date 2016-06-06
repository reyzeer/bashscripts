#!/bin/bash

CMD_USR="sudo -u ${USER}"
CMD_ROOT="sudo"

# --------------------- #
#         Settings	    #
# --------------------- #

# --------------------- #
#	        Funcs		      #
# --------------------- #

# --- frameworks ---

yii2()
{

	

	$CMD_USR php init
	$CMD_USR composer update
}

onlyComposer()
{
	$CMD_USR composer update
}

# $1 - string|integer - check framework ( 1 - Yii2.0 | 2 - Only Composer )
# $2 - string - dir with project
doInitFramework()
{

	cd $2

	case "$1" in
		"yii2_advanced") #Yii2.0
			yii2
		;;
		"only_composer")
			onlyComposer
		;;
	esac

}

# --------------------- #
#	        main          #
# --------------------- #

attrs()
{
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in
      "-h"|"--help")
				cat framework.md
				exit
			;;
      -U|--user)
        user="$2"
        shift # past argument
      ;;
			-f|--framework)
      	framework="$2"
      	shift # past argument=value
      ;;
      -m|--modules)
        modules="$2"
        shift # past argument=value
      ;;
      -d|--dir)
      	dir="$2"
      	shift # past argument=value
      ;;
      *)
        # unknown option
      ;;
    esac
    shift # past argument or value
  done
}

run()
{

  doInitFramework $framework $dir

  #return
	 #null

}

attrs $@
run
