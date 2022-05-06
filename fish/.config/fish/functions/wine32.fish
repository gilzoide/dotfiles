function wine32 --wraps='env WINEPREFIX=~/.wine32 WINEARCH=win32 wine' --description 'alias wine32 env WINEPREFIX=~/.wine32 WINEARCH=win32 wine'
  env WINEPREFIX=~/.wine32 WINEARCH=win32 wine $argv; 
end
