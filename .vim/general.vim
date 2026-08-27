" Load sensible defaults first
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Set leader key early so plugins and mappings use the correct leader
let mapleader = '\'

" Filetype detection, plugins, and indentation
filetype plugin indent on
syntax on

" General settings
let python_highlight_all = 1
set autoindent expandtab tabstop=4 shiftwidth=4 softtabstop=4
set clipboard=unnamed,unnamedplus
set cursorline
set cursorcolumn
set dir=~/tmp//
set encoding=utf-8
set foldmethod=indent
set foldlevel=99
set ignorecase
set smartcase
set incsearch
set nowrap
set number
set relativenumber
set re=2
set scrolloff=10
set showcmd
set showmatch
set showmode
set wildmenu
set wildmode=list:longest

if has('termguicolors')
    set termguicolors
endif

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" AUTOCOMMANDS --- {{{
augroup dotfiles_autocmds
    autocmd!
    " Highlight bad whitespace
    highlight BadWhitespace ctermbg=red guibg=red
    autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

    " Indentation by file type
    autocmd FileType make setlocal noexpandtab
    autocmd FileType html,javascript,javascriptreact,typescript,typescriptreact,css,scss,json,yaml
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType python
        \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

    " Display cursorline and cursorcolumn ONLY in active window
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END
" }}}
