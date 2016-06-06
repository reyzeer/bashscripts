# path.bash

## Requirements

## Settings

- APACHE2_SITES_PATH=/etc/apache2/sites-available
- APACHE_LOG_DIR=~/WWW/logs

## Arguments

- `-h | --help` - help info
- `-U | --user` - clone/checkout folder owner
- `-d | --dir` - dir to main project catalog
- `-do | --domains` - list of domains with path [ example: `"domain.loc,/;domain-admin.loc,/admin"`, "" is requirements ]

# Example

`bash add_domain.bash -U reyzeer -di /home/reyzeer/repos/my_site -do "my_site.dev,/trunk/frontend/web/;my_site-admin.dev,/trunk/backend/web/"`

## Return

`null`
