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
set wrap
set backspace=indent,eol,start
set expandtab
set tabstop=4
set shiftwidth=4
set number
" set list listchars=tab:\ \ ,trail:·
set nolist linebreak
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
set spell
let g:netrw_liststyle=3
" autocmd BufWinEnter * highlight ColorColumn ctermbg=DarkGrey
" set colorcolumn=80
filetype plugin indent on
runtime macros/matchit.vim
if !exists("g:syntax_on")
    syntax enable
endif
set background=dark
colorscheme solarized
autocmd vimenter * wincmd p
map <C-n> :NERDTreeToggle<CR>

" autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | endif
autocmd BufWinEnter * NERDTreeMirror
" autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * wincmd p
let g:NERDTreeNodeDelimiter = "\u00a0"

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap & :&&<CR>
xnoremap & :&&<CR>

set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2

command! Andbld !cd `git rev-parse --show-toplevel` && ./gradlew assembleDevDebug && cd - &
command! Andrun !cd `git rev-parse --show-toplevel` && ./gradlew installDevDebug && cd - &

"Had to install powerline using /opt/homebrew/Cellar/python@3.11/3.11.1/bin/pip3.11 install powerline-status
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

map <F3> <Esc>:TlistToggle<CR>

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:NERDTreeQuitOnOpen = 1

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let @d = ':r !date +"\# \%a \%x"'

