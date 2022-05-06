function ctrlc --wraps='xclip -selection c' --description 'alias ctrlc xclip -selection c'
  xclip -selection c $argv; 
end
