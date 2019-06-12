for conf in $HOME/.zshrc.d/*; do
  if [[ -e "$conf" ]]; then
      source $conf
  fi
done

export PATH="$PATH:/usr/local/sbin:/usr/libexec"
