#Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#Perl
# https://github.com/tokuhirom/plenv
if which plenv > /dev/null; then eval "$(plenv init -)"; fi

#Python
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export PYTHONPATH=/usr/local/lib/python2.7/site-packages/
