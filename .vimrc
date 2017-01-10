" This is my personal .vimrc, feel free to use it with your own risk.

" Set not compatible with vi. This is useful for
" consecutive undo and others
set nocompatible

call plug#begin('~/.vim/plugged')
" NerdTree. Disabled as it is really slow, use newtr (vim's native 
" file explorer) instead.
" See http://vimcasts.org/episodes/the-file-explorer/
"
" Auto comment
Plug 'scrooloose/nerdcommenter'

" Auto complete
Plug 'Shougo/neocomplete.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'fatih/vim-go'

" Status bar
Plug 'vim-airline/vim-airline'

call plug#end()

" Use pathogen (Deprecated, use Plug instead)
" call pathogen#infect()

" Git, add spell checking and automatic wrapping at the
" recommended 72 columns to you commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" set leaders
let mapleader = ","
let maplocalleader = "."

" load filetype plugins/indent settings
filetype plugin indent on

" Syntax highlight
syntax on

" Colorscheme
set t_Co=256   " This is may or may not needed."
set background=dark

" Set buffer to be hidden
set hidden

" Show line numbers
set number numberwidth=4

" Set cursorline
set cursorline

" Remove annoying beeps
set visualbell
set noerrorbells

" Don't create backup file
set nobackup
set noswapfile

" Indentation, set default to 4 spaces
set tabstop=4	" set tab to four spaces
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set autoindent	" set autoindent on
set copyindent	" copy prev indentation on autoindenting
set shiftwidth=4	" number of spaces to use for autoindenting
set shiftround	" use multiple of shiftwidth when indenting with '<' and '
set smarttab	" insert tabs on the start of a line according to shiftwidth, not tabstop

" Search
set showmatch	" set show matching parenthesis
set ignorecase	" ignore case when search
set smartcase	" ignore case if search pattern is all lower case, case sensitive if otherwise
set hlsearch	" highlight search terms
set incsearch	" show search matches as you type

" Wrapping
set nowrap

set laststatus=2

" vim airline
" powerline status bar for vim
let g:airline_powerline_fonts = 1

"""""""""""
" neocomplete
"""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Key mappings
"""""""""""

" Save file to ctrl+s
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>

" Removes all dangling whitespaces
nnoremap <leader>c :%s/\s\+$//<cr>

" Quit vim, 'ctrl+q' to quit without save
nnoremap <C-q> :q!<cr>
inoremap <C-q> <esc>:q!<cr>

" Save then quit -- Disabled, to enable open in window split
" nnoremap <C-w> :wq!<cr>
" inoremap <C-w> <esc>:wq!<cr>

" Fast edit .vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Go to end of line with insert mode
" Useful when adding a ; at the end of
" a statement
nnoremap <C-a> $a
inoremap <C-a> <esc>$a

" Add an empty line above the current line.
" Useful when creating function with curly
" braces
nnoremap <C-o> ko
inoremap <C-o> <esc>ko

" Open newtr at current directory
noremap <C-\> :e.<CR>

" Move line up and down, ref http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
" alt+k to move one line up
nnoremap ˚ :m .-2<cr>==
inoremap ˚ <esc>:m .-2<cr>==gi
" alt+j to move one line down
nnoremap ∆ :m .+1<cr>==
inoremap ∆ <esc>:m .+1<cr>==gi

" Surround a word with double quote
nnoremap <leader>" viW<esc>a"<esc>hBi"<esc>lel

" Surround a word with single quote
nnoremap <leader>' viW<esc>a'<esc>hBi'<esc>lel

" Surround a word with backtick
nnoremap <leader>` viW<esc>a`<esc>hBi`<esc>lel

" Surround a word with parentheses (a)
nnoremap <leader>() viW<esc>a)<esc>hBi(<esc>lel

" Surround a word with square bracket [a]
nnoremap <leader>[] viW<esc>a]<esc>hBi[<esc>lel

" Surround a word with curly bracket with spaces { a }
nnoremap <leader>{} viW<esc>a }<esc>hBi{ <esc>lel

" Use H to go to the beginning of a line, L to the end of a line
nnoremap H ^
nnoremap L $

" Disable escape keys, use jk instead
inoremap <esc> <nop>
inoremap jk <esc>

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <left> <nop>
nnoremap <down> <nop>
nnoremap <right> <nop>

inoremap <up> <nop>
inoremap <left> <nop>
inoremap <down> <nop>
inoremap <right> <nop>

inoremap OA <nop>
inoremap OC <nop>
inoremap OB <nop>
inoremap OD <nop>

" Use ctrl+j to insert new line in normal mode without entering insert mode
nnoremap <C-j> ciW<CR><Esc>:if match( @", "^\\s*$") < 0<Bar>exec "norm P-$diw+"<Bar>endif<CR>

" Use ctrl+l to clear the search highlight
nnoremap <silent> <C-l> :nohls<cr>

" Pastetoggle, useful if paste code from outside application.
" Use only in vim terminal, if in GUI set toggle off.
" Map toggle to ctrl+t
nnoremap <C-t> :set invpaste paste?<cr>
inoremap <C-t> <esc>:set invpaste paste?<cr>

" Insert a new line under current text without enter to insert mode
nnoremap <leader>o o<esc>

set pastetoggle=<C-t>
set showmode

" Move to another window split
nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>l :wincmd l<cr>

" Wrap shortcut
nnoremap <leader>w :set wrap linebreak nolist<cr>

" Unite key mapping
nnoremap <C-f><C-s> <esc>:Unite file buffer<cr>
inoremap <C-f><C-s> <esc>:Unite file buffer<cr>

" PDV php documentor
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

" Set spell to en
nnoremap <leader>s :set spell spelllang=en<cr>

" Abbreviations
" typos
iabbrev adn and
iabbrev tehn then

iabbrev @@ nauval.atmaja@gmail.com
iabbrev @@1 noval.78@gmail.com
iabbrev @@a @author Nauval Atmaja <noval.78@gmail.com>
iabbrev @@b @author Nauval Atmaja <nauval.atmaja@gmail.com>


"" Autocommands -------------------------------------{{{
" Dissable generating comment in the next line after a comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup filetype_js
autocmd!
" Indentation, set tab to be 2 spaces
autocmd FileType javascript setlocal tabstop=2	" set tab to four spaces
autocmd FileType javascript setlocal backspace=indent,eol,start	" allow backspacing over everything in insert mode
autocmd FileType javascript setlocal autoindent	" set autoindent on
autocmd FileType javascript setlocal copyindent	" copy prev indentation on autoindenting
autocmd FileType javascript setlocal shiftwidth=2	" number of spaces to use for autoindenting
autocmd FileType javascript setlocal shiftround	" use multiple of shiftwidth when indenting with '<' and '
autocmd FileType javascript setlocal expandtab	" Expand tab to spaces
autocmd FileType javascript setlocal smarttab	" insert tabs on the start of a line according to shiftwidth, not tabstop
augroup END

" Vimscript file setting ----------------------------{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

augroup startup
autocmd VimEnter ! source /root/.bashrc
augroup END

"" }}}

