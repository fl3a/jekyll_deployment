# jekyll_deployment

Deployment of Jekyll-Sites on via Git Bare Repository and post-receive Hook 
on a Linux a webserver e.g. [uberspace](https://uberspace.de).

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

## Configuration

### deploy.conf

### Set BUNDLE_PATH

Add the following line to *~/.bundle/config*:
```
BUNDLE_PATH: "~/.gem"
```
## Examples

## Credits

Dieser Artikel basiert im wesentlichen auf 
[Jekyll Auf Uberspace Mit Git](https://www.wittberger.net/post/jekyll-auf-uberspace-mit-git/) von Daniel Wittberger 
und [Jekyll Auf Uberspace](https://lc3dyr.de/blog/2012/07/22/Jekyll-auf-Uberspace/)
von Franz aka laerador. Danke!

Dieser Artikel ist eine aktuelle Essenz, die sich nur auf das Deployment bezieht. 
Seit 2012, 2013 hat sich einiges in Jekyll und auf Uberspace etc. getan 
und das Skript hat noch etwas Liebe erfahren. 
