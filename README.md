# jekyll_deployment

Deployment of Jekyll-Sites on via Git Bare Repository and *post-receive* 
[*git hook*](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
on a Linux🐧 webserver e.g. [uberspace](https://uberspace.de/en)🚀.

What it does: a local `git push` triggers the *post-receive git hook* on the target system
which serves our generated html.
1. Check configured branch and pushed branch (exit or continue)
2. Generate a temporary directory
3. Clone the bare repo into this directory
4. Install the dependencies specified in your *Gemfile*
5. Generate HTML from Jekyll via `jekyll build` to our *document root*
6. Delete temporary directory from 2.
7. Execute an optional task, `$post_exec` that can be configured

The script can be used in 2 ways:
1. as *post-receive-hook*
2. as standalone script with the *git bare repository* as argument

In both cases the same config (*deploy.sh*) is used.

## Installation

### Bare-Git-Repository

We need to create a [bare git repository](https://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/) 
**on your target machine**.

We start after successful ssh-login on our target host in our home directory
and create a directory for our repositories.

```
mkdir repos
```
change into... 
```
cd repos
```
and create another directory to which we want to *push*.
In the following example the directory is named like our domain. 
(From here on you should substitute *florian.latzel.io* with yours...)Domain ersetzen.

```
mkdir florian.latzel.io
```

change into... 
```
cd florian.latzel.io
```

now we initialise the directory as **bare repository**.
```
git init --bare
```

### Post-receive Git Hook

At first we remove the *post-receive* from the *git repository* (if exists),
to replace it later with a symbolic link to our script:
```
rm ~/repos/florian.latzel.io/hooks/post-receive
```

We clone the [Jekyll Deployment Skript](https://github.com/fl3a/jekyll_deployment)
into above created *repo* directory:
```
git clone https://github.com/fl3a/jekyll_deployment.git ~/repos 
```

Now we create a symbolic link named *post-receive* in our *git bare repository* 
which source is the same named script from [Jekyll Deployment Skript](
https://github.com/fl3a/jekyll_deployment):
```
ln -s ~/repos/jekyll_deployment/post-receive ~/repos/florian.latzel.io/hooks/post-receive
```

At last, we need to make script executable:
```
chmod +x ~/repos/jekyll_deployment/post-receive
```

### Standalone Script

Set a symbolic link to directory which is your `$PATH`.
(On uberspace it is `~/bin` by default).
```
ln -s ~/repos/jekyll_deployment/post-receive ~/bin/jekyll_deployment
```
## Configuration

### Set BUNDLE_PATH

**On your target machine**, add the following line to *~/.bundle/config*:
```
BUNDLE_PATH: "~/.gem"
```

### deploy.conf

Copy *deploy.conf* to your sites repo, 
edit the mandatory variables, commit and push it,
so the can read its config from the repo.

These are the **mandatory variables**, you must change them according your needs:   
(If you are on uberspace like me, `www` path schema will already fit😙)

1. `build_branch`, the branch that should be build (pushes to other branches will be ignored) e.g. `main`
2. `domain`, name of your domain e.g. `'example.com'`
3. `git_repo`, path to your Jekyll Git-Repository e.g. `"${HOME}/repos/${domain}.git"`
4. `www`, path to document root, destination for the generated html e.g. `"/var/www/virtual/${USER}/${domain}"`

For **optional variables** have a look at [deploy.conf](
https://github.com/fl3a/jekyll_deployment/blob/master/deploy.conf) and the corresponding comments.

### Add remote repository

**On your local machine**, you need to add a *remote repository*,
in below example named `uberspace` to your local git repository.
```
git remote add uberspace fl3a@bellatrix.uberspace.de:repos/florian.latzel.io
```

Now you can push your branch e.g. main to your remote `uberspace`
and might see the output from `git clone`, `bundle install` and `jekyll build`
after the transmission of your changes.
```
git push uberspace main
```

## Usage

### git push

From your repository **on your local machine** you will just type `git push uberspace`
and your site will be depoyed in a few moments.

### jekyll_deployment

**On your target machine** (where the HTML is generated and served) type `jekyll_deployment` 
with path to your bare respository as argument:
```
jekyll_deployment ~/repos/florian.latzel.io
```

This might be useful if you want to rebuild your site without having changes to push.   
E.g. your deployment fails and you want to investigate where and why.

## Examples & other resources

- [deploy.conf of florian.latzel.io](https://github.com/fl3a/florian.latzel.io/blob/master/deploy.conf)
- [deploy.conf of my cv](https://github.com/fl3a/cv/blob/main/deploy.conf) which lives at <https://florian.latzel.io/cv/>
- [Jekyll Deployment via Bare Repository und post-receive Hook](
https://florian.latzel.io/jekyll-deployment-via-bare-repository-und-post-receive-hook.html)

## Credits

This script is based  on [Jekyll Auf Uberspace Mit Git](
https://www.wittberger.net/post/jekyll-auf-uberspace-mit-git/) from Daniel Wittberger.   
Thanks for sharing🙏!

Since 2013 jekyll and uberspace changed a bit 
and this script itself experienced a lotta love👨‍💻💕.
