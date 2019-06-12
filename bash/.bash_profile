#
# ~/.bash_profile
#

# MacOS bash completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

eval "$(jenv init -)"
