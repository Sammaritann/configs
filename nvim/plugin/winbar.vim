""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        WINBAR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("g:buz_winbar")
  finish
endif
let g:buz_winbar = 1

" @brief Get window bar template
" @example Inactive window bar: Win:1 [Marked for diff]            [Readonly] init.vim Buf:21
" @example Active window bar:   Win:2                           [Modified] [other.vim] Buf:23
" @return Template string
function! GetWinBar1()
  let isFocused = g:statusline_winid == win_getid(winnr())
  if getwinvar(g:statusline_winid, "&filetype") ==# 'nerdtree'
    return win_id2win(g:statusline_winid) .. "%=" .. fnamemodify(getcwd(), ":~") .. "%=Buf:%n"
  endif

  let winInfo = getwininfo(g:statusline_winid)[0]
  "let bufInfo = getbufinfo(winInfo.bufnr)[0]
  let local_win_num = win_id2win(g:statusline_winid)
  let is_window_current = winInfo.bufnr == bufnr()

  let win_num_tag = string(local_win_num)
  let buf_num = "Buf:%n"

  let file_name = "%f"
  if is_window_current
    let file_name = "[%f]"
  endif

  let diff_tag = ""
  if getwinvar(g:statusline_winid, "&diff")
    let diff_tag = "[Marked for diff]"
  endif

  let modification_tag = ""
  if !getwinvar(g:statusline_winid, "&modifiable")
    let modification_tag = "[Readonly]"
  elseif getwinvar(g:statusline_winid, "&modified")
    let modification_tag = "[Modified]"
  endif

  return join([win_num_tag, diff_tag, modification_tag, "%=", file_name, "%=", buf_num], " ")
endfunction

hi! link WinBar Normal

set winbar=%!GetWinBar1()
