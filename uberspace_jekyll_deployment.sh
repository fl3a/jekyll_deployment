#!/bin/bash

# Deployment of Jekyll-Sites on Uberspace 
# via Git Bare Repository and post-receive Hook.
#
# See https://netzaffe.de/jekyll-deployment-auf-uberspace-via-bare-repo-und-post-receive-hook/ 
# for requirements and more detailed description (german)
# set -x

if [[ $# -eq 1 && $1 == "--cli" ]] 
then
	pushed_branch="NONE" 
else
	read oldrev newrev ref 
	pushed_branch=${ref#refs/heads/} 
fi

## Variables

config=$(mktemp)
git-show HEAD:build.conf > ${config} || exit
source ${config}

## Do the magic
 
[[ "$pushed_branch" != "$build_branch" && "$pushed_branch" != "NONE" ]] && exit
tmp=$(mktemp -d)
git clone ${git_repo} ${tmp}
cd ${tmp}
bundle install || bundle install --redownload
bundle exec jekyll build --source ${tmp} --destination ${www}
rm -rf ${tmp} ${config}
exit
