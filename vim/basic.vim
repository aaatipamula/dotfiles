" If you have a mapping interfering with normal mode run the following to remove or remap those commands
" :verbose imap <leader>

" set colorscheme slate
colorscheme slate

" set map leader to space
let g:mapleader=" "

" disable compatibility to old-time vi
set nocompatible

" incremental search
set incsearch

" converts tabs to white space
set expandtab

" number of columns occupied by a tab
set tabstop=2

" set multiple spaces as tabs stops so <BS> does the right thing
set softtabstop=2

" width for auto indents
set shiftwidth=2

" indent a new line the same amount as the line just typed
set autoindent

" smort hehe
set smartindent

" allow auto-indenting depending on file type
filetype plugin indent on

" add line numbers
set number

" numbers relative to current line
set relativenumber

" syntax highlighting
syntax on

" enable mouse click
set mouse=a

" middle-click paste with mouse
set mouse=v

" using system clipboard
set clipboard=unnamedplus

" Speed up scrolling in Vim
set ttyfast

" wrap text in buffer
set wrap

" smarter vim lol
set smartcase

" scroll before current hits end of buffer
set scrolloff=8

" use terminal colors when emulating terminal
set termguicolors

" Show what percentage of page you are down
set ruler

" set encoding for english
set encoding=utf-8

" get bash-like tab completions
set wildmode=longest,list

" show tablines
set showtabline=2

" show commands
set showcmd

" set spelling suggestion window to 15 lines
set spellsuggest+=10

" open split stuff below and to the right
set splitright
set splitbelow

" No annoying sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Ignore complied files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


" =====================================
" == Stolen Commands and Other Stuff ==
" =====================================
" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!) 
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Smart way to move between windows (ctrl-hjkl)
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Indicate if I am in insert mode
autocmd InsertEnter,InsertLeave * set cul!

" Enter removes highlighting
nnoremap <silent> <CR> :noh<CR><CR>

" Useful movement
nnoremap ge $
nnoremap gb 0

" Remap to close easier
nnoremap <leader>Q :qa<cr>
nnoremap <leader>X :wq<cr>
nnoremap <leader>xx :wqa<cr>

" toggle spell
nnoremap <silent> <leader>ss :setlocal spell! spelllang=en_us<cr>

" move highlighed selection up and down in visual (goated)
" stolen from theprimeagen 
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" keep selection after indenting in visual (goated)
vnoremap > >gv
vnoremap < <gv

" spell suggestion remap
nnoremap <C-.> z=


" ======================
" == Buffer Mappings ==
" ======================
" edit new buffer from current buffer path
nnoremap <leader>e :e! <C-r>=expand("%:p:h")<cr>/

" open buffer with filename
nnoremap <leader>o :b!

" quit current buffer
nnoremap <leader>x :bd<cr>

" open buffers 1-9
nnoremap <leader>1 :b!1<cr>
nnoremap <leader>2 :b!2<cr>
nnoremap <leader>3 :b!3<cr>
nnoremap <leader>4 :b!4<cr>
nnoremap <leader>5 :b!5<cr>
nnoremap <leader>6 :b!6<cr>
nnoremap <leader>7 :b!7<cr>
nnoremap <leader>8 :b!8<cr>
nnoremap <leader>9 :b!9<cr>

" next and previous buffers with 
nnoremap <TAB> :bn!<cr>
nnoremap <S-TAB> :bp!<cr>


" ==================
" == Tab Mappings ==
" ==================
" useful tab mappings
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <silent> <Leader>tl :exe "tabn ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path (taken from someones's vimrc)
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/


" =======================
" == Terminal Mappings ==
" =======================
" open horziontal terminal
nnoremap <silent> <leader>h :term<cr>

" open vertianl terminal
nnoremap <silent> <leader>v :vert term<cr>

" open new terminal and resize to 15 lines
nnoremap <silent> <leader>hs :term<cr><C-W>:res15<cr>

" escape insert mode in terminal ALT-e
tnoremap <C-e> <C-W>N

" switch windows in terminal easier
tnoremap <C-j> <C-W>j
tnoremap <C-k> <C-W>k
tnoremap <C-h> <C-W>h
tnoremap <C-l> <C-W>l

" resize terminal to 10 lines
tnoremap <C-r> <C-W>:res15<cr>


