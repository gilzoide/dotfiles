set mouse=a
set mousemodel=extend
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

set cc=101

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:polyglot_disabled = ['c', 'cpp']
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
let g:cpp_attributes_highlight = 1

let g:indent_guides_guide_size = 1

call plug#begin()
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'Olical/vim-enmasse'
Plug 'frazrepo/vim-rainbow'
Plug 'igankevich/mesonic'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/loremipsum'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'joshdick/onedark.vim'
Plug 'prabirshrestha/async.vim'
Plug 'sheerun/vim-polyglot'
Plug 'bfrg/vim-cpp-modern'
Plug 'neovim/nvim-lspconfig'
Plug 'sbdchd/neoformat'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
call plug#end()

colorscheme onedark

""" lightline options
set noshowmode
let g:lightline = { 'colorscheme': 'one' }

""" NERDTree options
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <F8> :NERDTreeMirror<CR>:NERDTreeToggle<CR>
nnoremap <C-F8> :NERDTreeMirror<CR>:NERDTreeToggleVCS<CR>

" Search mappings
xmap * "vy/\<<C-R>v\><CR>
xmap g* "vy/<C-R>v<CR>
xmap # "vy?\<<C-R>v\><CR>
xmap g# "vy?<C-R>v<CR>

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

" Find mappings
nmap <leader>b :ls<CR>:b

nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope git_files<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>rg <cmd>Telescope live_grep<CR>
nnoremap <leader>R <cmd>Telescope grep_string<CR>
nnoremap <leader>dd <cmd>Telescope diagnostics<CR>

" '@' on visual executes the same macro on each line
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Neovim-LSP
lua << EOF
local have_lsp, nvim_lsp = pcall(require, 'lspconfig')
if have_lsp then
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Misc keymaps
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-]>', '<cmd>Telescope lsp_definitions<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- Find/list keymaps
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>fr', '<cmd>Telescope lsp_references<CR>', opts)
    buf_set_keymap('n', '<leader>fd', '<cmd>Telescope lsp_definitions<CR>', opts)
    buf_set_keymap('n', '<leader>fD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
    buf_set_keymap('n', '<leader>fi', '<cmd>Telescope lsp_implementations<CR>', opts)
    buf_set_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    buf_set_keymap('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<CR>', opts)
    buf_set_keymap('n', '<leader>ws', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)
    -- Code action keymaps
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- Diagnostics keymaps
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

    -- Codelens
    if client.server_capabilities.codeLens then
      vim.api.nvim_exec([[
      autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()

      hi LspCodeLens cterm=bold ctermbg=None ctermfg=Cyan guibg=None guifg=Cyan
      ]], false)
    end

    -- Format keymap
    if client.server_capabilities.documentFormattingProvider then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.server_capabilities.documentRangeFormattingProvider then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Document highlight autocommand
    if client.server_capabilities.documentHighlightProvider then
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
end
EOF

autocmd Filetype c,cpp,m,mm nmap <leader>h :ClangdSwitchSourceHeader<CR>

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

function! HighlightNonAscii() abort
  let @/ = '[^\x00-\x7F]'
  :normal! n
endfunction

let g:neoformat_run_all_formatters = 1
