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
if [ ! -e "$PLUGIN_DIR/tpope/start/commentary" ]; then
    git clone https://tpope.io/vim/commentary.git "$PLUGIN_DIR/tpope/start/commentary"
else
    echo "INFO: skipping vim-commentary because it already exists..."
fi
vim -u NONE -c "helptags $PLUGIN_DIR/tpope/start/commentary/doc" -c q
# vim-fugitive
mkdir -p "$PLUGIN_DIR/tpope/start"
if [ ! -e "$PLUGIN_DIR/tpope/start/fugitive" ]; then
    git clone https://tpope.io/vim/fugitive.git "$PLUGIN_DIR/tpope/start/fugitive"
else
    echo "INFO: skipping vim-fugitive because it already exists..."
fi
vim -u NONE -c "helptags $PLUGIN_DIR/tpope/start/fugitive/doc" -c q
# gruvbox
mkdir -p "$PLUGIN_DIR/default/start"
if [ ! -e "$PLUGIN_DIR/default/start/gruvbox" ]; then
    git clone https://github.com/morhetz/gruvbox.git "$PLUGIN_DIR/default/start/gruvbox"
else
    echo "INFO: skipping gruvbox because it already exists..."
fi

# tmux setup
cp "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
TMUX_DIR="$HOME/.tmux"
mkdir -p "$TMUX_DIR"
if [ ! -e "$TMUX_DIR/tmux-resurrect" ]; then
    git clone https://github.com/tmux-plugins/tmux-resurrect "$TMUX_DIR/tmux-resurrect"
else
    echo "INFO: skipping tmux-resurrect because it already exists..."
fi

# bash setup
cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
. "$HOME/.bashrc"

# Git setup
cp "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
GLOBAL_GIT_CONFIG="$HOME/.config/git"
mkdir -p "$GLOBAL_GIT_CONFIG"
# TODO: add global git ignore file and use instead of below
echo '/tags' >"$GLOBAL_GIT_CONFIG/ignore"

# local scripts
mkdir -p "$HOME/.local/bin"
cp "$SCRIPT_DIR/.local/bin"/* "$HOME/.local/bin"
