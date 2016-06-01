#!/bin/bash

WWW_PATH=~/WWW/
APACHE2_SITES_PATH=/etc/apache2/sites-available/
USER=reyzeer

echo "Choose repository type (git/svn):"
read repoType

echo "Get repository address:"
read repoAddress

bash clone_repo.bash $repoType $repoAddress

echo "something after clone_repo.bash"

#bash clone_repo.bash


