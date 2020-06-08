""" Function to switch between a header and implementation file
function! HeaderImplSwitch()
  let associated_file_cc=s:GetAssociatedFileNameCC()
  let associated_file_cpp=s:GetAssociatedFileNameCPP()
  if filereadable(associated_file_cc)
    exec "edit ".associated_file_cc
  elseif filereadable(associated_file_cpp)
    exec "edit ".associated_file_cpp
  else
    echo "Cannot find".associated_file_cc."nor".associated_file_cpp
  endif
endfunction

""" Get the name of the associated file
function! s:GetAssociatedFileNameCC()
  if (expand("%:e") == "cc")
    return expand("%:p:r").".h"
  endif
  if (expand("%:e") == "h")
    return expand("%:p:r").".cc"
  endif
  return ""
endfunction

""" Get the name of the associated file
function! s:GetAssociatedFileNameCPP()
  if (expand("%:e") == "cpp")
    return expand("%:p:r").".h"
  endif
  if (expand("%:e") == "h")
    return expand("%:p:r").".cpp"
  endif
  return ""
endfunction


""" Get the directory of the current file
function! OpenBuildFile()
  let file_dir = expand("%:p:h")
  let associated_build = file_dir.'/BUILD'
  if filereadable(associated_build)
    exec "edit ".associated_build
  else
    echo "Cannot find".associated_build
  endif
endfunction

""" Some notes on the wonderful expand() function:
""" For example, in directory /abc the command vim def/my.txt would edit
""" file /abc/def/my.txt.
""" The following commands could be entered to display the information shown:
" :echo   @%                  def/my.txt        directory/name of file
"                                               (relative to PWD of /abc)
" :echo   expand('%:t')       my.txt            name of file ('tail')
" :echo   expand('%:p')       /abc/def/my.txt   full path
" :echo   expand('%:p:h')     /abc/def          dir containing file ('head')
" :echo   expand('%:p:h:t')   def               First get full path with :p
"                                               (/abc/def/my.txt), then head
"                                               that with :h (/abc/def), then
"                                               tail that with :t (def)
" :echo   expand('%:r')       def/my            name of file less one extension
"                                               ('root') "
" :echo   expand('%:e')       txt               file's extension ('extension')


""" I like to be tidy, so this fucntion will clear all user registers
""" as well as the numbered registers 1-9.
""" Capital letter retisgers are not listed, as they refer to the same
""" register, with append rather than clobber
function! ClearRegisters()
  " split on any atom, getting every register listed
  let regs=split('abcdefghijklmnopqrstuvwxyz123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
endfunction

function! GoogleLog(level)
  let logcmd = "LOG(".a:level.") << \""
  let maincmd = "normal! yypkA: \" << \<esc>JA;\<esc>^i"
  execute maincmd.logcmd
endfunction

""" If in a directory matching /google/src/cloud/msheely/.*/google3, returns //
function! GoogleFileName()
  let file_path = expand("%:p")
  let PWD = system("pwd")[:-2]    " clip newline returned by system commands
  if (s:ToGoogle3Depot(PWD) == '//')  " if our working directory is //
    let shortened_path = s:ToGoogle3Depot(file_path)
    if (len(shortened_path) > 1)  " and we're opening a file in a subdir of //
      return shortened_path       " return shortened name
    endif
  endif
  return expand("%")              " otherwise, return relative path
endfunction

""" Returns the path of the form "//path/to/code" or empty string if not a
""" google3 repo of msheely
function! s:ToGoogle3Depot(path)
  let dirs = split(a:path, "/")
  if (len(dirs) > 5)
    let path_head = "/".join(dirs[0:3], "/")."/REPO/".dirs[5]
    if (path_head[:-1] ==# "/google/src/cloud/msheely/REPO/google3")
      return "//".join(dirs[6:], "/")
    endif
  endif
  return ""
endfunction

""" Save session and start a new one to force renumbering of buffers
function! RenumberBuffers()
  exe "mks! "."~/.vim/sessions/RenumberBuffers.vim"
  !echo cd `pwd` >> "~/.vim/sessions/RenumberBuffers.vim"
  1,$bd
  wv
  !vim -c "so ~/.vim/sessions/RenumberBuffers.vim"
  q
endfunction

""" There must be another argument after this
function! SwapArgs()
  " go back until we hit either a left paren or a comma
  let backwards_search = "?[(,]\<cr>"
  " move forward until we get to the next non-whitespace character
  let move_to_first_char = "/\\S\<cr>"
  " cut this arg, put it over the next one, and then paste that one before
  " previous comma
  let select_arg = "v/[,)]\<cr>h"
  execute "normal!".backwards_search.move_to_first_char.select_arg."d".move_to_first_char.select_arg."pF,P"
endfunction

