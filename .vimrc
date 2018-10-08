execute pathogen#infect()
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set history=100
set ruler
set showcmd
set incsearch
set hlsearch
set smartcase
set hidden
set nowrap
set backspace=indent,eol,start
set expandtab
set tabstop=4
set shiftwidth=4
set number
set list listchars=tab:\ \ ,trail:·
set timeout timeoutlen=1000 ttimeoutlen=100
set encoding=utf-8
set autoread
set clipboard+=unnamed
set shortmess+=I
set splitbelow
set splitright
set cursorline
set visualbell
set wildmenu
set lazyredraw
set showmatch
set shell=zsh
set mouse=a
set path+=**
let g:netrw_liststyle=3
autocmd BufWinEnter * highlight ColorColumn ctermbg=darkred
set colorcolumn=80
filetype plugin indent on
runtime macros/matchit.vim
if !exists("g:syntax_on")
    syntax enable
endif
set background=dark
colorscheme solarized
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
map <C-n> :NERDTreeToggle<CR>

command! Clip w !pbcopy
command! Mail w ! BODY=`cat` && open "mailto:?body=$BODY"

augroup WrapLineInMdFile
    autocmd!
    autocmd FileType md setlocal wrap
augroup END

autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | endif
autocmd BufWinEnter * NERDTreeMirror
autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap & :&&<CR>
xnoremap & :&&<CR>

set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2

command! Andbld !cd `git rev-parse --show-toplevel` && ./gradlew assembleDevDebug && cd - &
command! Andrun !cd `git rev-parse --show-toplevel` && ./gradlew installDevDebug && cd - &

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
