# Summary

1. `./setup.sh`
2. `stow .`

# Manual Setup

## Git

Create `~/.gitconfig.local` and add:

```
[user]
    email = "<EMAIL>"
```

## fugitive-gitlab.vim

Create `~/.vim/plugin/fugitive-gitlab.vim` and add:

```
let g:fugitive_gitlab_domains = ['https://my.gitlab.com']
```
