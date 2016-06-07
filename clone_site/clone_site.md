# clone_site.bash

## Requirements

- git
- subversion
- php
- composer

## Settings


## Arguments

- `-h | --help` - help info
- `-U | --user` - clone/checkout folder owner
- `-rt | --repositoryType` - repository type [ `svn` or `git`]
- `-ru | --repositoryUrl` - repository address [ example: `https://github.com/reyzeer/bashscripts.git` ]
- `-ut | --urlType` - repository type [ `github` or `project.coop`]
- `-f | --framework` - framework [ `yii2_advanced` or `only_composer`]
- `-fd | --frameworkDir` - dir to main framwork catalog (realtive)
- `-m | --modules` - list of modules in yii2_advanced [ example: `backend;frontend` ]
- `-d | --domains` - list of domains with path [ example: `"domain.loc,/;domain-admin.loc,/admin"`, "" is requirements ]

## Example

`bash framework.bash -U reyzeer -f yii2_advanced -m "frontend;backend" -d /home/reyzeer/repos/my_site`

## Return

`null`
