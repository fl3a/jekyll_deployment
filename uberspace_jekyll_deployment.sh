#!/bin/bash

# Deployment of Jekyll-Sites on Uberspace 
# via Git Bare Repository and post-receive Hook.
#
# See https://netzaffe.de/jekyll-deployment-auf-uberspace-via-bare-repo-und-post-receive-hook/ 
# for requirements and more detailed description (german)

if [[ $# -eq 1 && $1 == "--cli" ]] 
then
	pushed_branch="NONE" 
else
	read oldrev newrev ref 
	pushed_branch=${ref#refs/heads/} 
fi

## Variables

# Path to your Jekyll Git-Repository 
git_repo=${HOME}/repos/${domain}.git	

# Branch which should be build via this script on post-receive. 
# E.g. 'master'
build_branch='master'			

# Subdomain and Domain.
# E.g.: 'sub.' (Optional, mind the trailing '.' !) + 'example.com'.
subdomain=''
domain='netzaffe.de'			

# Path to document root, destination where the the generated html is served.
www=/var/www/virtual/${USER}/${subdomain}${domain}

## Do the magic
 
[[ "$pushed_branch" != "$build_branch" && "$pushed_branch" != "NONE" ]] && exit
tmp=$(mktemp -d)
git clone ${git_repo} ${tmp}
cd ${tmp}
bundle install --path=~/.gem || bundle install --path=~/.gem --redownload
bundle exec jekyll build --source ${tmp} --destination ${www}
rm -rf ${tmp}
exit
