#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ "$(uname)" = 'Linux' ]; then
    open() { xdg-open "${@}"; }
    export -f open
    export BROWSER='firefox'
elif [ "$(uname)" = 'Darwin' ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$PATH:/opt/homebrew/opt/coreutils/libexec/gnubin"
    # replace BSD sed with GNU sed
    export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
    # python -> python3, pip -> pip3, etc.
    export PATH="/opt/homebrew/opt/python3/libexec/bin:$PATH"
    export BROWSER='open -a firefox'
    GIT_COMPLETION_PATH="/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"
    if [ -f "${GIT_COMPLETION_PATH}" ]; then
        . "${GIT_COMPLETION_PATH}"
    else
        echo >&2 "WARN: git completion script is missing"
    fi
fi

# Define some colors
red=$(tput setaf 196)
green=$(tput setaf 2)
blue=$(tput setaf 12)
reset=$(tput sgr0)

# Ignore repeated commands in command history
export HISTCONTROL=ignoreboth
export HISTSIZE=unlimited
export HISTFILESIZE=unlimited
# timestamp history
HISTTIMEFORMAT="%FT%T%z "

shopt -s histappend

# vim setup
if command -v vimx >/dev/null; then
    export EDITOR=vimx  # vimx for clipboard support on Linux
    export VISUAL=vimx
else
    export EDITOR=vim
    export VISUAL=vim
fi
alias v="command $EDITOR"
alias vim="command $EDITOR"

# less/man settings
export LESS+='-M'
export MANPAGER='less +Gg'
export PAGER='less +Gg -R'
export GROFF_NO_SGR=1

# Color setup for ls
eval $(dircolors -b)
ls_options="--color=auto -v"

# Setup ls/la/ll/lh/l
if [[ "$TERM" != dumb ]]; then
    alias ls="command ls ${ls_options:+${ls_options[*]}}"
    alias la="command ls -la ${ls_options:+${ls_options[*]}}"
    alias ll="command ls -l ${ls_options:+${ls_options[*]}}"
    alias lh="command ls -hAl ${ls_options:+${ls_options[*]}}"
    alias l="command ls -l ${ls_options:+${ls_options[*]}}"
else
    alias la='command ls -la'
    alias ll='command ls -l'
    alias lh='command ls -hAl'
    alias l='command ls -l'
fi

# Color setup for grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

# Less colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

PS1='[\[$red\]\u\[$reset\]@\[$green\]\h \[$blue\]\W\[$reset\]]\$ '
stty -ixon

[ -f /usr/share/fzf/shell/key-bindings.bash ] && . /usr/share/fzf/shell/key-bindings.bash
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
export FZF_DEFAULT_COMMAND="find . -type f ! -path '*/.git/*'"

# setup golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH="$PATH:$GOBIN"

# setup zig
export PATH="$PATH:$HOME/zig"

# setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# home/bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# notes setup
export NOTES_FILE="$HOME/.notes"
[ ! -e "$NOTES_FILE" ] && touch "$NOTES_FILE"
# I would rather add notes by opening the notes file in vim, appending a
# newline, adding the data and >> and spaces and going into insert mode
# this seems to me to be the best solution. It's better (to me) than writing my
# notes in the shell itself.
note () {
    _note_file "${NOTES_FILE}" "${@}"
}

export TODO_FILE="$HOME/.todo"
[ ! -e "TODO_FILE" ] && touch "$TODO_FILE"
todo () {
    _note_file "${TODO_FILE}" "${@}"
}

# Abstracts functionality for viewing, editing, & appending to a notes file
# Usage: _note_file FILE "$@"
_note_file () {
    local FILE="$1"
    shift
    if [ "$#" = "0" ]; then
        tail "$FILE"
    elif [ "$1" = "edit" ]; then
        "$EDITOR" "$FILE"
    else
        echo "$(date -Iseconds) >>" "$@" >>"$FILE"
    fi
}


JOURNAL_FILE="$HOME/.journal"
[ ! -e "$JOURNAL_FILE" ] && touch "$JOURNAL_FILE"
journal () {
    $EDITOR "$JOURNAL_FILE"
}

# background noise using SoX
# see also https://mynoise.net/
alias brownnoise='play -q -n synth brownnoise synth pinknoise mix synth sine amod 0.3 10 & disown'
alias whitenoise='play -q -c 2 -n synth brownnoise band -n 1600 1500 tremolo .1 30 & disown'
alias pinknoise='play -q -t sl -r48000 -c2 -n synth -1 pinknoise .1 80 & disown'
alias stopnoise='kill -9 $(pgrep play)'

# man () {
#     if getopts '-headers'; then
#         echo 'requested headers'
#     fi
#     command man "$@"
# }

# TODO: open the argument in $EDITOR if it is in the $PATH and a text file
edit () {
    $EDITOR "$@"
}

manheaders () {
    man "$@" 2>/dev/null | command grep -E '^\S'
}

# TODO:
# 1. Figure out which manual section the page is in (if any)
# 2. Do caching
manbsd() {
    curl "https://man.openbsd.org/$1" | pandoc --from html --to plain | $PAGER
}

if command -v wl-copy >/dev/null; then
    alias copy='command wl-copy'
elif command -v pbcopy >/dev/null; then
    alias copy='command pbcopy'
fi

DOT_FILES="$HOME/dotfiles"
config () {
    if [ "$1" = "vim" ]; then
        $EDITOR "$DOT_FILES/.vimrc"
    elif [ "$1" = "bash" ]; then
        $EDITOR "$DOT_FILES/.bashrc"
    fi
}
alias xargs='command xargs '
alias hist='command history'
alias diff='command diff --color'
alias cv='config vim'
alias cs='config bash'
alias rot13="tr 'a-zA-Z' 'n-za-mN-ZA-M'"
alias resource=". $HOME/.bashrc"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
