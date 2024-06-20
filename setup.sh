#!/bin/sh
set -eu
dir=$(dirname "$0")

( cd "$dir"; git submodule update --init )

# Vim setup
vim_dirs="\
${HOME}/.vim/swap \
${HOME}/.vim/undo \
${HOME}/.vim/backup \
"
mkdir -p "${vim_dirs}"
chmod 700 "${vim_dirs}"

# setup vim plugin docs
find -H "${HOME}/.vim/pack/default/start" \
    -type d \
    -name 'doc' \
    -exec vim -u NONE -c 'helptags {}' -c q \;
