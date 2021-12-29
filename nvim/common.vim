if exists("g:buz_common")
  finish
endif
let g:buz_common = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Common functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Create string of length 'count' filled with characters 'char'
"Example: FillString(' ', 4) => "    "
function! FillString(char, count)
  let string=""
  let i = a:count
  while i > 0
    let string .= a:char
    let i -= 1
  endwhile
  return string
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        PasteUnformatted
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Paste text from system clipboard without indents at each line
function! PasteUnformatted()
  let oldPaste = &paste
  set paste
  execute "normal! i\<C-r>+\<Esc>"
  let &paste = oldPaste
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        FileInfo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:GetLineEndingChars(fileformat)
  if a:fileformat == "dos"
    return "CRLF"
  elseif a:fileformat == "unix"
    return "LF"
  elseif a:fileformat == "mac"
    return "CR"
  endif
  return "UNKNOWN"
endfunction

function! s:GetCurrentWindowInfo()
  let currentWindowNR = winnr()
  let currentTabpageNR = tabpagenr()
  for info in getwininfo()
    if info.tabnr == currentTabpageNR && info.winnr == currentWindowNR
      return info
    endif
  endfor
  return
endfunction

function! FileInfo()
  let winInfo = s:GetCurrentWindowInfo()
  echo "File:            " .. expand("%:p")
  echo "Filetype:        " .. &filetype
  echo "Encoding:        " .. &fileencoding
  echo "Line endings:    " .. s:GetLineEndingChars(&fileformat)
  echo "Lines in buffer: " .. line("$")
  echo "winnr:           " .. winInfo.winnr
  echo "winid:           " .. winInfo.winid
  echo "Window width:    " .. winInfo.width
  echo "Window height:   " .. winInfo.height
  echo "bufnr:           " .. winInfo.bufnr
  "TODO print whole buffer info?
  echo "tabnr:           " .. winInfo.tabnr
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        DeleteHiddenListedBuffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
function! s:GetHiddenListedBuffers()
  let active_buffers=[]
  call map(range(1, tabpagenr('$')), 'extend(active_buffers, tabpagebuflist(v:val))')
  let hidden_buffers=[]
  "Alternative implementation: bufexists(v:val)
  let user_msg = 'Delted buffers:'
  for buffer in filter(range(1, bufnr('$')), 'buflisted(v:val) && index(active_buffers, v:val)==-1')
    let user_msg = user_msg . ' ' . string(buffer)
    call add(hidden_buffers, buffer)
  endfor
  echo user_msg
  return hidden_buffers
endfunction

function! DeleteHiddenListedBuffers()
  for buffer in s:GetHiddenListedBuffers()
    silent execute 'bdelete' buffer
  endfor
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Toggle tabs/spaces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UseSpaces(use_spaces, offset_size_str)
  let offset_size = str2nr(a:offset_size_str)
  let &expandtab=a:use_spaces
  let &shiftwidth=offset_size
  let &tabstop=offset_size
endfunction

command! -nargs=1 UseSpaces call s:UseSpaces(1, <f-args>)
command! -nargs=1 UseTabs call s:UseSpaces(0, <f-args>)
