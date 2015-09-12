#!/bin/bash

install_dir() {
    dir=~/."$1"
    if [[ ! -e $dir ]]; then
        mkdir -p "$dir"
    fi
}

install_file() {
    file=~/."$1"
    if [[ ! -e $file ]]; then
        [[ -L $file ]] && rm "$file"
        ln -s "$(pwd)/$1" "$file"
    fi
}

cd myhome
find -type d | while read d; do
    [[ $d = ./scripts* ]] && continue
    [[ $d = . ]] && continue
    install_dir "${d#./}"
done
find -type f | while read f; do
    [[ $f = ./scripts* ]] && continue
    install_file "${f#./}"
done
install_file scripts

test -d ~/.vim/bundle/vundle || git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
