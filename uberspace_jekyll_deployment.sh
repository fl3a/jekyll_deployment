#!/bin/bash
#
# Deployment of Jekyll-Sites on Uberspace 
# via Git Bare Repository and post-receive Hook.
#
# See https://netzaffe.de/jekyll-deployment-auf-uberspace-via-bare-repo-und-post-receive-hook/ 
# for requirements and more detailed description (german)

[ $1 != "--cli" ] && read oldrev newrev ref ; pushed_branch=${ref#refs/heads/}

## Variables

build_branch='master'                 		# e.g. 'master'
pushed_branch=${pushed_branch:-$build_branch} 	# default for calling with --cli
site='netzaffe.de'                    		# e.g. 'example.com'
site_prefix=''         				# e.g. 'preview.' # Mind the trailing '.' !

# Uberspace specific variables
git_repo=${HOME}/repos/${site}.git 
www=/var/www/virtual/${USER}/${site_prefix}${site}

tmp=$(mktemp -d)

## Do the magic
 
[ $pushed_branch != $build_branch ] && exit
git clone ${git_repo} ${tmp}
cd ${tmp}
bundle install --path=~/.gem || bundle install --path=~/.gem --redownload
bundle exec jekyll build --source ${tmp} --destination ${www}
rm -rf ${tmp}
exit
