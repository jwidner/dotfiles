if status is-interactive
    fish_add_path "$HOME/bin"
    # Less/man settings
    set -x LESS "$LESS -M"
    set -x MANPAGER 'less +Gg'
    set -x PAGER 'less +Gg -R'
    set -x GROFF_NO_SGR 1

    # Less colors
    set -x LESS_TERMCAP_mb (set_color --bold brred)
    set -x LESS_TERMCAP_md (set_color --bold brred)
    set -x LESS_TERMCAP_me (set_color normal)
    set -x LESS_TERMCAP_se (set_color normal)
    set -x LESS_TERMCAP_so (set_color --bold --background blue bryellow)
    set -x LESS_TERMCAP_ue (set_color normal)
    set -x LESS_TERMCAP_us (set_color --bold brgreen)
end
