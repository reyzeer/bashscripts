#!/bin/bash

CMD_USR="sudo -u ${USER}"
CMD_ROOT="sudo"

# --------------------- #
#         Settings	    #
# --------------------- #

WWW_PATH=~/WWW
USER=reyzeer

# --------------------- #
#	        Funcs		      #
# --------------------- #


# --------------------- #
#	        main          #
# --------------------- #

attrs()
{
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in
        -h|--help)
          cat clone_site.md
  				exit
        ;;
        -rt|--repositoryType)
          repositoryType="$2"
          shift # past argument
        ;;
        -ru|--repositoryUrl)
          repositoryUrl="$2"
          shift # past argument
        ;;
        -ut|--urlType)
          urlType="$2"
          shift # past argument
        ;;
        -f|--framework)
          framework="$2"
          shift # past argument
        ;;
        -m|--modules)
          modules="$2"
          shift # past argument
        ;;
        -d|--domains)
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

main()
{

  bash repository.bash -U $USER -d $WWW_PATH -t $repositoryType -u $repositoryUrl

  dirName=$(bash path.bash -t $urlType -u $repositoryUrl)
  dir=${WWW_PATH}/${dirName}

  bash framework.bash -U $USER -f $framework -m $modules -d $dir

  bash add_domain.bash -U $USER -di $dir -do $domains

  echo "Finish"

}

attrs $@
main
