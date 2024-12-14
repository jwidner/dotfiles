#!/bin/sh
set -eu
dir=$(dirname "$0")

( cd "${dir}"; git submodule update --init )

stow \
    -d "${dir}/common" \
    -t "${HOME}" \
    .

case "$(uname)" in
    Linux)
        stow \
            -d "${dir}/linux" \
            -t "${HOME}" \
            .
        ;;
    Darwin)
        stow \
            -d "${dir}/macos" \
            -t "${HOME}" \
            .
        ;;
    *)
        echo >&2 "$0: unsupported OS: $(uname)"
        ;;
esac

# Vim setup
for vim_dir in \
    "${HOME}/.vim/swap" \
    "${HOME}/.vim/undo" \
    "${HOME}/.vim/backup";
do
    mkdir -p "${vim_dir}"
    chmod 700 "${vim_dir}"
done

# setup vim fzf
vim -c 'call fzf#install()' -c q

# setup vim plugin docs
find -H "${HOME}/.vim/pack/default/start" \
    -type d \
    -name 'doc' \
    -exec vim -u NONE -c 'helptags {}' -c q \;
