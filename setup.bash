#!/usr/bin/env bash

targets=(
    .zshrc
    .yabairc
    .skhdrc
    .gitmessage.txt
    .gitconfig
    .zshrc.d
    .wezterm.lua
    .config/nvim
    .config/tmux
)
prefix=~/dotfiles

for target in "${targets[@]}"; do
    ln -s $prefix/$target ~/$target 2>/dev/null && echo Symlink ~/$target added || echo Symlink ~/$target already exist
done

