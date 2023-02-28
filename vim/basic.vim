" disable compatibility to old-time vi
set nocompatible 

" show matching 
set showmatch

" case insensitive 
set ignorecase

" middle-click paste with 
set mouse=v

" highlight search 
set hlsearch

" incremental search
set incsearch

" number of columns occupied by a tab 
set tabstop=4

" see multiple spaces as tabstops so <BS> does the right thing 
set softtabstop=4

" converts tabs to white space
set expandtab

" width for autoindents
set shiftwidth=4

" indent a new line the same amount as the line just typed
set autoindent

" add line numbers
set number

" get bash-like tab completions
set wildmode=longest,list

" allow auto-indenting depending on file type
filetype plugin indent on

" syntax highlighting
syntax on

" enable mouse click
set mouse=a

" using system clipboard
set clipboard=unnamedplus

" Speed up scrolling in Vim
set ttyfast

" wrap text in buffer
set wrap

" numbers relative to current line
set relativenumber

" smort hehe
set smartindent

" scroll before current hits end of buffer
set scrolloff=8

" use terminal colors when emulating terminal
set termguicolors

" Show what percentage of page you are down
set ruler

" smarter vim
set smartcase

" set encoding for english
set encoding=utf-8

" show tablines
set showtabline=2

set splitright

set splitbelow

" No annoying sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Ingore complied files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Remap Escape key to \i 
inoremap <leader>i <Esc>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Indicate if I am in insert mode
autocmd InsertEnter,InsertLeave * set cul!

" Escape insert mode in terminal with \t
tmap <leader>e <C-W>N

" Switch window in terminal with \w
tmap <leader>w <C-W><C-W>

" Resize terminal to 10 lines
tmap <leader>c <C-W>:res10<cr>

" Open terminal with \t in normal mode
nmap <leader>tr :term<cr>

" Open new terminal and resize to 10 lines
nmap <leader>ts :term<cr><C-W>:res10<cr>

" Try and set colorscheme to dracula
try
    packadd! dracula
    syntax enable
    colorscheme dracula
catch 
    colorscheme slate
endtry

