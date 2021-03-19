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

let s:pattern_file          = '^\(diff\|Index\)'
let s:pattern_hunk          = '^\(@@\|\d\)'
let s:pattern_context_file1 = '^\*\*\* \d\+,\d\+ \*\*\*\*$'
let s:pattern_context_file2 = '^--- \d\+,\d\+ ----$'
let s:pattern_only_in       = '^Only in'

setlocal nomodeline formatoptions-=croq formatoptions+=tl
setlocal foldmethod=expr
setlocal foldexpr=DiffFoldLevel()
setlocal foldcolumn=3

" Get fold level for diff mode
" Works with normal, context, unified, rcs, ed, subversion and git diffs.
" For rcs diffs, folds only files (rcs has no hunks in the common sense)
" foldlevel=1 ==> file
" foldlevel=2 ==> hunk
" context diffs need special treatment, as hunks are defined
" via context (after '***************'); checking for '*** '
" or ('--- ') only does not work, as the file lines have the
" same marker.
" Inspired by Tim Chase.
function! DiffFoldLevel()
    let l:line=getline(v:lnum)

    if l:line =~# s:pattern_file               " file
        return '>1'
    elseif l:line =~# s:pattern_hunk           " hunk
        return '>2'
    elseif l:line =~# s:pattern_context_file1  " context: file1
        return '>2'
    elseif l:line =~# s:pattern_context_file2  " context: file2
        return '>2'
    elseif l:line =~# s:pattern_only_in        " file only in one folder when using diff -r
        return '>1'
    else
        return '='
    endif
endfunction
