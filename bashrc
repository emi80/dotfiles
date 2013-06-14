# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host " ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

if [ -f $HOME/.git-prompt.sh ]; then
    . $HOME/.git-prompt.sh
fi

if [ -f $HOME/.git-completion.bash ]; then
    . $HOME/.git-completion.bash
fi

if [ `uname` == "Darwin" ];then
    . /usr/local/git/contrib/completion/git-completion.bash
    . /usr/local/git/contrib/completion/git-prompt.sh
fi



## The prompt
PS1='[\u@\h \W]\[\033[1;34m\]$(__git_ps1)\[\033[00m\]\$ '
GIT_PS1_SHOWDIRTYSTATE=true

## terminal 
export TERM=xterm-256color

## default tweaks for mac os x
if [ `uname` == 'Darwin' ]; then
    alias ls="ls -G"
    alias ll="ls -laG"
    export PATH=$PATH:~/Library/Python/2.7/bin
fi
# some Linux aliases
if [ `uname` == 'Linux' ]; then
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

## default path and library path
export PATH=$HOME/usr/bin:$PATH
export LD_LIBRARY_PATH=$HOME/usr/lib:$LD_LIBRARY_PATH

## configure editor
export ALTERNATE_EDITOR=vim
export EDITOR='vim'
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

## language
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"


## load customizations
if [ -d "$HOME/.bashrc.d" ] && [ "`ls -A $HOME/.bashrc.d`" ]; then
    for file in $HOME/.bashrc.d/*; do
        . $file
    done
fi
