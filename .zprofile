if type brew &> /dev/null; then
  [ -d $(brew --prefix node) ] && export NODE_PATH=/usr/local/lib/node_modules
fi

export RBENV_ROOT=$rbenvdir
export PATH=~/Code/go/bin:/usr/local/share/npm/bin:~/.rbenv/bin:/usr/local/sbin:/usr/local/bin:$PATH

export RUBY_GC_MALLOC_LIMIT=50000000

if type rbenv &> /dev/null; then
  eval "$(rbenv init --no-rehash - zsh)"
fi
