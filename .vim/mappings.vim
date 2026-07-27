" MAPPINGS --- {{{
" remap vertical page movements to center in the middle of the screen
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

" split navigations
nnoremap('<C-J>', '<C-W><C-J>')
nnoremap('<C-K>', '<C-W><C-K>')
nnoremap('<C-L>', '<C-W><C-L>')
nnoremap('<C-H>', '<C-W><C-H>')

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Set the backslash as the leader key.
let mapleader = '\'

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$
" }}}

