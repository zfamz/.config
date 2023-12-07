#!/bin/zsh

source ../utils/index.zsh

link_file zimrc
link_file zshrc

if [[ -z $MC_PATH ]] {
  cd ..
  echo "export MC_PATH=$(pwd)" >> ~/.zshenv
}
