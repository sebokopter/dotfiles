#
# ~/.bashrc
#

################################################################################
# General
################################################################################

# If not running interactively, don't do anything (version 1)
#[ -z "$PS1" ] && return
# If not running interactively, don't do anything (version 2)
[[ $- != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, bash includes filenames beginning with a `.' in the 
# results of pathname expansion.
shopt -s dotglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################################################################################
# Aliases (stored in .bash_aliases
################################################################################
# invoke the aliases
if [ -e ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

################################################################################
# Functions (stored in .bash_functions
################################################################################
# invoke the Functions
if [ -e ~/.bash_functions ]; then
  source ~/.bash_functions
fi

################################################################################
# Autojump
################################################################################
if [ -e /usr/share/autojump/autojump.bash ]; then
  source /usr/share/autojump/autojump.bash
fi
# make `j` better
function j { 
    new_path="$(autojump $@)";
    status=$?; 
    if (( status == 0 )); then
        if [ -n "$new_path" ]; then 
            echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";
        else false; 
        fi;
    else
        cd $@;
    fi
}  

################################################################################
# Variables
################################################################################

export EDITOR="vim"
if [[ -n $(which ruby) ]]; then 
    export PATH="`ruby -rubygems -e 'puts Gem.user_dir'`/bin:$PATH"
fi

# colored grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
# colored ls
export LSCOLORS='Gxfxcxdxdxegedabagacad'

################################################################################
# MOTD
################################################################################

if [[ -n $(which cowsay 2> /dev/null ) && -n $(which fortune 2> /dev/null ) ]]; then
    # show on every new bash open
    ## FIXME: How can I recursive call $()?
    rand=$(($RANDOM % 100))
    if [ -d /usr/share/cows ]; then
        path='/usr/share/cows/'
    fi
    if [ -d /usr/share/cowsay/cows ]; then
        path='/usr/share/cowsay/cows/'
    fi
    
    if [[ $rand -lt 50 ]]; then 
        if [ -n $path ]; then
            cowcount=$(ls -1 $path | wc -l)
            cownumber=$(($RANDOM % $cowcount +1))
            cow=$(ls -1 $path | sed -n "{ $cownumber p}")
            man $(ls /usr/bin | shuf -n 1) 2>&1 | sed -n "/^NAME/ {n;p;q}" | cowsay -f $path$cow
        else
            man $(ls /usr/bin | shuf -n 1) | sed -n "/^NAME/ {n;p;q}"
        fi
    elif [[ $rand -lt 100 ]]; then 
        if [ -n $path ]; then
            cowcount=$(ls -1 $path | wc -l)
            cownumber=$(($RANDOM % $cowcount +1))
            cow=$(ls -1 $path | sed -n "{ $cownumber p}")
            cowsay -f $path$cow "$(fortune -s)"
        else
            fortune -s
        fi
    else 
        fortune ascii-art
    fi
elif [[ -n $(which fortune 2> /dev/null ) ]]; then
     if [[ $rand -lt 50 ]]; then 
        man $(ls /usr/bin | shuf -n 1) | sed -n "/^NAME/ {n;p;q}"
    elif [[ $rand -lt 100 ]]; then 
        fortune -s
    else 
        fortune ascii-art
    fi
fi

################################################################################
# History
################################################################################

# The forward-search-history is bound to Ctrl+S by default. But most terminals override Ctrl+S to suspend execution until Ctrl+Q is entered (XON/XOFF flow control). stty -ixon disables flow control:
stty -ixon

# append to bash_history if Terminal quits
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# Ignore (=don't show) the following commands in the history
## & removes duplicates
#export HISTIGNORE="history:&:clear:cd*:exit"

# resize history size
export HISTSIZE=5000

# display history command with date and time
export HISTTIMEFORMAT="%Y-%m-%d %T "

################################################################################
# based on bash-it (zork theme) 
################################################################################
SCM_GIT='git'
SCM_GIT_CHAR="\[\033[1;32m\]±\[\033[0m\]"
SCM_NONE='NONE'
SCM_NONE_CHAR='○'

function git_info {
  PROMPT_DIRTY=" \[\033[1;31m\]✗\[\033[0m\]"
  PROMPT_CLEAN=" \[\033[1;32m\]✓\[\033[0m\]"
  DIRTY=0
  STATE=''
  local status="$(git status -bs --porcelain 2> /dev/null)"
  if [[ -n "$(grep -v ^# <<< "${status}")" ]]; then
    DIRTY=1
    STATE=$PROMPT_DIRTY
  else
    DIRTY=0
    STATE=$PROMPT_CLEAN
  fi
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  BRANCH=${ref#refs/heads/}

  local ahead_re='.+ahead ([0-9]+).+'
  local behind_re='.+behind ([0-9]+).+'
  GIT_AHEAD=''
  GIT_BEHIND=''
  GIT_AHEAD_CHAR="↑"
  GIT_BEHIND_CHAR="↓"
  [[ "${status}" =~ ${ahead_re} ]] && GIT_AHEAD=" ${GIT_AHEAD_CHAR}${BASH_REMATCH[1]}"
  [[ "${status}" =~ ${behind_re} ]] && GIT_BEHIND=" ${GIT_BEHIND_CHAR}${BASH_REMATCH[1]}"

  GIT_STASH=''
  local stash_count="$(git stash list | wc -l | tr -d ' ')"
  [[ "${stash_count}" -gt 0 ]] && GIT_STASH=" {${stash_count}}"
  echo -e "$BRANCH\[\033[01;32m\]$STATE\[\033[0m\]$GIT_AHEAD$GIT_BEHIND$GIT_STASH"
}

scm() {
    if [[ -f .git/HEAD ]]; then
        SCM='git'
        SCM_CHAR="\[\033[1;32m\]±\[\033[0m\]"
        SCM_PROMPT_DIRTY=" \[\033[1;31m\]✗\[\033[0m\]"
        SCM_PROMPT_CLEAN=" \[\033[1;32m\]✓\[\033[0m\]"
    elif [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]]; then
        SCM='git'
        SCM_CHAR="\[\033[1;32m\]±\[\033[0m\]"
        SCM_PROMPT_DIRTY=" \[\033[1;31m\]✗\[\033[0m\]"
        SCM_PROMPT_CLEAN=" \[\033[1;32m\]✓\[\033[0m\]"
    else
        SCM='NONE'
        SCM_CHAR='○'
    fi

    if [ $SCM = 'NONE' ]; then
            return
    else
            echo "[$SCM_CHAR][$(git_info)]"
    fi
}

prompt() {

    my_ps_host="\[\033[00;32m\]\h\[\033[00m\]";
    my_ps_user="\[\033[01;32m\]\u\[\033[00m\]";
    my_ps_root="\[\033[01;31m\]\u\[\033[00m\]";
    my_ps_path="\[\033[00;36m\]\w\[\033[00m\]";

    # nice prompt
    case "`id -u`" in
        0) PS1="[$my_ps_root][$my_ps_host]$(scm)[$my_ps_path]
# "
        PS2="# "
        ;;
        *) PS1="[$my_ps_user][$my_ps_host]$(scm)[$my_ps_path]
$ "
        PS2="$ "
        ;;
    esac
}

# Default PS1
# PS1='[\u@\h \W]\$ '
PS3=">> "

PROMPT_COMMAND=prompt


################################################################################
# Node.js
################################################################################
if [ -s ~/.nvm/nvm.sh ]; then
  NVM_DIR=~/.nvm
  source ~/.nvm/nvm.sh
fi
