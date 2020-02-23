set mouse=a
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'cespare/vim-toml'
call plug#end()

nmap <F8> :Ex<CR>
nmap <C-F8> :Vex<CR>

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

" Rusty tags
if executable("rusty-tags") == 1
    autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
    autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
endif
