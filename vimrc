:set visualbell
:set smartindent
:set ai
:set incsearch
:set hlsearch
:set so=6
:syntax on
:set guifont=Monospace\ 8
:set guioptions=agimrLt
:set nocp

:set backspace=2
:set shiftwidth=4
:set softtabstop=4
:set tabstop=4
:set formatoptions=croq
:set smartindent
:inoremap # X#
:set expandtab
:set shortmess=filnxtToOI

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

:set nobackup
:set grepprg=ack
:map <F5> :call ToggleFlag("spell")<CR>

" Internal lookup
:map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

autocmd FileType c set omnifunc=ccomplete#Complete
:set tags=./tags;/usr/tags;/

:set encoding=utf-8

" map / for visual mode to work like / in normal mode
:vmap / y/<C-R>"<CR>

" flag tab indentation and trailing whitespace
:set listchars=tab:>-,trail:!
:set list

" Special indentation for html
:autocmd BufRead *.html,<HTML> set tabstop=2
:autocmd BufRead *.html,<HTML> set softtabstop=2
:autocmd BufRead *.html,<HTML> set shiftwidth=2
:autocmd BufRead *.html,<HTML> set autoindent


" Teh automagic F6 button!
" For with to debug
:autocmd FileType c map <F6> <Esc>:!gdb<CR>


" Teh automagic F7 button
" To test
":autocmd FileType perl map <F7> <Esc>:!perl -cw %<CR>
:autocmd FileType make map <F7> <Esc>:make test<CR>


" Teh automagic F8 button!
" To compile/execute
":autocmd FileType perl map <F8> <Esc>:!perl %<CR>
:autocmd FileType lua map <F8> <Esc>:!lua %<CR>
:autocmd FileType make map <F8> <Esc>:w<CR>:make -f %<CR>
:autocmd FileType c map <F8> <Esc>:w<CR>:make<CR>


:set t_Co=8
:set t_md=
:colorscheme default

au BufNewFile,BufRead *.rl      setf ragel
au BufNewFile,BufRead *.pp      setf puppet
au! BufRead,BufNewFile *.json set filetype=json

" For some reason my default Leader is undefined...
:let g:Perl_MapLeader='\'

" force plugins on
:filetype plugin on

" Ctrl-based tabbing ftw
:map <silent> <C-E> :tabnew<CR>:E<CR>
:map <silent> <C-N> :tabnext<CR>
:map <silent> <C-P> :tabprevious<CR>

" Don't flush buffers if they change
:set bufhidden=hide

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
