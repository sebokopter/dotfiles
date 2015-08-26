#!/bin/bash

################################################################################
#
# install.sh
#
# Create directory structure for dotfiles and inserts the corresponding
# dotfiles as symlinks.
# Existing directories are going to be reused and existing files are backuped
# with ".backup" suffix.
#
# usage: $path_to_dotfiles_repo/install.sh
#
################################################################################

# assuming this script is in the dotfiles directory
readonly DOTFILES_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

make_backup() {
  local source="$1"
  local destination="$1.backup"
  if [[ -e $source ]]; then
    mv -f $source $destination
  fi
}
get_destination_path() {
  local src_path=$1
  echo "${HOME}/${src_path#$DOTFILES_DIR/*/}"
}
create_file_symlink() {
  local src_file=$1
  local dest_file=$(get_destination_path $src_file)
  make_backup $dest_file
  ln -sf $src_file $dest_file
}

get_all_dotfile_dirs() {
  echo "$( find $DOTFILES_DIR -mindepth 1 -maxdepth 1 ! -name ".git*" -type d )"
}

get_all_confignodes() {
  local dir=$1
  echo "$( find $dir -mindepth 1 -maxdepth 1 -type f -o -type d )"
}

create_destination_dir() {
  local src_dir=$1
  local dest_dir=$(get_destination_path $src_dir)
  if [[ ! -d dest_dir ]]; then
    mkdir -p $dest_dir
  fi
}

create_all_symlinks() {
  local dir=$1
  for confignode in $(get_all_confignodes $dir); do
    if [[ -d $confignode ]]; then
      create_destination_dir $confignode
      create_all_symlinks $confignode
    else
      create_file_symlink $confignode
    fi
  done
}

for dotfile_dir in $(get_all_dotfile_dirs); do 
  create_all_symlinks $dotfile_dir
done
