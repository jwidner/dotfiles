# Summary

`./setup.sh`

# Manual Setup

## Git

### Local Configuration

Create `~/.gitconfig.local` and add:

```
[user]
    email = "<EMAIL>"
```

### diff-highlight

`diff-highlight` must be added to $PATH. It is shipped with `git`, but
different distros package this plugin differently.

Fedora:

`rpm -ql git | grep diff-highlight`

Debian:

`dpkg -L git | grep diff-highlight`

## fugitive-gitlab.vim

Create `~/.vim/plugin/fugitive-gitlab.vim` and add:

```
let g:fugitive_gitlab_domains = ['https://my.gitlab.com']
```
