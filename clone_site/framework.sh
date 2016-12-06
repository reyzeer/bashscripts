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

# $1 - string - dir with project
# $2 - string - modules "backend;frontend"
yii2()
{

	modules=$(echo $2 | tr ";" "\n")
	for module in $modules
	do

		$CMD_USR mkdir ${1}/${module}/runtime
		$CMD_USR mkdir ${1}/${module}/web/assets

	done

	$CMD_USR mkdir ${1}/common/runtime

	$CMD_USR php init
	$CMD_USR composer update
}

onlyComposer()
{
	$CMD_USR composer update
}

# $1 - string - dir with project
# $2 - string|integer - check framework ( 1 - Yii2.0 | 2 - Only Composer )
# $3 - string - modules "backend;frontend"
doInitFramework()
{

	cd $1

	case "$2" in
		"yii2_advanced") #Yii2.0
			yii2 $1 $3
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

  doInitFramework $dir $framework $modules

  #return
	 #null

}

attrs $@
run
