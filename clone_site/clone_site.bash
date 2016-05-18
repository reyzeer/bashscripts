#!/bin/bash

echo "Choose repository type (git/svn):"
read repoType

echo "Get repository address:"
read repoAddress

bash clone_repo.bash $repoType $repoAddress

echo "something after clone_repo.bash"

#bash clone_repo.bash
