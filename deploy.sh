## Variables

# Branch that should be build, e.g. 'master'
build_branch='master'

# Subdomain, e.g. 'sub.' Optional, mind the trailing '.' !
# subdomain='sub.'

# Domain, e.g. 'example.com'.
domain='example.com'

# Path to your Jekyll Git-Repository 
git_repo="${HOME}/repos/${domain}.git"

# Path to document root, destination for the generated html
www="/var/www/virtual/${USER}/${subdomain}${domain}"
