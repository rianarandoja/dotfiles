#!/bin/zsh

dorbenv=$1
root=~/.dotfiles/

# --- Functions --- #
# Notice title
function notice { echo -e "\033[1;32m=> $1\033[0m"; }

# Error title
function error { echo -e "\033[1;31m=> Error: $1\033[0m"; }

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
# --- INIT --- #
missing=()

# --- Check deps --- #
notice "Checking dependencies"
dep "git" "1.7"

if [ "${#missing[@]}" -gt "0" ]; then
  error "Missing dependencies"
  for need in "${missing[@]}"; do
    e_list "$need."
  done
  exit 1
fi

if [ -f ./install.sh ]; then
  notice "Installing"
  cd $root
  git pull origin master
  ./install.sh $dorbenv
fi

# --- Finished --- #
notice "Done"
