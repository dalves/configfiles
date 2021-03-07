" You can source this file from your main .vimrc by using this command:
" :so ~/path/to/this/file
set nocompatible
set nonumber
set expandtab
set smarttab
set softtabstop=4
set ai sw=4
set scrolloff=5
set ruler

" Search as you type, highlighting matching results, with all-lowercase
" doing case insensitive search and anything else being case sensitive
set hlsearch incsearch ignorecase smartcase

set pastetoggle=<F2>

set tags=./tags;/


set wildmode=longest:full
set wildmenu

set matchpairs+=<:>

filetype plugin indent on

" Show tabs - tabs are evil!"
syn match tab display "\t"
hi link tab Error

" Remove trailing whitespace from *.php, *.phpt, *.js
autocmd BufWritePre *.php  :%s/\s\+$//e
autocmd BufWritePre *.phpt :%s/\s\+$//e
autocmd BufWritePre *.py   :%s/\s\+$//e
autocmd BufWritePre *.js   :%s/\s\+$//e
autocmd BufWritePre *.css  :%s/\s\+$//e
autocmd BufWritePre *.java :%s/\s\+$//e
autocmd BufWritePre *.xml  :%s/\s\+$//e

" Enable syntax highlighting
syntax enable

" Backspace through anything in insert mode, even \n
set backspace=2

"Easier window navigation
nnoremap <c-h> <c-w>h 
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k 
nnoremap <c-l> <c-w>l 


" Preserve selection when indenting in visual mode.
vnoremap < <gv
vnoremap > >gv

" When moving down on a wrapped line, move to the position directly below the
" current one on the display instead of skipping the wrapped line.
nnoremap j gj
nnoremap k gk

" ; is pretty useless, while : is very useful. 
map ; :

set title
let &titlestring = "vim " . pathshorten(expand("%:~:.:f"))
auto BufEnter * let &titlestring = "vim " . pathshorten(expand("%:~:.:f"))
if &term == "tmux"
  set t_ts=k
  set t_fs=\
endif
if &term == "tmux" || &term == "xterm"
  set title
endif
"let &titlestring = "vim " . pathshorten(expand("%:~:.:f"))
"auto BufEnter * let &titlestring = "vim " . pathshorten(expand("%:~:.:f"))

" Allow opening a lot tabs at startup (default is 10)
set tabpagemax=9999

" Make backspace in normal mode go backwards in the list of edit positions.
autocmd FileType java nnoremap <silent> <buffer> <bs> <c-o>

"-------------------- Python-specific things --------------------------------
" Recognize buck files as Python
autocmd BufWinEnter,BufRead,BufNew BUILD_DEFS set filetype=python
autocmd BufWinEnter,BufRead,BufNew BUCK set filetype=python

" Toggle line numbers when F6 is pressed
autocmd FileType python nnoremap <F6> :set nonumber!<CR>:set foldcolumn=0<CR>

" Execute file being edited with F5:
autocmd FileType python nnoremap <F5> :w<CR>:!/usr/bin/env python % <CR>

" indentation for python
autocmd FileType python set ai sw=4
autocmd FileType python set softtabstop=4


"-------------------- PHP-specific things ------------------------------

" indentation for PHP
autocmd FileType php set ai sw=2
autocmd FileType php set softtabstop=2

"-------------------- Java-specific things ------------------------------

" indentation for java
autocmd FileType java set ai sw=2
autocmd FileType java set softtabstop=2

"-------------------- Javascript-specific things ------------------------------

" indentation for javascript
autocmd FileType javascript set ai sw=2
autocmd FileType javascript set softtabstop=2

"-------------------- Eclim / Android things ------------------------------
autocmd FileType java let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
autocmd FileType java let g:EclimLocateFileDefaultAction="edit"

" Ctrl-f = open a 'find file in project' dialog
nnoremap <c-o> :LocateFile<cr>

" Ctrl-f = grep the whole project for a string
" All the <left>s are pretty stupid, but I don't know how else to position the
" cursor...
nnoremap <c-f> :lw<cr>:lvim //j **/*.java<left><left><left><left><left><left><left><left><left><left><left><left>

" Smart folding for Java files.
autocmd FileType java setlocal foldmethod=syntax

" Smart folding for xml files.
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax

" Make folds be open initially.
autocmd FileType c,cpp,vim,xml,html,xhtml,java,python normal zR

nnoremap <CR> <C-]>
nnoremap <BS> <C-T>

"-------------------------- XML things ------------------------------------
" Use two spaces for xml files
autocmd FileType xml set ai sw=2
autocmd FileType xml set softtabstop=2

" ----------------- Highlight overlength lines ----------------------
" Make the 81st column of each line red, so we can see 80-column violations
" but aren't totally blinded by huge swaths of red if there are really long
" lines.
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929

autocmd FileType xml        let w:m1=matchadd('Overlength', '\%81v', -1)
autocmd FileType python     let w:m1=matchadd('Overlength', '\%81v', -1)
autocmd FileType javascript let w:m1=matchadd('Overlength', '\%81v', -1)
autocmd FileType java       let w:m1=matchadd('Overlength', '\%101v', -1)

" ------------- Fix the severely broken default completion menu -------------
" WHY IS THE DEFAULT PINK?!
highlight Pmenu cterm=BOLD ctermbg=blue
highlight PmenuSel ctermfg=black

set completeopt=longest,menuone
inoremap <expr> <cr>   pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

nmap gb :set nowrap<CR>
 \:set scrollbind<CR>
 \:let f = expand('%')<CR>
 \:let linenum = line('.')<CR>
 \H
 \:let linetop = line('.')<CR>
 \:execute linenum<CR>
 \:w<CR>
 \:execute '35vnew +0r\ !~/bin/vim_blame.py\ '.f<CR>
 \:set buftype=nofile<CR>
 \:syncbind<CR>
 \:set scrollbind<CR>
 \:set diff<CR>
 \:set nonumber<CR>
 \:execute linetop<CR>
 \zt<CR>
 \:execute linenum<CR>

" Sample vim_blame.py for use with the above:

"#!/usr/bin/env python2.7
"
"import re
"import subprocess
"import sys
"
"if len(sys.argv) != 2:
"    print("Must supply a filename")
"    exit()
"
"cmd = ['git', 'blame', '-e', sys.argv[1]]
"
"p = subprocess.Popen(cmd, stdout=subprocess.PIPE, bufsize=0)
"
"def grep_dash_o(pattern, string):
"    match_obj = re.search(pattern, string)
"    if match_obj is not None:
"        return match_obj.group(1)
"    return ''
"
"
"for line in p.stdout:
"    line = line.strip()
"    author = grep_dash_o('<([^@]+)@', line)
"    date = grep_dash_o('(\\d\\d\\d\\d-\\d\\d-\\d\\d)', line)
"    githash = grep_dash_o('^([0-9a-f]{8,8})', line)
"
"    output = '  '.join([githash, date, author])
"    print(output)



" Better vimdiff colors.
highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white 
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black 
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black 
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black 



