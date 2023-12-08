#!/bin/zsh

source ../utils/lib.zsh

local target=~/.config/nvim

if [[ -e $target && ! -h $target ]] {
  mv $target "$target.$(date '+%Y-%m-%d_%H:%M:%S').bak"
}

link_dir $target
