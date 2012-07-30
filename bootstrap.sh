#!/usr/bin/env zsh
cd "$(dirname "$0")"
git pull
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
  if [[ -d ~/.oh-my-zsh ]]; then
    cd ~/.oh-my-zsh; git pull; cd ~;
  else
    /usr/bin/env git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  fi
}
if [[ $1 == "--force" || $1 == "-f" ]]; then
	doIt
else
	echo "This may overwrite existing files in your home directory. Are you sure? (y/n) "
  read line
  if [ "$line" = Y ] || [ "$line" = y ]; then
		doIt
	fi
fi
unset doIt
source ~/.zshrc