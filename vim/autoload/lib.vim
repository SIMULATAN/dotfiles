function! lib#Error(message)
  echohl Error | echo a:message | echohl None
endfunction
