" ============================================================================
" File:        split-expander.vim
" Description: Easily expand splits to fit the size of your file
" Author:      Tobias Macey <tmacey@boundlessnotions.com>
" Licence:     Vim licence
" Website:     https://github.com/blarghatey/split-expander
" Version:     0.0.5
" Note:        I hope this is helpful. All comments and suggestions are
"              welcome.
" ============================================================================

scriptencoding utf-8

function! ExpandWidth()
    if exists('b:blarghmatey_maxWidth_lastWidth')
        let widthResult = b:blarghmatey_expandWidth_lastWidth
        unlet b:blarghmatey_expandWidth_lastWidth
    else
        let b:blarghmatey_expandWidth_lastWidth = winwidth(0)
        let maxWidth = max(map(getline(1,'$'), 'len(v:val)'))
        let g:blarghmatey#expandWidth#defaultMaxWidth = 200
        let widthResult = min([ ( maxWidth + 5 ), g:blarghmatey#expandWidth#defaultMaxWidth ])
    endif
    execute 'vertical resize ' . widthResult
endfunction

function! ExpandHeight()
    if exists('b:blarghmatey_expandHeight_lastHeight')
        let heightResult = b:blarghmatey_expandHeight_lastHeight
        unlet b:blarghmatey_expandHeight_lastHeight
    else
        let b:blarghmatey_expandHeight_lastHeight = winheight(0)
        let fileLength = line('$') + 2
        let maxHeight = &lines
        let heightResult = min([maxHeight, fileLength])
        if exists('g:blarghmatey#expandHeight#heightLimit')
            let heightLimit = g:blarghmatey#expandHeight#heightLimit
            let heightResult = min([heightResult, heightLimit])
        endif
    endif
    execute 'resize ' . heightResult
endfunction

:map <leader>m :call ExpandWidth()<CR>
:map <leader>M :call ExpandHeight()<CR>
