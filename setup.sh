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
PLUGIN_BASEDIR="${HOME}/.vim/pack/default/start"

for PLUGIN in \
    "https://tpope.io/vim/commentary.git" \
    "https://tpope.io/vim/fugitive.git" \
    "https://github.com/junegunn/fzf.git" \
    "https://github.com/junegunn/fzf.vim.git" \
    "https://github.com/morhetz/gruvbox.git"
do
    PLUGIN_NAME="${PLUGIN##*/}"
    PLUGIN_NAME="${PLUGIN_NAME%.git}"
    PLUGIN_DIR="${PLUGIN_BASEDIR}/${PLUGIN_NAME}"
    if ! git clone \
        "${PLUGIN}" \
        --depth=1 \
        "${PLUGIN_DIR}"
    then
        cd "${PLUGIN_DIR}"
        git pull --ff-only --depth=1
    fi
    vim -u NONE -c "helptags ${PLUGIN_DIR}/doc" -c q
done

# coc.nvim
PLUGIN_DIR="${PLUGIN_BASEDIR}/coc"
if ! git clone \
    --branch release \
    https://github.com/neoclide/coc.nvim.git \
    --depth=1 \
    "${PLUGIN_DIR}"
then
    cd "${PLUGIN_DIR}"
    git pull --ff-only --depth=1
fi
vim -u NONE -c "helptags ${PLUGIN_DIR}/doc" -c q

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
