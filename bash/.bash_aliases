################################################################################
# Aptitude
################################################################################

# use sudo by default if it's installed and not run as root
if [[ "$UID" -ne 0 && -e $( which sudo ) ]]; then
  use_sudo=1
fi

# search with some additional version information
alias as='aptitude -F "%c%a%M %p %d %Z %v %V" search'
# AFAIK there exists no aptitude replace right now
alias ap='apt-cache policy'

# apt-file
alias afs='apt-file search --regexp'

if [[ -x $(which deborphan 2>/dev/null) ]]; then
    use_deborphan=1
fi	

# commands using sudo
if [[ $use_sudo -eq 1 ]]; then
    alias at='aptitude'
    alias aac='sudo aptitude autoclean'
    alias abd='sudo aptitude build-dep'
    alias ac='sudo aptitude clean'
    alias au='sudo aptitude update'
    alias ag='sudo aptitude safe-upgrade'
    alias aug='sudo aptitude update && sudo aptitude safe-upgrade'
    alias ad='sudo aptitude full-upgrade'
    alias aud='sudo aptitude update && sudo aptitude full-upgrade'
    alias ai='sudo aptitude install'
    alias ap='sudo aptitude purge'
    alias ar='sudo aptitude remove'

    alias afu='sudo apt-file update'

	if [[ $use_deborphan -eq 1 ]]; then
	    alias dop='deborphan | xargs sudo aptitude purge -y'
	fi

    # Install all .deb files in the current directory.
    alias di='sudo dpkg -i ./*.deb'

    # Remove ALL kernel images and headers EXCEPT the one in use
    alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) 
        ?not(~n`uname -r`))'

# commands using su
else
    alias at='su -lc \'aptitude\' root'
    alias aac='su -lc \'aptitude autoclean\' root'
    alias abd='su -lc \'aptitude build-dep\' root'
    alias ac='su -lc \'aptitude clean\' root'
    alias au='su -lc \'aptitude update\' root'
    alias ag='su -lc \'aptitude safe-upgrade\' root'
    alias aug='su -lc \'aptitude update && aptitude safe-upgrade\' root'
    alias ad='su -lc \'aptitude full-upgrade\' root'
    alias aud='su -lc \'aptitude update && aptitude full-upgrade\' root'
    ai() {
        cmd="su -lc 'aptitude -P install $@' root"
        print "$cmd"
        eval "$cmd"
    }
    ap() {
        cmd="su -lc 'aptitude -P purge $@' root"
        print "$cmd"
        eval "$cmd"
    }
    ar() {
        cmd="su -lc 'aptitude -P remove $@' root"
        print "$cmd"
        eval "$cmd"
    }

    alias afu='su -lc \' apt-file update\' root'

	if [[ $use_deborphan -eq 1 ]]; then
	    alias dop='deborphan | su -lc \'xargs aptitude purge -y\' root'
	fi

    # Install all .deb files in the current directory.
    alias di='su -lc \'dpkg -i ./*.deb\' root'

    # Remove ALL kernel images and headers EXCEPT the one in use
    alias kclean='su -lc '\''aptitude remove -P ?and(~i~nlinux-(ima|hea) \
        ?not(~n`uname -r`))'\'' root'
fi

# Function: Print apt history
# Usage:
#   apt-history install
#   apt-history upgrade
#   apt-history remove
#   apt-history rollback
#   apt-history list
# Based On: http://linuxcommando.blogspot.com/2008/08/how-to-show-apt-log-history.html
apt-history () {
  case "$1" in
    install)
      zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*)
      ;;
    upgrade|remove)
      zgrep --no-filename $1 $(ls -rt /var/log/dpkg*)
      ;;
    rollback)
      zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}'
      ;;
    list)
      zcat $(ls -rt /var/log/dpkg*)
      ;;
    *)
      echo "Parameters:"
      echo " install - Lists all packages that have been installed."
      echo " upgrade - Lists all packages that have been upgraded."
      echo " remove - Lists all packages that have been removed."
      echo " rollback - Lists rollback information."
      echo " list - Lists all contains of dpkg logs."
      ;;
  esac
}

################################################################################
# Pacman
################################################################################

# search 
alias pacs='pacman -Ss'
# local info
alias pacli='pacman -Qi'
# remote info
alias pacri='pacman -Si'
# which package owns/contains $file?
alias paco='pacman -Qo'
# list all file from a package
alias pacl='pacman -Ql'
# list packages which aren't required anymore
alias pacorph='pacman -Qtd'
# list apckages which are currently installed
alias pacli='pacman -Qe'
# commands using sudo
if [[ $use_sudo -eq 1 ]]; then
    # clean 
    alias pacc='sudo pacman -Sc'
    # refresh
    alias pacr='sudo pacman -Syy'
    # upgrade
    alias pacud='sudo pacman -Suyy'
    # install
    alias paci='sudo pacman -S'
    # remove
    # TODO

# commands using su
else
    # clean 
    alias pacc='su -lc pacman -Sc'
    # refresh
    alias pacr='su -lc pacman -Syy'
    # upgrade
    alias pacud='su -lc pacman -Suyy'
    # install
    alias paci='su -lc pacman -S'
    # remove
    # TODO
fi

################################################################################
# Emacs
################################################################################

alias em='emacs'
alias e='emacsclient -n'

################################################################################
# General
################################################################################
# List directory contents
alias sl=ls
alias ls="ls --color=auto"
# -A: don't show . or ..; -F show indicator at end of filename
alias la='ls -AF'
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

# sudo alias
alias _="sudo"
# checks aliases with sudo
alias sudo='sudo '

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up two directories
alias -- -='cd -'        # Go back

# Shell History
alias h='history'

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# Directory
alias md='mkdir -p'
alias rd='rmdir'

alias rr='rm -r'  

################################################################################
# Git
################################################################################

alias gcl='git clone'
alias ga='git add'
alias gall='git add .'
alias g='git'
alias get='git'
alias gst='git status'
alias gs='git status'
alias gss='git status -s'
alias gl='git pull'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit --color'
alias gd='git diff'

################################################################################
# SSH
################################################################################

alias sshkr="ssh-keygen -f ~/.ssh/known_hosts -R" 
