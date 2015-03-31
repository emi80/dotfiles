# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# useful functions

function tlppid {
    # Look up the parent of the given PID.
    pid=${1:-$$}
    stat=($(</proc/${pid}/stat))
    ppid=${stat[3]}
   
    # /sbin/init always has a PID of 1, so if you reach that, the current PID is
    # the top-level parent. Otherwise, keep looking.
    if [[ ${ppid} -eq 1 ]] ; then
        echo ${pid}
    else
        top_level_parent_pid ${ppid}
    fi
} 
  
# print last command executed
getlast() { 
    fc -ln "$1" "$1" | sed '1s/^[[:space:]]*//';
}                                                                                                                                                                                                                                            
  
# tail from a label
ltail() {
    awk -vlabel="$1" '$0~label{line=NR}line && NR>line{print}' "$2"
} 

# set prompt                                                                                                                                                                                                                                 


prompt() {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local NORMAL="\[\033[0m\]"
  local RESET="\[\017\]"
  
  local SMILEY="${WHITEBOLD}:)${NORMAL}"
  local FROWNY="${REDBOLD}:(${NORMAL}"
  local SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

  __status() {
    local OK="$2\xe2\x9c\x93$4"
    local KO="$3\xe2\x9c\x97$4"
    if [ $1 -eq 0 ]; then echo -e $OK; else echo -e $KO;fi
  }

  
  export PS1=$"${RESET}\u@\h${GREENBOLD}:${YELLOWBOLD}\W${BLUEBOLD}\$(__git_ps1) ${NORMAL}> "
  #export PS1=$"${RESET}\u@\h \$(__status \$? \"${GREENBOLD}\" \"${REDBOLD}\" \"${NORMAL}\") ${YELLOWBOLD}\w${BLUEBOLD}\$(__git_ps1) ${NORMAL}> "
  #export PS1="${RESET}${YELLOWBOLD}\u@\h${NORMAL} \`${SELECT}\` ${YELLOWBOLD}\w\$(__git_ps1) >${NORMAL} "
  #export PS1="\n$BLACKBOLD[\t]$GREENBOLD \u@\h\[\033[00m\]:$BLUEBOLD\w\[\033[00m\] \\$ "  
  
}
  
################################################################################


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host " ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

if [ -f $HOME/.git-prompt.sh ]; then
    . $HOME/.git-prompt.sh
fi

if [ -f $HOME/.git-completion.bash ]; then
    . $HOME/.git-completion.bash
fi

if [ $(uname) == "Darwin" ];then
   . /usr/local/etc/bash_completion.d/git-completion.bash
   . /usr/local/etc/bash_completion.d/git-prompt.sh
fi

## The prompt
prompt
GIT_PS1_SHOWDIRTYSTATE=true

## terminal 
export TERM=xterm-256color

## default tweaks for mac os x
if [ `uname` == 'Darwin' ]; then
    alias ls="ls -G"
    alias l="ls -G"
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
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH

## configure editor
export ALTERNATE_EDITOR=vim
export EDITOR='vim'
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
export LESS="-R"

## language
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

## disable gnome keyring
unset GNOME_KEYRING_CONTROL

## load customizations
if [ -d "$HOME/.bashrc.d" ] && [ "`ls -A $HOME/.bashrc.d`" ]; then
    for file in $HOME/.bashrc.d/*; do
        . $file
    done
fi

[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && . /usr/local/bin/virtualenvwrapper.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
