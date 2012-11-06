#!/usr/bin/env bash

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
  rsync -rv --exclude '.git' --exclude 'bootstrap.sh' --exclude 'README.md' --include '.**' ./ ../
}

function externals {
  fetch_external ~/.oh-my-zsh "git://github.com/robbyrussell/oh-my-zsh.git"
  fetch_external ~/.rbenv "git://github.com/sstephenson/rbenv.git"
  fetch_external ~/.rbenv/plugins/ruby-build "git://github.com/sstephenson/ruby-build.git"
  fetch_external ~/.rbenv/plugins/rbenv-vars "git://github.com/sstephenson/rbenv-vars.git"
  fetch_external ~/.rbenv/plugins/rbenv-sudo "git://github.com/sstephenson/ruby-build.git"
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

install
externals

# --- Finished --- #
cd $current_pwd
notice "Done"
