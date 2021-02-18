#!/bin/bash
#
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

build_branch='master'	# e.g. 'master'
site='netzaffe.de'	# e.g. 'example.com'
site_prefix=''         	# e.g. 'preview.' # Mind the trailing '.' !

# Uberspace specific variables

git_repo=${HOME}/repos/${site}.git 
www=/var/www/virtual/${USER}/${site_prefix}${site}

## Do the magic
 
[[ "$pushed_branch" != "$build_branch" && "$pushed_branch" != "NONE" ]] && exit
tmp=$(mktemp -d)
git clone ${git_repo} ${tmp}
cd ${tmp}
bundle install --path=~/.gem || bundle install --path=~/.gem --redownload
bundle exec jekyll build --source ${tmp} --destination ${www}
rm -rf ${tmp}
exit
