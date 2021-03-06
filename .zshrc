#change shell
case $OSTYPE in
    linux*)
        if [ -e $HOME/local/bin/zsh ]; then
            export SHELL=$HOME/local/bin/zsh
        else
            echo "No local zsh"
        fi

        ;;
    darwin*)
        export SHELL=/usr/local/bin/zsh
esac

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
#export LDFLAGS="-L$HOME/local/lib"
export LD_LIBRARY_PATH=$HOME/local/lib:/usr/local/lib
export PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig

case $OSTYPE in
    linux*)
        ## prompt
        # ln -s ../pure/pure.zsh prompt_pure_setup
        fpath=(~/.dotfiles/zsh.d $fpath)
        autoload -U promptinit && promptinit
        prompt pure

	## anyenv
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"

        # zsh-completions via github
        # https://github.com/zsh-users/zsh-completions
        fpath=(~/github/zsh-completions /usr/local/share/zsh/functions $fpath)
        

        # hub command
        eval "$(hub alias -s)"
        compdef hub=git

        ;;
    darwin*)
        ## prompt
        # ln -s ../pure/pure.zsh prompt_pure_setup
        fpath=(~/gitrepos/dotfiles/zsh.d $fpath)
        autoload -U promptinit && promptinit
        prompt pure

	## anyenv
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"

	#zsh-completions via homebrew
        fpath=(/usr/local/share/zsh-completions $fpath)
        fpath=(/usr/local/share/zsh/site-functions $fpath)
        fpath=(/usr/local/share/zsh/functions $fpath)
        autoload -Uz compinit; compinit -u

        if [ -n "$DYLD_FALLBACK_LIBRARY_PATH" ]; then
            DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:$HOME/local/lib
        else
            DYLD_FALLBACK_LIBRARY_PATH=$HOME/local/lib
        fi
        export DYLD_LIBRARY_PATH        

        #export CPLUS_INCLUDE_PATH=/opt/boxen/homebrew/include:$CPLUS_INCLUDE_PATH
        #export C_INCLUDE_PATH=/opt/boxen/homebrew/include:$C_INCLUDE_PATH
        #export LIBRARY_PATH=/opt/boxen/homebrew/lib:$LIBRARY_PATH
        #export LDFLAGS="-L$HOME/local/lib ${LDFLAGS}"
        #export LD_LIBRARY_PATH=/opt/boxen/homebrew/lib:$LD_LIBRARY_PATH

        #emacs
        alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs -nw
        
        #byobu
        #export BYOBU_PREFIX=$(brew --prefix)
        
       #z command
        _Z_CMD=j 
	

        #TeX
        #Ghostscript:http://www.muskmelon.jp/?page_id=75
        export PATH=/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:/usr/texbin:$PATH
        export MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH

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

#rm
alias rm='trash'


# git u command
function u()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}


#gxp
#export PS1="`gxpc prompt 2> /dev/null`\$ "


# mosh
compdef mosh=ssh

#git
export GIT_PAGER="lv -c"

# scala(svm)
## http://yuroyoro.hatenablog.com/entry/20110121/1295610398
export SCALA_HOME=~/.svm/current/rt
export PATH=$SCALA_HOME/bin:$PATH


## screen tab information
preexec() {
    mycmd=(${(s: :)${1}})
    echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):$mycmd[1]\e\\"
}

precmd() {
    echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):idle\e\\"
}

# Fasd
eval "$(fasd --init posix-alias zsh-hook)"


# zsh syntax highlight
case $OSTYPE in
    linux*)
        source $HOME/github/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ;;
    darwin*)
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	
esac

