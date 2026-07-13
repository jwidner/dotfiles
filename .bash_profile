# webkitgtk is broken w/ foliate
# use workaround from: https://github.com/johnfactotum/foliate/issues/1093
export WEBKIT_DISABLE_DMABUF_RENDERER=1
. "$HOME/.bashrc"
