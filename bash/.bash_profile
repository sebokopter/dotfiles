#
# ~/.bash_profile
#

# MacOS bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

[[ -f ~/.bashrc ]] && . ~/.bashrc

eval "$(jenv init -)"
