# Kris' dotfiles

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Code/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/krisrang/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

To update later on, just run that command again.

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
~/.osx
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common Homebrew formulae (after installing Homebrew, of course):

```bash
~/.brew
```

## Thanks to…

* [Mathias Bynens](http://mths.be/) for the [original repo of this fork](https://github.com/mathiasbynens/dotfiles)
* [Gianni Chiappetta](http://gf3.ca/) for his [dotfile bootstrap scripts](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) for his [wgetrc](https://github.com/janmoesen/tilde)
* and recursively, all the others