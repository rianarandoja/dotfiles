#!/bin/zsh

norbenv=$1
root=$PWD

# --- Functions --- #
# Notice title
function notice { echo -e "\033[1;32m=> $1\033[0m"; }

# Error title
function error { echo -e "\033[1;31m=> Error: $1\033[0m"; }

# List item
function c_list { echo -e "  \033[1;32m✔\033[0m $1"; }

# Error list item
function e_list { echo -e "  \033[1;31m✖\033[0m $1"; }

# Check for dependency
function dep {
  # Check installed
  local i=true
  type -p $1 &> /dev/null || i=false

  # Check version
  if $i ; then
    local version=$($1 --version | grep -oE -m 1 "[[:digit:]]+\.[[:digit:]]+\.?[[:digit:]]?")
    [[ $version < $2 ]] && local msg="$1 version installed: $version, version needed: $2"
  else
    local msg="Missing $1"
  fi

  # Save if dep not met
  if ! $i || [ -n "$msg" ] ; then
    missing+=($msg)
  fi
}

function fetch_external {
  if [ -d $1 ]; then
    cd $1
    git pull
  else
    mkdir -p $1
    git clone $2 $1
  fi
}

function install {
  notice "Copying dotfiles"
  cd $root
  rsync -rv --exclude '.git' --exclude 'bin' --exclude 'bootstrap.sh' --exclude 'README.md' --include '.**' ./ ~/
}

function externals {
  # if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  #   notice "Installing zprezto"
  #   git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  #   setopt EXTENDED_GLOB
  #   for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  #     ln -nsf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  #   done
  # else
  #   notice "Updating zprezto"
  #   cd "${ZDOTDIR:-$HOME}/.zprezto"
  #   git pull
  #   cd ~
  # fi

  if [ ! -d "${ZDOTDIR:-$HOME}/.oh-my-zsh" ]; then
    notice "Installing oh-my-zsh"
    git clone --recursive git://github.com/robbyrussell/oh-my-zsh.git "${ZDOTDIR:-$HOME}/.oh-my-zsh"
  else
    notice "Updating oh-my-zsh"
    cd "${ZDOTDIR:-$HOME}/.oh-my-zsh"
    git pull
    cd ~
  fi

  if [ $norbenv != "skip-rbenv" ]; then
    notice "Updating rbenv"
    fetch_external ~/.rbenv "git://github.com/sstephenson/rbenv.git"
    fetch_external ~/.rbenv/plugins/ruby-build "git://github.com/sstephenson/ruby-build.git"
    fetch_external ~/.rbenv/plugins/rbenv-vars "git://github.com/sstephenson/rbenv-vars.git"
    fetch_external ~/.rbenv/plugins/rbenv-sudo "git://github.com/dcarley/rbenv-sudo.git"
  fi
}

# --- INIT --- #
current_pwd=$(pwd)
missing=()

# --- Check deps --- #
notice "Checking dependencies"
dep "git"  "1.7"

if [ "${#missing[@]}" -gt "0" ]; then
  error "Missing dependencies"
  for need in "${missing[@]}"; do
    e_list "$need."
  done
  exit 1
fi

# Assumes ~/.dotfiles is *ours*
if [ -d ~/.dotfiles ]; then
  notice "Updating"
  cd ~/.dotfiles
  git pull origin master

  notice "Installing"
else
  notice "Downloading"
  git clone --recursive git://github.com/krisrang/dotfiles.git ~/.dotfiles

  notice "Installing"
  cd ~/.dotfiles
fi

externals
install

# --- Finished --- #
cd $current_pwd
notice "Done"
