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
        -U|--user)
          user="$2"
          shift # past argument
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
        -fd|--frameworkDir)
          frameworkDir="$2"
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

  printf "
    Linux user:\t\t\t$USER
    Clone/checkout in:\t\t$WWW_PATH
    Repository type:\t\t$repositoryType
    Repository utl:\t\t$repositoryUrl
    Url type:\t\t\t$urlType
    Framework:\t\t\t$framework
    Framework (relative) dir:\t$frameworkDir
    Yii2 modules:\t\t$modules
    Domains:\t\t\t$domains
    \n"

  echo "All is ok?[y/n]"
  read isOk

  if [ "$isOk" != "y" ]
  then
    exit
  fi

  bash repository.bash -U $USER -d $WWW_PATH -t $repositoryType -u $repositoryUrl

  dirName=$(bash path.bash -t $urlType -u $repositoryUrl)
  dir=${WWW_PATH}/${dirName}

  bash framework.bash -U $USER -f $framework -m $modules -d ${dir}${frameworkDir}

  bash add_domain.bash -U $USER -di $dir -do $domains

  echo "Finish"

}

attrs $@
main
