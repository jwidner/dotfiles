#!/bin/bash
set -euo pipefail
SCRIPT_DIR=""  # TODO

# Vim setup
# TODO: 0. setup the dirs
# TODO: 1. move the config files
cp "SCRIPT_DIR/.vimrc"
# TODO: 2. clone the plugins

# TODO: Neovim setup

# TODO: bash setup

. "$HOME/.bashrc"

# Git setup
GLOBAL_GIT_CONFIG="$HOME/.config/git"
mkdir -p "$GLOBAL_GIT_CONFIG"
# TODO: add global git ignore file and use instead of below
echo '/tags' >"$GLOBAL_GIT_CONFIG/ignore"
