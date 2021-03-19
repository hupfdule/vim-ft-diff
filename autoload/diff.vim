let s:pattern_file          = '^\(diff\|Index\)'
let s:pattern_hunk          = '^\(@@\|\d\)'
let s:pattern_context_file1 = '^\*\*\* \d\+,\d\+ \*\*\*\*$'
let s:pattern_context_file2 = '^--- \d\+,\d\+ ----$'
let s:pattern_only_in       = '^Only in'

""
" Get fold level for diff mode
"
" Works with normal, context, unified, rcs, ed, subversion and git diffs.
" For rcs diffs, folds only files (rcs has no hunks in the common sense)
" foldlevel=1 ==> file
" foldlevel=2 ==> hunk
" context diffs need special treatment, as hunks are defined
" via context (after '***************'); checking for '*** '
" or ('--- ') only does not work, as the file lines have the
" same marker.
" Inspired by Tim Chase.
function! diff#foldexpr()
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


""
" Jump to next start of the next file in the diff.
"
" @param {backwards} whether to jump forwards or backwards
"                    0 == jump forwards
"                    1 == jump backwards
function! diff#jump_to_next_file(backwards) abort
  if (a:backwards)
    call search(s:pattern_file, 'Wb')
  else
    call search(s:pattern_file, 'W')
  endif
endfunction


""
" Jump to next start of the next hunk in the diff.
"
" @param {backwards} whether to jump forwards or backwards
"                    0 == jump forwards
"                    1 == jump backwards
function! diff#jump_to_next_hunk(backwards) abort
  if (a:backwards)
    call search(s:pattern_hunk, 'Wb')
  else
    call search(s:pattern_hunk, 'W')
  endif
endfunction

