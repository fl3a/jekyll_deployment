# jekyll_deployment

Deployment of Jekyll-Sites on via Git Bare Repository and post-receive Hook on a Linux a webserver e.g. uberspace.

## Installation

### Bare-Git-Repository

We need to create a [bare git repository](https://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/) 
on your target machine.

Wir starten nach erfolgreichem SSH-Login auf unserem Uberspace-Host 
in unserem Home-Verzeichnis und legen Ordner für unser Repository an,

```
mkdir repos
```

wechseln dort hinein
```
cd repos
```

und erstellen den Ordner für das Repository auf das wir später *pushen* wollen.
In diesem Fall entspricht der Ordnername der Domain.
Ab hier solltest du das exemplarische *florian.latzel.io* durch deine Domain ersetzen.
```
mkdir florian.latzel.io
```

und wechseln hinein.
```
cd florian.latzel.io
```

Jetzt initialisieren wir den Ordner als **Bare Repository**[^bare].
```
git init --bare
```

### Post-receive Git Hook

Als Erstes entfernen wir den *Default post-receive Hook* aus dem Bare-Repository
um ihn später durch einen symbolischen Link auf unser Skript zu ersetzen.

```
rm ~/repos/florian.latzel.io/hooks/post-receive
```

Dann clonen wir das [Jekyll Deployment Skript](https://github.com/fl3a/jekyll_deployment), 
dort passiert später die ganze Magie.

```
git clone https://github.com/fl3a/jekyll_deployment.git ~/repos 
```

Jetzt legen wir einen Symlink namens *post-receive* im *Bare-Repo* an, 
der auf das gleichnamige *Deployment Skript* verweist:

```
ln -s ~/repos/jekyll_deployment/post-receive ~/repos/florian.latzel.io/hooks/post-receive
```

Dann muss das Skript noch ausführbar gemacht werden:

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
