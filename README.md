# Summary

1. `git submodule update --init`
2. `./setup.sh`
3. `stow .`

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
