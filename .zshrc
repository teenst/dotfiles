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

#ls color
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors \
    'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#ls other
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -a"


#Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source ~/.rbenv/completions/rbenv.zsh


case $OSTYPE in
    darwin*)
        #emacs
        alias emacs=/usr/local/Cellar/emacs/24.2/Emacs.app/Contents/MacOS/Emacs -nw
        #Perl
        #Perlbrew http://www.perl-entrance.org/p/modernperl20123.html
        source ~/perl5/perlbrew/etc/bashrc

        #TeX
        #Ghostscript:http://www.muskmelon.jp/?page_id=75
        export PATH=/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:/usr/texbin:$PATH
        export MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH

esac



# zsh-completionsを利用する Github => zsh-completions
# https://github.com/zsh-users/zsh-completions
fpath=(~/github/zsh-completions /usr/local/share/zsh/functions $fpath)

# #jubatus
# PATH=$PATH:$HOME/local/bin
# CPLUS_INCLUDE_PATH=$HOME/local/include
# export CPLUS_INCLUDE_PATH
# export PATH
# export set LDFLAGS=-L$HOME/local/lib
# LD_LIBRARY_PATH=$HOME/local/lib
# export LD_LIBRARY_PATH
# PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig
# export PKG_CONFIG_PATH

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

#LD(Linux)
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/lib
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/local/lib/pkgconfig
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/local/include
export C_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/local/include

# mosh
compdef mosh=ssh


#git
export GIT_PAGER="lv -c"
