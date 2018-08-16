
set number
syntax enable

" ----------------------------- HIGHLIGHTING -----------------------------------

" Highlight character 81 (except when it's newline symbol) in line which exceeds
" 80 characters.
highlight ColumnColor ctermbg=Magenta
call matchadd('ColumnColor', '\%81v[^\n]', 100)

" Highlight all search results.
set hlsearch
nnoremap <esc><esc> :silent! nohls<cr>
highlight Search cterm=NONE ctermfg=Black ctermbg=White

" Highlight matches when jumping to next.
noremap <silent> n n:call HLNext(0.2)<cr>
noremap <silent> N N:call HLNext(0.2)<cr>

highlight WhiteOnRed ctermfg=White ctermbg=Red

function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let blinks = 3
    for n in range(1,blinks)
        let red = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
        call matchdelete(red)
        redraw
        exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
    endfor
endfunction

" ------------------------------- FILE BROWSING --------------------------------

" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files for tab complete
set wildmenu

" netrw configuration
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_winsize=25


command! MakeTags !ctags -R .

