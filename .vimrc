" Enable modern Vim features not compatible with Vi spec.
set nocompatible
" If it exists, use the 'google' package (see http://go/vim/packages).
if !empty(globpath(&rtp, '/usr/share/vim/google/google.vim'))
  source /usr/share/vim/google/google.vim
endif

""" Don't need custom colors because we're using solarized in iterm
" try
"  colorscheme industry
"catch
"  colorscheme darkblue
"endtry

set mouse=nicr """ Enamble mouse scroll within vim (hold option to select text)

""" Cause the bottom of the screen to contain more useful information
set laststatus=2 ruler showcmd
set statusline=%f

""" Have vim be helpful with indentation, but not *too* clever
set autoindent

"Have vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

""" Have vim show trailing spaces in red, including
""" when opening a new buffer, but does not show it while in inserting it.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

""" Display tabs in red with a T and trailing '>' characters (I don't like tabs)
highlight SpecialKey ctermfg=1
set list
set listchars=tab:T>

""" Define a function which aliases commands (without adding them to tab completion)
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

""" I often capitalize the first letter of a command because I used shift to
""" get a colon.
call SetupCommandAlias("W", "w")
call SetupCommandAlias("Wq", "wq")
call SetupCommandAlias("Noh", "noh")

"" The following will trim whitepsace from the end of lines.
call SetupCommandAlias("tws", "%s/\\\\s\\\\+$//e")
call SetupCommandAlias("trimws", "%s/\\\\s\\\\+$//e")
""" The following will swap the current and next argument in an argument list
""" TODO(msheely) Implement this
""" call SetupCommandAlias("swa", "")


""" All of your plugins must be added before the following line.
filetype plugin indent on
syntax on
