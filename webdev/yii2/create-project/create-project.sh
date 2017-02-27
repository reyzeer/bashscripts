#!/bin/bash

# SETTINGS
# =======================================================

# Config file scheme
CONFIG_FILE_SCHEME=EOF

EOF

# scritp variables
# =======================================================
g_mode=0
g_user='orginal value'
g_dir='orginal value'
# =======================================================

function generate_config()
{
  echo "This will create new project.cfg file and overwrite existing one."
  read -p "Are you sure? (Y/n) " -n 1 -r
  if ! [[ $REPLY =~ ^[Nn]$ ]]
  then

    # --- Config file scheme ---
    cat <<EOF > project.cfg
# Project config file

# Clone/create project
NEW_PROJECt=true

# Repository
REPO_URL=''
REPO_USER=''
REPO_PASS=''

# Repository branch
DEV_BRANCH='master'

# Privilage for Directory - chown
RIGHTS='user:www-data'

# Yii2
ENV='Development'

# Hosts
HOSTS=("frontend.loc" "dir/frontend/web/" "backend.loc" "dir/backend/web/")

# Create DB
DB_CREATE=true
DB_HOST='localhost'
DB_ROOT_PASS=''

# DB
DB_HOST=''

EOF
  # --- Config file scheme ---

  fi
}

function create_project()
{
  
}

function attrs()
{
  while [[ $# > 0 ]]
  do
    key="$1"
    case $key in
      -c|--config)
        g_mode='CONFIG'
      ;;
      "-h"|"--help")
				cat add_domain.md
				exit
			;;
      -U|--user)
        g_user="$2"
        shift # past argument
      ;;
			-di|--dir)
      	g_dir="$2"
      	shift # past argument=value
      ;;
			-do|--doit)
        echo 'DOIT!'
        g_mode='DOIT'
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

function run()
{
  echo "RUN g_mode: $g_mode"
  if [[ "$g_mode" == "CONFIG" ]]; then
    echo 'RUN CONFIG'
    generate_config
  elif [[ "$g_mode" == "DOIT" ]]; then
    echo 'RUN DOIT'
  fi

  echo "g_mode: $g_mode"
  echo "g_user: $g_user"
  echo "g_dir: $g_dir"
}

attrs $@
run
