#!/usr/bin/env bash

for dir in $( find -mindepth 1 -maxdepth 1 ! -name ".git*" -type d ); do 
    for dotfile in $(find $dir -mindepth 1 -maxdepth 1 ); do
        src=$(pwd)/$(basename $dir)/$(basename $dotfile)
        dst=$HOME/$(basename $dotfile) 
        if [[ -e $dst ]]; then
            mv -f $dst $dst.backup
        fi
        ln -sf $src $dst
    done
done
