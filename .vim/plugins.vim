colorscheme mustang

" ALE {{{
let g:ale_completion_enabled = 1
let g:ale_fixers = {
\    'css': ['prettier'],
\    'html': ['prettier'],
\    'javascript': ['eslint'],
\    'python': ['ruff'],
\    'ruby': ['standardrb'],
\    'typescript': ['prettier', 'tslint'],
\}
let g:ale_fix_on_save = 1    
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['ruff', 'flake8', 'pylint'],
\   'ruby': ['standardrb', 'rubocop', 'solargraph']
\}
let g:ale_set_balloons=1
" Tab key behavior: Trigger completion menu OR navigate down the list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
" Shift-Tab key behavior (Optional): Navigate up the list
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
" Enter key behavior: Accept selected completion item without inserting a newline
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" Close the popup menu with Esc without leaving Insert mode
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences<CR>
nmap K :ALEHover<CR>
set omnifunc=ale#completion#OmniFunc
" }}}

" AIRLINE {{{
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" }}}

" NERDTREE {{{
let g:NERDTreeFileLines = 1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
" }}}

" SIMPYLFOLD {{{
" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
let g:SimpylFold_docstring_preview=1
" Highlight folded text black
hi Folded ctermfg=black
" }}}

