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

# Branch that should be build, e.g. 'master'
build_branch='master'			

# Subdomain, e.g. 'sub.' Optional, mind the trailing '.' !
subdomain=''
# Domain, e.g. 'example.com'.
domain='netzaffe.de'			

# Path to your Jekyll Git-Repository 
git_repo=${HOME}/repos/${domain}.git	

# Path to document root, destination where the the generated html is served.
www=/var/www/virtual/${USER}/${subdomain}${domain}

## Do the magic
 
[[ "$pushed_branch" != "$build_branch" && "$pushed_branch" != "NONE" ]] && exit
tmp=$(mktemp -d)
git clone ${git_repo} ${tmp}
cd ${tmp}
bundle install || bundle install --redownload
bundle exec jekyll build --source ${tmp} --destination ${www}
rm -rf ${tmp}
exit
