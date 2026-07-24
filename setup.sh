#!/bin/sh
set -eu
dir=$(dirname "$0")

( cd "${dir}"; git submodule update --init )

stow \
    -d "${dir}" \
    -t "${HOME}" \
    .

# Vim setup
for vim_dir in \
    "${HOME}/.vim/swap" \
    "${HOME}/.vim/undo" \
    "${HOME}/.vim/backup";
do
    mkdir -p "${vim_dir}"
    chmod 700 "${vim_dir}"
done

# Set up vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c 'PlugInstall' -c qa
