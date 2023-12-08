#!/bin/zsh

local target=~/.config/gitui
if [[ -e $target ]] {
	rm $target
}
ln -s $(pwd) $target
