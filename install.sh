#!/bin/zsh

dorbenv=$1
root=~/.dotfiles/

# --- Functions --- #
# Notice title
function notice { echo -e "\033[1;32m=> $1\033[0m"; }

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
  rsync -rv --exclude '.git' --exclude 'bootstrap.sh' --exclude 'README.md' --include '.**' ./ ~/
}

function externals {
  if [ ! -d "${ZDOTDIR:-$HOME}/.oh-my-zsh" ]; then
    notice "Installing oh-my-zsh"
    git clone --recursive git://github.com/robbyrussell/oh-my-zsh.git "${ZDOTDIR:-$HOME}/.oh-my-zsh"
  else
    notice "Updating oh-my-zsh"
    cd "${ZDOTDIR:-$HOME}/.oh-my-zsh"
    git pull
    cd ~
  fi

  fetch_external ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting "https://github.com/zsh-users/zsh-syntax-highlighting.git"

  if [ $dorbenv != "skip-rbenv" ]; then
    notice "Updating rbenv"
    fetch_external ~/.rbenv "git://github.com/sstephenson/rbenv.git"
    fetch_external ~/.rbenv/plugins/ruby-build "git://github.com/sstephenson/ruby-build.git"
    fetch_external ~/.rbenv/plugins/rbenv-vars "git://github.com/sstephenson/rbenv-vars.git"
  fi
}

externals
install
