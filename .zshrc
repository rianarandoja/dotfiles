#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi

export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Load general files
source ~/.aliases
source ~/.exports
source ~/.functions

# Load platform specific files
if [[ $platform == 'linux' ]]; then
  source ~/.aliases.linux
elif [[ $platform == 'darwin' ]]; then
  source ~/.aliases.darwin
  source ~/.exports.darwin
fi
