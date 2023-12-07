#!/bin/zsh

link_file() {
  local name=~/.$1
  if [[ -e $name || -h $name ]] {
    rm $name
  }
  ln -s $(pwd)/$1 $name
}

link_file zimrc
link_file zshrc

if [[ -z $MC_PATH ]] {
  cd ..
  echo "export MC_PATH=$(pwd)" >> ~/.zshenv
}
