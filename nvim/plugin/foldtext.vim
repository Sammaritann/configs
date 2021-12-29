if exists("g:buz_foldtext")
  finish
endif
let g:buz_foldtext = 1

function! MyFoldText()
  let lines_count = v:foldend - v:foldstart + 1
  return "+" .. string(l:lines_count) .. " " .. (l:lines_count == 1 ? "line" : "lines")
endfunction

set foldtext=MyFoldText()
