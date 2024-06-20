#!/bin/sh
set -eu
dir=$(dirname "$0")

( cd "${dir}"; git submodule update --init )

if ! stow \
    -d "${dir}" \
    -t "${HOME}" \
    .
then
    echo >&2 "if stow conflicts, try \`stow --adopt .\`"
    exit 1
fi

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
