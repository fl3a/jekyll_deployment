#!/bin/bash

# Deployment of Jekyll-Sites on Uberspace 
# via Git Bare Repository and post-receive Hook.
#
# See https://netzaffe.de/jekyll-deployment-auf-uberspace-via-bare-repo-und-post-receive-hook/ 
# for requirements and more detailed description (german)
# set -x

read oldrev newrev ref 
pushed_branch=${ref#refs/heads/} 

## Source configuration from repository

config=$(mktemp)
git-show HEAD:build.conf > $config || exit 
source ${config}

## Do the magic

[ "$pushed_branch" != "$build_branch" ] && exit 
tmp=$(mktemp -d)
git clone $git_repo $tmp
cd $tmp
bundle install || bundle install --redownload
bundle exec jekyll build --source $tmp --destination $www
rm -rf $tmp $config
