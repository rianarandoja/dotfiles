if [[ $(uname) == "Darwin" ]]; then
  ~/bin/seeyou.sh; sleep 2
fi

if [[ $(grep microsoft /proc/version) ]]; then
  ~/bin/seeyou.sh; sleep 2
fi

exit 0
