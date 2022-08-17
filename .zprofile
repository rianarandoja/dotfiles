export RBENV_ROOT=$rbenvdir
export PATH=~/Code/go/bin:/usr/local/share/npm/bin:~/.rbenv/bin:~/.cargo/bin:/usr/local/sbin:/usr/local/bin:$PATH

export RUBY_GC_MALLOC_LIMIT=50000000

if type rbenv &> /dev/null; then
  eval "$(rbenv init -)"
fi

if type shadowenv &> /dev/null; then
  eval "$(shadowenv init zsh)"
fi
