" LSP EXTRAS --- {{{
" LSP requests ALE doesn't provide, sent over ALE's existing connections
function! s:lsp_request(method, Handler) abort
  let l:linters = filter(ale#linter#Get(&filetype), 'v:val.lsp is# "stdio"')
  if empty(l:linters) | return | endif
  let l:message = ale#lsp#message#Definition(bufnr(''), line('.'), col('.'))
  let l:message[1] = a:method
  call ale#lsp_linter#SendRequest(bufnr(''), l:linters[0].name, l:message, a:Handler)
endfunction

function! s:show_signature(response) abort
  let l:result = get(a:response, 'result', v:null)
  if type(l:result) isnot v:t_dict || empty(get(l:result, 'signatures', [])) | return | endif
  call ale#floating_preview#Show([l:result.signatures[get(l:result, 'activeSignature', 0)].label])
endfunction

function! s:highlight_references(response) abort
  call s:clear_references()
  let l:result = get(a:response, 'result', v:null)
  if type(l:result) isnot v:t_list || empty(l:result) | return | endif
  let w:lsp_references = matchaddpos('Visual', map(l:result,
  \ '[v:val.range.start.line + 1, v:val.range.start.character + 1, v:val.range.end.character - v:val.range.start.character]'))
endfunction

function! s:clear_references() abort
  if exists('w:lsp_references')
    silent! call matchdelete(w:lsp_references)
    unlet w:lsp_references
  endif
endfunction

augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold * call s:lsp_request('textDocument/documentHighlight', function('s:highlight_references'))
  autocmd CursorMoved,InsertEnter * call s:clear_references()
augroup END

nmap <silent> <leader>s :call <SID>lsp_request('textDocument/signatureHelp', function('<SID>show_signature'))<CR>
" }}}
