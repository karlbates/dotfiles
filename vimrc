"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Always show current position
set ruler

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" don't auto-continue comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" colorscheme desert
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" user added
" nice tab stuff
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" line numbers
set number

" show trailing whitespace, mixed spaces/tabs
highlight ExtraSpaces ctermbg=darkred guibg=darkred
highlight TooLong ctermbg=darkgrey guibg=darkgrey

call matchadd('ExtraSpaces', '\s\+$', 0)  " trailing whitespace
call matchadd('ExtraSpaces', ' \+\t\+', 0) " spaces before tabs
call matchadd('ExtraSpaces', '\t\+ \+', 0) " tabs before spaces
call matchadd('TooLong', '\%>88v.\+' , -1)

