function ctrlv --wraps='xclip -selection c -o' --description 'alias ctrlv xclip -selection c -o'
  xclip -selection c -o $argv; 
end
