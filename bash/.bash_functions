# r() is used to refresh ssh agent in tmux 
# http://justinchouinard.com/blog/2010/04/10/fix-stale-ssh-environment-variables-in-gnu-screen-and-tmux/                                                                                                                                                                                         
function r() {   
  if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=`tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2`
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then 
      SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK  
    fi
  fi
}

function cd() {
  if [ -z "$1" ]; then
    command cd
  else
    command cd "$1"
  fi
  ls -AF
}

function get_most_used_commands() {
  history | awk '{$1=$2=$3=""; CMD[$0]++; count++} END { for (i in CMD) printf "%03d  %2.2f%% %s\n", CMD[i], CMD[i]/count*100, i;}' | sort -nr | head -n20
}

function mailq() {
    if [ -e /usr/sbin/postqueue ]; then
        /usr/sbin/postqueue -p
    else 
        $(which mailq)
    fi  
}
