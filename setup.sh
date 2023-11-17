#!/bin/sh
set -eu
SCRIPT_DIR="${HOME}/dotfiles"

# Vim setup
mkdir -p \
    "${HOME}/.vim/swap" \
    "${HOME}/.vim/undo" \
    "${HOME}/.vim/backup"
find "${HOME}/.vim" -type d -exec chmod 700 '{}' \;
cp "${SCRIPT_DIR}/.vimrc" "${HOME}/.vimrc"

# vim plugins
PLUGIN_DIR="${HOME}/.vim/pack"

# vim-commentary
mkdir -p "${PLUGIN_DIR}/tpope/start"
if [ ! -e "${PLUGIN_DIR}/tpope/start/commentary" ]; then
    git clone 'https://tpope.io/vim/commentary.git' "${PLUGIN_DIR}/tpope/start/commentary"
else
    echo >&2 "INFO: updating existing vim-commentary..."
    cd "${PLUGIN_DIR}/tpope/start/commentary"
    git pull --ff-only
fi
vim -u NONE -c "helptags ${PLUGIN_DIR}/tpope/start/commentary/doc" -c q

# vim-fugitive
mkdir -p "${PLUGIN_DIR}/tpope/start"
if [ ! -e "${PLUGIN_DIR}/tpope/start/fugitive" ]; then
    git clone 'https://tpope.io/vim/fugitive.git' "${PLUGIN_DIR}/tpope/start/fugitive"
else
    echo >&2 "INFO: updating existing vim-fugitive..."
    cd "${PLUGIN_DIR}/tpope/start/fugitive"
    git pull --ff-only
fi
vim -u NONE -c "helptags ${PLUGIN_DIR}/tpope/start/fugitive/doc" -c q

# vim-fzf
mkdir -p "${PLUGIN_DIR}/packages/start"
if [ ! -e "${PLUGIN_DIR}/packages/start/fzf" ]; then
    git clone 'https://github.com/junegunn/fzf.git' "${PLUGIN_DIR}/packages/start/fzf"
else
    echo >&2 "INFO: updating existing fzf..."
    cd "${PLUGIN_DIR}/packages/start/fzf"
    git pull --ff-only
fi
if [ ! -e "${PLUGIN_DIR}/packages/start/fzf.vim" ]; then
    git clone 'https://github.com/junegunn/fzf.vim.git' "${PLUGIN_DIR}/packages/start/fzf.vim"
else
    echo >&2 "INFO: updating existing fzf.vim..."
    cd "${PLUGIN_DIR}/packages/start/fzf.vim"
    git pull --ff-only
fi

# gruvbox
mkdir -p "${PLUGIN_DIR}/default/start"
if [ ! -e "${PLUGIN_DIR}/default/start/gruvbox" ]; then
    git clone https://github.com/morhetz/gruvbox.git "${PLUGIN_DIR}/default/start/gruvbox"
else
    echo >&2 "INFO: updating existing gruvbox..."
    cd "${PLUGIN_DIR}/default/start/gruvbox"
    git pull --ff-only
fi

# tmux setup
cp "${SCRIPT_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
TMUX_DIR="${HOME}/.tmux"
mkdir -p "${TMUX_DIR}"
if [ ! -e "${TMUX_DIR}/tmux-resurrect" ]; then
    git clone https://github.com/tmux-plugins/tmux-resurrect "${TMUX_DIR}/tmux-resurrect"
else
    echo >&2 "INFO: updating existing tmux-resurrect..."
    cd "${TMUX_DIR}/tmux-resurrect"
    git pull --ff-only
fi

# bash setup
cp "${SCRIPT_DIR}/.bashrc" "${HOME}/.bashrc"
cp "${SCRIPT_DIR}/.bash_profile" "${HOME}/.bash_profile"

# Git setup
cp "${SCRIPT_DIR}/.gitconfig" "${HOME}/.gitconfig"
GLOBAL_GIT_CONFIG="${HOME}/.config/git"
mkdir -p "${GLOBAL_GIT_CONFIG}"
cp "${SCRIPT_DIR}/ignore" "${GLOBAL_GIT_CONFIG}/ignore"

# local scripts
mkdir -p "${HOME}/.local/bin"
cp "${SCRIPT_DIR}/.local/bin"/* "${HOME}/.local/bin"
