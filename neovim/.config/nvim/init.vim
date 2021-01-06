set mouse=a
set number
set relativenumber
set hidden

set expandtab
set tabstop=2
set shiftwidth=2

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'cespare/vim-toml'
Plug 'editorconfig/editorconfig-vim'
Plug 'Olical/vim-enmasse'
Plug 'frazrepo/vim-rainbow'
Plug 'igankevich/mesonic'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/loremipsum'
Plug 'michaeljsmith/vim-indent-object'
call plug#end()

nmap <F8> :Ex<CR>
nmap <C-F8> :Vex<CR>
xmap * "vy/\<<C-R>v\><CR>
xmap g* "vy/<C-R>v<CR>
xmap # "vy?\<<C-R>v\><CR>
xmap g# "vy?<C-R>v<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" FZF
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <leader>f :Files<CR>
nmap <leader>d :Tags<CR>
nmap <leader>r :Rg 
nmap <leader>b :ls<CR>:b

" Rusty tags
if executable("rusty-tags") == 1
    autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
endif

" '@' on visual executes the same macro on each line
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
