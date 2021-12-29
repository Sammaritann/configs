""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        BEHAVIOUR CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: rewrite in lua

"function! SetCompactMode(set_compact)
"  if a:set_compact
"    set nonumber norelativenumber
"    set signcolumn=no
"  else
"    "relative numbers + current line number on current line
"    set number relativenumber
"    "Show sign column by default
"    "Set to 'yes' or to 'number' if there are plugins that flick sign column a lot
"    set signcolumn=yes
"  endif
"endfunction
"
"function! ToggleCompactMode()
"  let set_compact = 0
"  if &signcolumn == "yes" || &number || &relativenumber
"    let set_compact = 1
"  endif
"  call SetCompactMode(set_compact)
"endfunction
"
"call SetCompactMode(1)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        COMMAND MAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! W w
command! Q q

command! OpenHighlightGroupsWindow :so $VIMRUNTIME/syntax/hitest.vim
command! PasteUnformatted call PasteUnformatted()
command! FileInfo call FileInfo()
command! DeleteHiddenListedBuffers call DeleteHiddenListedBuffers()
command! ToggleRecaller call ToggleRecaller()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        KEY MAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"function! ToggleDiffForCurrWindow()
"if &diff == 0
"  execute 'diffthis'
"else
"  execute 'diffoff'
"endif
"endfunction
""Mark window for [D]iff: mark 2+ windows to view diff
"nnoremap <Leader>d <cmd>call ToggleDiffForCurrWindow()<CR>
"
