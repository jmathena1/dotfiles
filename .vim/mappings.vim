" MAPPINGS --- {{{
" remap vertical page movements to center in the middle of the screen
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" split navigations
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <C-S-Up> <c-w>+
noremap <C-S-Down> <c-w>-
noremap <C-S-Left> <c-w>>
noremap <C-S-Right> <c-w><

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Insert a new line above or below without entering insert mode.
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$
" }}}

