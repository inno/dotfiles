:set visualbell
:set smartindent
:set autoindent
:set incsearch  " Realtime search highlighting
:set hlsearch  " Highlight search matches
:set scrolloff=6  " Screen lines to keep above and below the cursor
:syntax on  " Syntax highlighting
:set nobackup  " No need to make a backup before overwriting
:set encoding=utf-8

:set shiftwidth=4  " Auto-indent tab width
:set softtabstop=4  " Columns per tab key press
:set tabstop=4  " Tab character width

" No vi-compatibility
" compatible
:set nocompatible

:set backspace=2

:set smartindent
:set expandtab  " Convert tab keys to spaces

" c = Auto-wrap comments using textwidth, inserting the current comment
" r = Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" o = Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
" q = Allow formatting of comments with 'gq'.
:set formatoptions=c,r,o,q


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


:set grepprg=ag  " Use silversearcher instead of grep

" map / for visual mode to work like / in normal mode
:vmap / y/<C-R>"<CR>

:set listchars=tab:>-,trail:!  " flag tab indentation and trailing whitespace
:set list  " Enable listchars
:set number  " Enable line numbers

" Special indentation for html
:autocmd BufRead *.html,<HTML> set tabstop=2
:autocmd BufRead *.html,<HTML> set softtabstop=2
:autocmd BufRead *.html,<HTML> set shiftwidth=2
:autocmd BufRead *.html,<HTML> set autoindent

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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic language validation utilities
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['eslint']
let syntastic_python_checkers = ['flake8']
let g:loaded_syntastic_python_pylint_checker = 1
let g:syntastic_yaml_checkers = ['yamllint']


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


autocmd BufWritePost * GitGutter
let g:gitgutter_highlight_lines = 1

" Custom commands
:command Sy SyntasticToggleMode
:command GG GitGutterToggle

:filetype plugin indent on


" git clone https://github.com/vim-syntastic/syntastic.git ~/.vim/pack/bundles/start/syntastic
" git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/airblade/start/vim-gitgutter
