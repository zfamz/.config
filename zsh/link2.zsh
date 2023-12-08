#!/bin/zsh

source ../utils/lib.zsh

link_file zimrc
link_file zshrc

if [[ $MC_PATH != $(pwd) ]] {
  cd ..
  echo "export MC_PATH=$(pwd)" >> ~/.zshenv
}
