" Vim filetype plugin
" Language: diff/patch file
" Maintainer: Serge Gebhardt <serge.gebhardt [-at-] gmail [-dot-] com>
" Last Change:  2012-sep-14

" Based on work by Andreas Bernauer

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
    finish
endif
let b:did_ftplugin = 1

setlocal nomodeline formatoptions-=croq formatoptions+=tl
setlocal foldmethod=expr
setlocal foldexpr=diff#foldexpr()
setlocal foldcolumn=3


" Provide movement mappings
nnoremap <buffer> ]] :call diff#jump_to_next_file(0)<cr>
nnoremap <buffer> [[ :call diff#jump_to_next_file(1)<cr>
nnoremap <buffer> ]h :call diff#jump_to_next_hunk(0)<cr>
nnoremap <buffer> [h :call diff#jump_to_next_hunk(1)<cr>
