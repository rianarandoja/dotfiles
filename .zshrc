ZSH=$HOME/.oh-my-zsh
ZSH_THEME="muse"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi

if [[ $platform == 'linux' ]]; then
  plugins=(git autojump bundler encode64 extract gem heroku nyan rails3 rake rbenv pip)
elif [[ $platform == 'darwin' ]]; then
  plugins=(git autojump brew bundler encode64 extract gem heroku nyan osx pow powder rails3 rake rbenv terminalapp pip)
fi

export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
source $ZSH/oh-my-zsh.sh

unsetopt correct_all

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
