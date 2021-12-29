""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        TABLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("g:buz_tabline")
  finish
endif
let g:buz_tabline = 1

let s:TabLineDefaultLabel = "New tab"

"Init labels list
"We'll hope autocommands will keep list size syncronized with tabs count
if !exists("s:TabLineLabels")
  let s:TabLineLabels = []
  let tabsCount = tabpagenr("$")
  for i in range(tabsCount)
    let s:TabLineLabels = add(s:TabLineLabels, s:TabLineDefaultLabel)
  endfor
endif

"Set label for tab
"@param tabPage Tab page. Begin with 1
"@param label New label
function! s:TabLineSetLabel(tabNumber, label)
  let tabsCount = tabpagenr("$")
  if a:tabNumber > tabsCount
    return
  endif
  let idx = a:tabNumber - 1
  let s:TabLineLabels[idx] = a:label
  execute "redrawtabline"
endfunction

command! -nargs=* TabLineSetLabel call s:TabLineSetLabel(<f-args>)
command! -nargs=1 SetCurrentTabPageLabel call s:TabLineSetLabel(tabpagenr(), <f-args>)

"Move current tab left/right
"Using this instead of pure `:tabm` to move labels aswell
"@example s:MoveCurrentTab(-2) to move left 2 times
function! MoveCurrentTab(direction)
  let tab1Idx = tabpagenr() - 1
  let tab2Idx = tab1Idx + a:direction
  let tabsCount = tabpagenr("$")

  if tab2Idx < 0 || tab2Idx >= tabsCount
    return
  endif

  let temp = s:TabLineLabels[tab1Idx]
  let s:TabLineLabels[tab1Idx] = s:TabLineLabels[tab2Idx]
  let s:TabLineLabels[tab2Idx] = temp

  if a:direction > 0
    execute "tabm +" .. string(a:direction)
  else
    execute "tabm " .. string(a:direction)
  endif
endfunction

function! s:AddTabPage()
  let newTabPageNumber = tabpagenr()
  let currentTabPageIdx = newTabPageNumber - 1
  let s:TabLineLabels = s:TabLineLabels[:currentTabPageIdx - 1] + [s:TabLineDefaultLabel] + s:TabLineLabels[currentTabPageIdx:]
  return
endfunction

function! s:RemoveTabPageLabel(tabNumber)
  let tabIdx = a:tabNumber - 1
  let lastIdx = len(s:TabLineLabels) - 1

  if tabIdx == 0
    let s:TabLineLabels = s:TabLineLabels[1:]
  elseif tabIdx == lastIdx
    let s:TabLineLabels = s:TabLineLabels[:-2]
  else
    let s:TabLineLabels = s:TabLineLabels[:tabIdx - 1] + s:TabLineLabels[tabIdx + 1:]
  endif
endfunction

function! s:GetLabelForTab(tabNumber, isTabCurrent)
  let tabsCount = tabpagenr("$")
  let tabIdx = a:tabNumber - 1
  let res = ""
  if strlen(s:TabLineLabels[tabIdx]) > 0
    let res = string(a:tabNumber) .. " " .. s:TabLineLabels[tabIdx]
  else
    let res = string(a:tabNumber)
  endif
  if a:isTabCurrent
    let res = "[" .. res .. "]"
  endif
  return res
endfunction

"augroup to update tabline
"Should update g:TabLineLabels size and order
augroup TabLineGroup
  autocmd!
  autocmd TabNew * call s:AddTabPage()
  autocmd TabClosed * call s:RemoveTabPageLabel(str2nr(expand("<afile>")))
  "TODO: on tab reordering reorder values in s:TabLineLabels
augroup END

"Use redrawtabline() to redraw tabline in other functions
"Careful: tabNumber = tabIdx + 1
function! GetTabLine()
  let tabsCount = tabpagenr("$")
  let currentTabNumber = tabpagenr()
  let tabLineTotalWidth = &g:columns
  let tabPageLabelWidthChars = tabLineTotalWidth / tabsCount

  let s = ""
  for tabIdx in range(tabsCount)
    let tabNumber = tabIdx + 1
    let tabLabelText = s:GetLabelForTab(tabNumber, tabNumber == currentTabNumber)
    let offset = (tabPageLabelWidthChars - strlen(tabLabelText)) / 2
    if strlen(tabLabelText) < tabPageLabelWidthChars
      let whitespace = FillString(' ', offset)
      let tabLabelText = whitespace .. tabLabelText .. whitespace
    else
      let tabLabelText = tabLabelText[0:tabPageLabelWidthChars]
    endif

    "Coloring
    if tabNumber == currentTabNumber
      let s ..= "%#TabLineSel#"
    else
      let s ..= "%#TabLine#"
    endif
    let s ..= "%" . (tabIdx + 1) . "T" . tabLabelText . "%T"
  endfor
  
  let s..= "%#TabLineFill#%T"
  return s
endfunction

hi! link TabLine Normal
hi! link TabLineSel Normal
hi! link TabLineFill Normal

set tabline=%!GetTabLine()

