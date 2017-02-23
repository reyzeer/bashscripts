#!/bin/bash

# SETTINGS
# =======================================================

# scritp variables
# =======================================================
MODE=0

ATTRS()
{
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in
      "-h"|"--help")
				cat add_domain.md
				exit
			;;
      -U|--user)
        user="$2"
        shift # past argument
      ;;
			-di|--dir)
      	dir="$2"
      	shift # past argument=value
      ;;
			-do|--domains)
				domains="$2"
				shift # past argument
			;;
      *)
        # unknown option
      ;;
    esac
    shift # past argument or value
  done
}

RUN()
{
  echo $MODE
}

ATTRS $@
RUN
