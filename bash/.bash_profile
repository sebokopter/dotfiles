#
# ~/.bash_profile
#

# MacOS bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

[[ -f ~/.bashrc ]] && source ~/.bashrc

## Jenv
eval "$(jenv init -)"


## perlbrew
[[ -f ~/perl5/perlbrew/etc/bashrc ]] && source ~/perl5/perlbrew/etc/bashrc
