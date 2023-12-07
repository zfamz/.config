#!/bin/zsh

link_file() {
  local name=~/.$1
  if [[ -e $name || -h $name ]] {
    rm $name
  }
  ln -s $(pwd)/$1 $name
}
