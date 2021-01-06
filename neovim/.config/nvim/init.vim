set mouse=a
set number
set relativenumber
set hidden
set ignorecase
set linebreak

set tgc
set completeopt=menu

set expandtab
set tabstop=2
set shiftwidth=2

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:polyglot_disabled = ['c', 'cpp']
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
let g:cpp_attributes_highlight = 1

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'Olical/vim-enmasse'
Plug 'frazrepo/vim-rainbow'
Plug 'igankevich/mesonic'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/loremipsum'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ncm2/float-preview.nvim'
Plug 'joshdick/onedark.vim'
Plug 'prabirshrestha/async.vim'
Plug 'sheerun/vim-polyglot'
Plug 'bfrg/vim-cpp-modern'
Plug 'neovim/nvim-lspconfig'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
call plug#end()
colorscheme onedark

nmap <F8> :Ex<CR>
nmap <C-F8> :Vex<CR>
xmap * "vy/\<<C-R>v\><CR>
xmap g* "vy/<C-R>v<CR>
xmap # "vy?\<<C-R>v\><CR>
xmap g# "vy?<C-R>v<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Some terminal remappings
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" ALT + {h,j,k,l} for changing windows
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

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
"if executable("rusty-tags") == 1
    "autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
    "autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
"endif

" '@' on visual executes the same macro on each line
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Preview float window
function! FloatPreviewOnTop()
  call nvim_win_set_config(g:float_preview#win, {'relative': 'editor', 'row': 0, 'col': 0})
endfunction
autocmd User FloatPreviewWinOpen call FloatPreviewOnTop()

" Neovim-LSP
lua << EOF
local nvim_lsp = require 'nvim_lsp'
nvim_lsp.clangd.setup{
  cmd = { "clangd", "--background-index", "--compile-commands-dir=build" },
}
nvim_lsp.omnisharp.setup{}
nvim_lsp.pyls.setup{}
nvim_lsp.rls.setup{}

-- Custom configs
local configs = require 'nvim_lsp/configs'
if not configs.dls then
  configs.dls = {
    default_config = {
      cmd = {'dls'};
      filetypes = {'d'};
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end
nvim_lsp.dls.setup{}
EOF
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

autocmd Filetype c,cpp,cs,d,rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

autocmd Filetype c,cpp nmap <leader>h :ClangdSwitchSourceHeader<CR>



" LSP
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = 'vim-lsp.log'

"function! s:on_lsp_buffer_enabled() abort
    "setlocal omnifunc=lsp#complete
    "setlocal signcolumn=yes
    "if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    "nmap <buffer> gd <plug>(lsp-definition)
    "nmap <buffer> gi <plug>(lsp-implementation)
    "nmap <buffer> <leader>d <plug>(lsp-peek-definition)
    "nmap <buffer> <leader>i <plug>(lsp-peek-implementation)
    "nmap <buffer> <leader>t <plug>(lsp-peek-type-definition)
    "nmap <buffer> <C-\>f <plug>(lsp-references)
    "nmap <buffer> <C-\>R <plug>(lsp-rename)
    ""nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    ""nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    "nmap <buffer> K <plug>(lsp-hover)
    
    "" refer to doc to add more commands
"endfunction

"augroup lsp_install
    "au!
    "" call s:on_lsp_buffer_enabled only for languages that has the server registered.
    "autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"augroup END
