""" See the map-overview map-modes section of map.txt
""" Located at: /usr/share/vim/vim80/doc/map.txt
""" (you can also access it with :h cmap)

""" Create a mapping in command line mode from w!! to "force save" current file
""" Sometimes, one forgets to open a file with sudo, makes changes, and doesn't
""" want to close and reopen it and them make the same changes.  In that case,
""" use :w !!
""" This means:
""" (w) send the current buffer contents...
""" (!) ...to the shell command...
""" (sudo tee) ...tee, running with admin privileges...
""" (> /dev/null) ...send one copy of tee's output to /dev/null...
""" (%) and the other copy to the current file
cmap w!! w !sudo tee > /dev/null %

" in normal mode, map ,s to switching header and impl
nmap ,s :call HeaderImplSwitch()<CR>

" in normal mode, map ,s to switching header and impl
nmap ,b :call OpenBuildFile()<CR>

" in normal mode, clear all registers with ,s
nmap ,c :call ClearRegisters()<CR>

" in normal mode, ,l<level> creates a log statement for that level
nmap ,li :call GoogleLog("INFO")<CR>
nmap ,lw :call GoogleLog("WARNING")<CR>
nmap ,le :call GoogleLog("ERROR")<CR>
nmap ,lf :call GoogleLog("FATAL")<CR>
nmap <leader>swa :call SwapArgs()<CR>

" in normal, visual, and select mode, use <Ctrl>n / <Ctrl>p / <Ctrl>x to move to
" the next buffer / previous buffer / delete current buffer, respectively
nmap <C-n> :bn<CR>
vmap <C-n> :bn<CR>
nmap <C-p> :bp<CR>
vmap <C-p> :bp<CR>
" Switch to the last used buffer, then delete what is now the last used buffer
" (the buffer which was open when <C-x> was invoked
nmap <C-x> :b#\|bd #<CR>
vmap <C-x> :b#\|bd #<CR>

" Source vimrc in all modes using <leader>sv
nnoremap <leader>sv :source $MYVIMRC<cr>

