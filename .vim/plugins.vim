colorscheme mustang

" ALE {{{
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1    
let g:ale_set_balloons = 1
let g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'

if has('popupwin')
  let g:ale_floating_preview = 1
  let g:ale_floating_window_border = ['│', '─', '┌', '┐', '┘', '└', '│', '─']
endif

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'python': ['ruff'],
\   'ruby': ['standardrb', 'solargraph'],
\}

let g:ale_fixers = {
\   'css': ['prettier'],
\   'html': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'python': ['ruff'],
\   'ruby': ['standardrb'],
\}

" Smart Tab Autocomplete: complete if after word, otherwise insert regular tab
function! s:check_backspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_backspace() ? "\<Tab>" : "\<C-x>\<C-o>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

" LSP & Diagnostic Key Mappings
nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gr :ALEFindReferences<CR>
nmap <silent> K  :ALEHover<CR>
nmap <silent> [d :ALEPreviousWrap<CR>
nmap <silent> ]d :ALENextWrap<CR>
nmap <silent> <leader>e :ALEDetail<CR>

set omnifunc=ale#completion#OmniFunc
" }}}

" FZF {{{
" Check for Homebrew on Apple Silicon
if isdirectory('/opt/homebrew/opt/fzf')
  set rtp+=/opt/homebrew/opt/fzf
" Check for Homebrew on Intel Macs
elseif isdirectory('/usr/local/opt/fzf')
  set rtp+=/usr/local/opt/fzf
" Check for direct git clone (Common for Linux/WSL)
elseif isdirectory(expand('~/.fzf'))
  set rtp+=~/.fzf
endif

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Key mappings for FZF
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'query':   ['fg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
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

