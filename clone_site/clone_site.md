# path.bash

## Requirements

- php
- composer

## Settings


## Arguments

- `-h | --help` - help info
- `-U | --user` - clone/checkout folder owner
- `-f | --framework` - framework [ `yii2_advanced` or `only_composer`]
- `-m | --modules` - list of modules in yii2_advanced[ example: `backend;frontend` ]
- `-d | --dir` - dir to main framwork catalog

## Example

`bash framework.bash -U reyzeer -f yii2_advanced -m "frontend;backend" -d /home/reyzeer/repos/my_site`

## Return

`null`
