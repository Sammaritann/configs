""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        STATUSLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Also see fillchars+=stl: in init.vim

if exists("g:buz_statusline")
  finish
endif
let g:buz_statusline = 1
let g:buz_statuslineShowRandomCommand = 0

function! s:GetStatusLine1Impl(isFocused)
  let winInfo = getwininfo(g:statusline_winid)[0]
  let bufInfo = getbufinfo(winInfo.bufnr)[0]
  let winNr = win_id2win(g:statusline_winid)
  "let bufNr = string(winInfo.bufnr)
  let totalWidth = winwidth(g:statusline_winid)
  if (&g:laststatus == 3)
    let totalWidth = &g:columns
  endif

  let fileModifiedSign = ""
  if bufInfo.changed
    let fileModifiedSign = "[+]"
  endif

  let fullPath = bufInfo.name
  let relPath = fnamemodify(bufInfo.name, ":.")
  let pathTail = fnamemodify(bufInfo.name, ":t")

  let leftPart = ""
  let centerPart = ""
  let rightPart = ""

  if a:isFocused
    if (exists("b:lsp_clients"))
      let leftPart ..= "LSP:" .. b:lsp_clients .. " "
    endif

    let centerPart = " "
    let centerPart ..= "Current dir:" .. getcwd()

    if g:buz_statuslineShowRandomCommand
      let randomMapping = luaeval('require("buzreps.recall").get_current_recall_entry()')
      let centerPart ..= " ─── Random " .. randomMapping['category'] .. ": " .. randomMapping['text']
    endif

    let centerPart ..= " "

    let rightPart = (&expandtab ? "Spaces" : "Tabs") .. "(" .. shiftwidth() .. ")"
    let rightPart ..= ' Character:%-3c Line:%l/%L'
  else
    let centerPart = string(winNr) .. " " .. relPath
  endif

  let centerPartPos = (totalWidth - strlen(centerPart)) / 2
  let leftFillLength = centerPartPos - strlen(leftPart)
  return leftPart . '%=' . centerPart . '%=' . rightPart
endfunction

"Intended to be used with `set laststatus=3`
"├———————————————— Current dir: /home/vladislav/repos/configs/vim/nvim ————————————————┤ Character:22  Line:13/37
function! GetStatusLine1()
  let isFocused = g:statusline_winid == win_getid(winnr())
  let statusline = s:GetStatusLine1Impl(isFocused)
  "if isFocused
  "  let statusline = "%#StatusLine#" .. statusline
  "else
  "  let statusline = "%#StatusLineNC#" .. statusline
  "endif
  return statusline
endfunction

function! ToggleRecaller()
  if g:buz_statuslineShowRandomCommand
    let g:buz_statuslineShowRandomCommand = 0
  else
    let g:buz_statuslineShowRandomCommand = 1
  endif
endfunction

hi! link StatusLine Normal
hi! link StatusLineNC Normal

"Show only one statusline of a current buffer at screen bottom
set laststatus=3
set statusline=%!GetStatusLine1()
