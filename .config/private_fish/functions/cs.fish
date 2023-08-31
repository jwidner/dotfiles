function cs --wraps='$EDITOR $HOME/.config/fish/config.fish' --description 'alias cs $EDITOR $HOME/.config/fish/config.fish'
  $EDITOR $HOME/.config/fish/config.fish $argv; 
end
