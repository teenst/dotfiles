#First add
autoload -U compinit
compinit
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
                             /usr/local/git/bin
#History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_space # ignore duplication command history list
setopt share_history # share command history data


setopt auto_cd # auto cd
setopt auto_pushd # use cd hyphen
setopt correct # complement command
setopt list_packed # compacked complete list display
bindkey -e # emacs keybind
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
setopt IGNOREEOF
setopt share_history


export LANG=ja_JP.UTF-8
export EDITOR="vim"

export PATH=$HOME/bin:$HOME/local/bin:/usr/local/bin:$PATH
export CPLUS_INCLUDE_PATH=$HOME/local/include
export C_INCLUDE_PATH=$HOME/local/include
export LIBRARY_PATH=$HOME/local/lib
export LDFLAGS="-L$HOME/local/lib"
export LD_LIBRARY_PATH=$HOME/local/lib:/usr/local/lib
export PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig

case $OSTYPE in
    linux*)
        #plenv
        export PATH="$HOME/.plenv/bin:$PATH"

        #pyenv
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"

        # zsh-completions via github
        # https://github.com/zsh-users/zsh-completions
        fpath=(~/github/zsh-completions /usr/local/share/zsh/functions $fpath)

        ;;
    darwin*)
        
        if [ -n "$DYLD_FALLBACK_LIBRARY_PATH" ]; then
            DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:$HOME/local/lib
        else
            DYLD_FALLBACK_LIBRARY_PATH=$HOME/local/lib
        fi
        export DYLD_LIBRARY_PATH        


        #emacs
        alias emacs=/usr/local/Cellar/emacs/24.3/Emacs.app/Contents/MacOS/Emacs -nw
        #rm alias
        alias rm="trash"

        
        #TeX
        #Ghostscript:http://www.muskmelon.jp/?page_id=75
        export PATH=/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:/usr/texbin:$PATH
        export MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH

        #zsh-completions via homebrew
        fpath=(/usr/local/share/zsh-completions $fpath)

esac


#ls color
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors \
    'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#ls other
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -a"

#diff coler
alias diff='colordiff'
alias less='less -R'


#Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#Perl
# https://github.com/tokuhirom/plenv
if which plenv > /dev/null; then eval "$(plenv init -)"; fi

#Python
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi


# git u command
function u()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

#gxp
export PS1="`gxpc prompt 2> /dev/null`\$ "



# mosh
compdef mosh=ssh

#git
export GIT_PAGER="lv -c"

# scala(svm)
## http://yuroyoro.hatenablog.com/entry/20110121/1295610398
export SCALA_HOME=~/.svm/current/rt
export PATH=$SCALA_HOME/bin:$PATH


