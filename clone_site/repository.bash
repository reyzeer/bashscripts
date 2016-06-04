#!/bin/bash

# --------------------- #
#         Settings	    #
# --------------------- #

CMD_USR="sudo -u ${USER}"
CMD_ROOT="sudo"

# --------------------- #
#	        Funcs		      #
# --------------------- #

# --- repository ---

# $1 - string - svn checkout address
cloneGIT()
{
	$CMD_USR git clone $1
}

# $1 - string - git clone address
cloneSVN()
{
	$CMD_USR svn checkout $1
}

# $1 - string|integer - select repo type ( 1 - git | 2 - svn )
# $2 - string - git/svn clone/checkout address
clone()
{

	case "$1" in
		"git" | 1)
			cloneGIT $2
		;;
		"svn" | 2) #svn
			cloneSVN $2
		;;
		*)
			echo "You choose wrong repo type!"
			exit
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
				cat repository.md
				exit
			;;
      -U|--user)
        user="$2"
        shift # past argument
      ;;
			-t|--type)
      	type="$2"
      	shift # past argument=value
      ;;
      -u|--url)
      	url="$2"
      	shift # past argument=value
      ;;
			-w|--where)
				where="$2"
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

	cd $where
	clone $type $url

	#return
		#null
}

attrs $@
run
