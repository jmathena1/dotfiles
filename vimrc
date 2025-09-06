set nocompatible              " required
filetype off                  " required

" --- CODE FORMATTING AND HIGHLIGHTING --- "
" But ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab
" Tabs to 4 spaces
set autoindent expandtab tabstop=4 shiftwidth=4
" Make code look pretty
let python_highlight_all=1
syntax on
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let g:javascript_plugin_jsdoc = 1
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1
let g:ycm_autoclose_preview_window_after_completion=1

" --- COLORS AND STUFF --- "
colorscheme mustang
source $VIMRUNTIME/defaults.vim
let g:airline_theme='papercolor'

" --- NERDTree ---"
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" --- REMAPS --- " 
" remap vertical page movements to center in the middle of the screen
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
" split navigations
nnoremap('<C-J>', '<C-W><C-J>')
nnoremap('<C-K>', '<C-W><C-K>')
nnoremap('<C-L>', '<C-W><C-L>')
nnoremap('<C-H>', '<C-W><C-H>')
" Enable folding with the spacebar
nnoremap <leader> za

" --- SETTING PREFERENCES
set dir=~/tmp
set encoding=utf-8
set rnu
" allows access to system clipboard
set clipboard=unnamed
" --- VIM SEARCH --- "
set incsearch
" Highlight all search matches
set hlsearch
"Ignorecase in searches
set ignorecase
"Override the 'ignorecase' option if the search pattern contains upper
set smartcase

