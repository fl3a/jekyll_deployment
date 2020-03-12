#!/bin/bash
#
# Deployment of Jekyll-Sites on Uberspace 
# via Git Bare Repository and post-receive Hook.
#
# See https://netzaffe.de/jekyll-deployment-auf-uberspace-via-bare-repo-und-post-receive-hook/ 
# for requirements and more detailed description (german)

read oldrev newrev ref
pushed_branch=${ref#refs/heads/}

## Variables

build_branch='master'
site='example.com'
site_prefix='int.'

git_repo=${HOME}/repos/${site}.git 
tmp=${HOME}/repos/tmp/${site}
www=/var/www/virtual/${USER}/${site_prefix}${site}

## Do the magic
 
[ $pushed_branch != $build_branch ] && exit
git clone ${git_repo} ${tmp}
cd ${tmp}
bundle install --path=~/.gem
JEKYLL_ENV=production jekyll build --source ${tmp} --destination ${www}
rm -rf ${tmp}
exit
