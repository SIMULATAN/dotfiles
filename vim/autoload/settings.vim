function! settings#IsEnabled(name)
	return get(g:, 'set_' . a:name, 0) == 1
endfunction

function! settings#GetValue(name)
  return get(g:, 'set_' . a:name)
endfunction

function! settings#GetValueDefault(name, default)
  return get(g:, 'set_' . a:name, a:default)
endfunction

function! settings#reload()
  source $MYVIMRC
endfunction

function! settings#SaveVariables(var_list, file)
  let l:file = a:file
  let l:vars = []
  for var in a:var_list
    if exists("g:" . var)
			call add(l:vars, printf("%s=%s", substitute(var, '^set_', '', ''), eval("g:" . var)))
    else
      echoerr "Setting " . var . " does not exist"
    endif
  endfor
  call writefile(l:vars, l:file)
endfunction

function! settings#LoadVariables(file)
  call settings#LoadVariablesOnce(a:file)
	call settings#reload()
endfunction

function! settings#LoadVariablesOnce(file)
  let l:file = a:file
  if filereadable(l:file)
    let l:lines = readfile(l:file)
    for l:line in l:lines
      let l:parts = split(l:line, '=')
      if len(l:parts) == 2
        call settings#StoreVariable(l:parts[0], l:parts[1])
      else
        echoerr "Invalid variable line " . l:line
      endif
    endfor
  else
    echo "Settings File " . l:file . " does not exist or is not readable"
  endif
endfunction

function! settings#SetVariable(name, value)
  if type(a:value) == type(0) || type(a:value) == type(0.0)
    execute 'let g:set_' . a:name . ' = ' . a:value
  elseif type(a:value) == type('')
    execute 'let g:set_' . a:name . ' = "' . a:value . '"'
  else
    return 0
  endif

  return 1
endfunction

function! settings#StoreVariable(...)
  if a:0 < 2
    call lib#Error("Wrong number of arguments, expected at least 2")
    return
  endif

	let l:key = a:1
  let l:val = a:2

  if ! settings#SetVariable(l:key, l:val)
    call lib#Error("Invalid argument type")
    return
  endif

  " get all variable names starting with 'set_'
	let l:variables = keys(copy(g:)->filter('v:key =~# "^set_"'))
	call settings#SaveVariables(variables, "/home/".$USER."/.vim/settings.local")
endfunction

function! SEnable(...)
    let args = a:000
    for name in args
        call settings#StoreVariable(name, 1)
    endfor
endfunction

function! SDisable(...)
    let args = a:000
    for name in args
        call settings#StoreVariable(name, 0)
    endfor
endfunction

command! -nargs=* -bar SSet call settings#SetVariable(<f-args>) | call settings#reload()
command! -nargs=* -bar SEnable call SEnable(<f-args>) | call settings#reload()
command! -nargs=* -bar SDisable call SDisable(<f-args>) | call settings#reload()
