:set visualbell
:set smartindent
:set autoindent

" Realtime search highlighting
:set incsearch
" Highlight search matches
:set hlsearch

" Screen lines to keep above and below the cursor
:set scrolloff=6

" Syntax highlighting
:syntax on

" No vi-compatibility
" compatible
:set nocompatible

:set backspace=2

" Auto-indent tab width
:set shiftwidth=4
" Columns per tab key press
:set softtabstop=4
" Tab character width
:set tabstop=4
:set smartindent

" c = Auto-wrap comments using textwidth, inserting the current comment
" r = Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" o = Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
" q = Allow formatting of comments with 'gq'.
:set formatoptions=c,r,o,q

:inoremap # X#

" Convert tab keys to spaces
:set expandtab

" a = Allow GUI to access visually selected items
" g = Make menu items that are not active grey
" i = Use a Vim icon
" m = Enable menu bar
" r = Right-hand scrollbar is always present
" L = Left-hand scrollbar is present when there is a vertically split window.
" t = Include tearoff menu items
:set guioptions=agimrLt

" f = use '(3 of 5)' instead of '(file 3 of 5)'
" i = use '[noeol]' instead of '[Incomplete last line]'
" l = use '999L, 888C' instead of '999 lines, 888 characters'
" n = use '[New]' instead of '[New File]'
" x = use '[dos]' instead of '[dos format]', '[unix]' instead of '[unix format]' and '[mac]' instead of '[mac format]'.
" t = truncate file message at the start if it is too long to fit on the command-line, '<' will appear in the left most column.
" T = truncate other messages in the middle if they are too long to fit on the command line.  '...' will appear in the middle.
" o = overwrite message for writing a file with subsequent message for reading a file (useful for ':wn' or when 'autowrite' on)
" O = message for reading a file overwrites any previous message. Also for quickfix message (e.g., ':cn').
" I = don't give the intro message when starting Vim
:set shortmess=filnxtToOI

" Always display a status line
:set laststatus=2
:set statusline=%(%F%m%r%h%w%)\ \ \ %=[\%03.3b/0x\%02.2B]\ \ \ %(%l,%v\ \ \ [%p%%]%)

function! ToggleFlag(option)
    if ( !exists('b:tf_o') )
        exec ('let b:tf_o = 1')
        exec ('setlocal '.a:option)
    else
        exec ('setlocal no'.a:option)
        exec ('unlet b:tf_o')
    endif
endfunction

" No need to make a backup before overwriting
:set nobackup

" Use silversearcher instead of grep
:set grepprg=ag

autocmd FileType c set omnifunc=ccomplete#Complete

:set encoding=utf-8

" map / for visual mode to work like / in normal mode
:vmap / y/<C-R>"<CR>

" flag tab indentation and trailing whitespace
:set listchars=tab:>-,trail:!

" Enable listchars
:set list

" Special indentation for html
:autocmd BufRead *.html,<HTML> set tabstop=2
:autocmd BufRead *.html,<HTML> set softtabstop=2
:autocmd BufRead *.html,<HTML> set shiftwidth=2
:autocmd BufRead *.html,<HTML> set autoindent

" Internal lookup
:map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Enable/disable spell checking
:map <F5> :call ToggleFlag("spell")<CR>

" Debugging based on file type
:autocmd FileType c map <F6> <Esc>:!gdb<CR>

" Testing based on file type
":autocmd FileType perl map <F7> <Esc>:!perl -cw %<CR>
:autocmd FileType make map <F7> <Esc>:make test<CR>

" Compilation/execution based on file type
":autocmd FileType perl map <F8> <Esc>:!perl %<CR>
:autocmd FileType lua map <F8> <Esc>:!lua %<CR>
:autocmd FileType make map <F8> <Esc>:w<CR>:make -f %<CR>
:autocmd FileType c map <F8> <Esc>:w<CR>:make<CR>

" Force 8 bit color
:set t_Co=8

" Disable bold colors
:set t_md=

" Syntax/filetype definition
au BufNewFile,BufRead *.rl      setf ragel
au BufNewFile,BufRead *.pp      setf puppet
au! BufRead,BufNewFile *.json set filetype=json

" For some reason my default Leader is undefined...
:let g:Perl_MapLeader='\'

" Don't flush buffers if they change
:set bufhidden=hide

" Tab completion of vim items
:set wildmode=longest,list,full
:set wildmenu

" Highlight lines over 80 characters long
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

let g:pymode_folding = 0
let g:pymode_paths = ['/opt/duo/trustedpath-itest/lib/python','/opt/duo/trustedpath/lib/python']

" Syntastic language validation utilities
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['jshint']
let syntastic_python_checkers = ['flake8']
let g:loaded_syntastic_python_pylint_checker = 1

:filetype off

:set tags=./tags;/usr/tags;$HOME/tags;/

:colorscheme luna

" Nice idea, but this takes forever!
let g:pymode_rope_complete_on_dot = 0

" force plugins on
:filetype plugin indent on
