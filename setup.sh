#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$HOME/dotfiles"

# Vim setup
mkdir -p \
    "$HOME/.vim/swap" \
    "$HOME/.vim/undo" \
    "$HOME/.vim/backup"
find "$HOME/.vim" -type d -exec chmod 700 '{}' \;
cp "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
# plugins
PLUGIN_DIR="$HOME/.vim/pack"
# vim-commentary
mkdir -p "$PLUGIN_DIR/tpope/start"
git clone https://tpope.io/vim/commentary.git "$PLUGIN_DIR/tpope/start/commentary"
vim -u NONE -c "helptags $PLUGIN_DIR/tpope/start/commentary/doc" -c q
# vim-fugitive
git clone https://tpope.io/vim/fugitive.git "$PLUGIN_DIR/tpope/start/fugitive"
vim -u NONE -c "helptags $PLUGIN_DIR/tpope/start/fugitive/doc" -c q

# tmux setup
cp "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
TMUX_DIR="$HOME/.tmux"
mkdir -p "$TMUX_DIR/tmux-resurrect"
git clone https://github.com/tmux-plugins/tmux-resurrect "$TMUX_DIR/tmux-resurrect"

# bash setup
cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
. "$HOME/.bashrc"

# Git setup
cp "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
GLOBAL_GIT_CONFIG="$HOME/.config/git"
mkdir -p "$GLOBAL_GIT_CONFIG"
# TODO: add global git ignore file and use instead of below
echo '/tags' >"$GLOBAL_GIT_CONFIG/ignore"
