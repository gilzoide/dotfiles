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
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
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

" Search mappings
xmap * "vy/\<<C-R>v\><CR>
xmap g* "vy/<C-R>v<CR>
xmap # "vy?\<<C-R>v\><CR>
xmap g# "vy?<C-R>v<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Some terminal configs
tnoremap <M-Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
au TermOpen * setlocal wrap
au TermOpen * setlocal statusline=%{b:term_title}

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
nmap <leader>g :GFiles<CR>
nmap <leader>d :Tags<CR>
nmap <leader>b :ls<CR>:b
nmap <leader>r :Rg 
nmap <leader>R "vyiw:Rg <C-R>v<CR>
xmap <leader>R "vy:Rg <C-R>v<CR>

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
local have_lsp, nvim_lsp = pcall(require, 'lspconfig')
if have_lsp then
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
        hi LspReferenceRead  cterm=bold ctermbg=LightYellow ctermfg=Black guibg=LightYellow guifg=Black
        hi LspReferenceText  cterm=bold ctermbg=LightYellow ctermfg=Black guibg=LightYellow guifg=Black
        hi LspReferenceWrite cterm=bold ctermbg=LightYellow ctermfg=Black guibg=LightYellow guifg=Black
        augroup lsp_document_highlight
          autocmd!
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]], false)
    end
  end
  nvim_lsp.clangd.setup{
    cmd = { "clangd", "--background-index", "--compile-commands-dir=build", "-j=8" },
    on_attach = on_attach,
  }
  nvim_lsp.cmake.setup{ on_attach = on_attach }
  nvim_lsp.gdscript.setup{ on_attach = on_attach }
  nvim_lsp.omnisharp.setup{
    cmd = { "omnisharp", "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) },
    on_attach = on_attach,
  }
  nvim_lsp.pyright.setup{ on_attach = on_attach }
  nvim_lsp.rls.setup{ on_attach = on_attach }
  nvim_lsp.tsserver.setup{ on_attach = on_attach }

  -- Custom configs
  local configs = require 'lspconfig/configs'
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
  nvim_lsp.dls.setup{ on_attach = on_attach }
end
EOF

autocmd Filetype c,cpp nmap <leader>h :ClangdSwitchSourceHeader<CR>

" Ref: https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
function! TextEnableCodeSnip(filetype, start, end, textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ keepend
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

function! EnableMarkdownCodeSnip(filetype) abort
  call TextEnableCodeSnip(a:filetype, '```'.a:filetype, '```', 'SpecialComment')
endfunction

