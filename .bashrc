#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
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

export BROWSER='firefox'

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

PS1='[\[$red\]\u\[$reset\]@\[$green\]\h \[$blue\]\W\[$reset\]]> '
stty -ixon

[ -f /usr/share/fzf/shell/key-bindings.bash ] && . /usr/share/fzf/shell/key-bindings.bash
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

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
    if [ "$#" = "0" ]; then
        tail "$NOTES_FILE"
    elif [ "$1" = "edit" ]; then
        $EDITOR "$NOTES_FILE"
    else 
        echo "$(date --iso-8601=seconds) >>" "$@" >>"$NOTES_FILE"
    fi
}

# TODO: abstract the note() and todo() functions
export TODO_FILE="$HOME/.todo"
[ ! -e "TODO_FILE" ] && touch "$TODO_FILE"
todo () {
    if [ "$#" = "0" ]; then
        tail "$TODO_FILE"
    elif [ "$1" = "edit" ]; then
        $EDITOR "$TODO_FILE"
    else
        echo "$(date --iso-8601=seconds) >>" "$@" >>"$TODO_FILE"
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
if [ "$(uname)" = 'Linux' ]; then
    alias open='xdg-open'
fi
alias hist='command history'
alias diff='command diff --color'
alias cv='config vim'
alias cs='config bash'
alias rot13="tr 'a-zA-Z' 'n-za-mN-ZA-M'"
alias resource=". $HOME/.bashrc"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"