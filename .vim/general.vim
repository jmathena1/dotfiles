" Highlight bad whitespace in Python and C files
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
" ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab
" Load an indent file for the detected file type.
filetype indent on
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
highlight BadWhitespace ctermbg=red guibg=red
" Make code look pretty
let python_highlight_all=1
" Tabs to 4 spaces
set autoindent expandtab tabstop=4 shiftwidth=4
" allows access to system clipboard
set clipboard=unnamed" 
" Highlight cursor line underneath the cursor horizontally.
set cursorline
" Highlight cursor line underneath the cursor vertically.
set cursorcolumn
set dir=~/tmp 
set encoding=utf-8
set foldmethod=indent
set foldlevel=99
" Do not wrap lines. Allow long lines to extend as far as the line goes.
" Ignore capital letters during search.
set ignorecase
" While searching though a file incrementally highlight matching characters as you type.
set incsearch
set nowrap
" change regex engine to keep Vim from hanging inside TS files on macos
set re=2
" Make line numbering relative
set rnu
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase
" Show partial command you type in the last line of the screen.
set showcmd
" Show matching words during a search.
set showmatch
" Show the mode you are on the last line.
set showmode
" Turn syntax highlighting on.
" Enable auto completion menu after pressing TAB.
set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest
source $VIMRUNTIME/defaults.vim
syntax on

" LARGE COMMANDS AND FUNCTIONS --- {{{
au BufNewFile,BufRead *.js,*.html,*.css
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

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END
" }}}


