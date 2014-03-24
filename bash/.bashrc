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
# Variables
################################################################################

export EDITOR="vim"
export PATH=$PATH:~/bin:/home/sebo/.gem/ruby/2.0.0/bin
# colored grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
# colored ls
export LSCOLORS='Gxfxcxdxdxegedabagacad'

################################################################################
# MOTD
################################################################################

# show on every new bash open
## FIXME: How can I recursive call $()?
rand=$(($RANDOM % 100))
if [[ $rand -lt 50 ]]; then 
    if [ -d /usr/share/cows ]; then
        path='/usr/share/cows/'
        cowcount=$(ls -1 /usr/share/cows/ | wc -l)
        cownumber=$(($RANDOM % $cowcount +1))
        cow=$(ls -1 /usr/share/cows/| sed -n "{ $cownumber p}")
        man $(ls /usr/bin | shuf -n 1) 2>&1 | sed -n "/^NAME/ {n;p;q}" | cowsay -f $path$cow
    else
        man $(ls /usr/bin | shuf -n 1) | sed -n "/^NAME/ {n;p;q}"
    fi
elif [[ $rand -lt 100 ]]; then 
    if [ -d /usr/share/cows ]; then
        path='/usr/share/cows/'
        cowcount=$(ls -1 /usr/share/cows/ | wc -l)
        cownumber=$(($RANDOM % $cowcount +1))
        cow=$(ls -1 /usr/share/cows/| sed -n "{ $cownumber p}")
        cowsay -f $path$cow $(fortune -s)
    else
        fortune -s
    fi
else 
    fortune ascii-art
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
export HISTIGNORE="history:&:clear:cd*:exit"

# resize history size
export HISTSIZE=5000

# display history command with date and time
export HISTTIMEFORMAT="%Y-%m-%d %T "

################################################################################
# based on ZORK Theme of bash-it
################################################################################
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" \[\033[1;31m\]✗\[\033[0m\]"
SCM_THEME_PROMPT_CLEAN=" \[\033[1;32m\]✓\[\033[0m\]"
SCM_GIT='git'
SCM_GIT_CHAR="\[\033[1;32m\]±\[\033[0m\]"
SCM_NONE='NONE'
SCM_NONE_CHAR='○'

function scm_prompt_vars {
  SCM_DIRTY=0
  SCM_STATE=''
  [[ $SCM == $SCM_GIT ]] && git_prompt_vars && return
  echo -e "$SCM_BRANCH\[\033[01;32m\]$SCM_STATE\[\033[0m\]"
}

function git_prompt_vars {
  SCM_GIT_AHEAD=''
  SCM_GIT_BEHIND=''
  SCM_GIT_STASH=''
  local status="$(git status -bs --porcelain 2> /dev/null)"
  if [[ -n "$(grep -v ^# <<< "${status}")" ]]; then
    SCM_DIRTY=1
    SCM_STATE=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
  else
    SCM_DIRTY=0
    SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
  fi
  SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
  SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  SCM_BRANCH=${ref#refs/heads/}
  SCM_CHANGE=$(git rev-parse HEAD 2>/dev/null)
  local ahead_re='.+ahead ([0-9]+).+'
  local behind_re='.+behind ([0-9]+).+'
  [[ "${status}" =~ ${ahead_re} ]] && SCM_GIT_AHEAD=" ${SCM_GIT_AHEAD_CHAR}${BASH_REMATCH[1]}"
  [[ "${status}" =~ ${behind_re} ]] && SCM_GIT_BEHIND=" ${SCM_GIT_BEHIND_CHAR}${BASH_REMATCH[1]}"
  local stash_count="$(git stash list | wc -l | tr -d ' ')"
  [[ "${stash_count}" -gt 0 ]] && SCM_GIT_STASH=" {${stash_count}}"
}

function scm_char {
  if [[ -z $SCM ]]; then scm; fi
  if [[ $SCM == $SCM_GIT ]]; then SCM_CHAR=$SCM_GIT_CHAR
  else SCM_CHAR=$SCM_NONE_CHAR
  fi
  echo -e "$SCM_CHAR"
}

function scm {
  if [[ -f .git/HEAD ]]; then SCM=$SCM_GIT
  elif [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]]; then SCM=$SCM_GIT
  elif [[ -d .hg ]]; then SCM=$SCM_HG
  elif [[ -n "$(hg root 2> /dev/null)" ]]; then SCM=$SCM_HG
  elif [[ -d .svn ]]; then SCM=$SCM_SVN
  else SCM=$SCM_NONE
  fi
}

modern_scm_prompt() {
	    scm
        CHAR=$(scm_char)
        if [ $CHAR = $SCM_NONE_CHAR ];
        then
                return
        else
                echo "[$(scm_char)][$(scm_prompt_vars)]"
        fi
}

prompt() {

    my_ps_host="\[\033[00;32m\]\h\[\033[00m\]";
    my_ps_user="\[\033[01;32m\]\u\[\033[00m\]";
    my_ps_root="\[\033[01;31m\]\u\[\033[00m\]";
    my_ps_path="\[\033[00;36m\]\w\[\033[00m\]";

    # nice prompt
    case "`id -u`" in
        0) PS1="[$my_ps_root][$my_ps_host]$(modern_scm_prompt)[$my_ps_path]
# "
        PS2="# "
        ;;
        *) PS1="[$my_ps_user][$my_ps_host]$(modern_scm_prompt)[$my_ps_path]
$ "
        PS2="$ "
        ;;
    esac
}

# Default PS1
# PS1='[\u@\h \W]\$ '
PS3=">> "

PROMPT_COMMAND=prompt
