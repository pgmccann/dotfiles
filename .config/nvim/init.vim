" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc
let g:loaded_perl_provider = 0

call plug#begin()
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'overcache/NeoSolarized'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'windwp/nvim-autopairs'
Plug 'preservim/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ycm-core/YouCompleteMe'
Plug 'vimwiki/vimwiki'
Plug '907th/vim-auto-save'
Plug 'dense-analysis/ale'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'f-person/auto-dark-mode.nvim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'bkad/CamelCaseMotion'
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'prettier/vim-prettier', { 'do': 'npm ci' }
Plug 'mtth/scratch.vim'
Plug 'tree-sitter/tree-sitter-typescript'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-characterize'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/command-t'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'chrisbra/csv.vim'
call plug#end()

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
set clipboard+=unnamedplus
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
set updatetime=100
set signcolumn=yes:1
let g:netrw_liststyle=3
filetype plugin indent on
runtime macros/matchit.vim
if !exists("g:syntax_on")
    syntax enable
endif
colorscheme NeoSolarized
autocmd vimenter * wincmd p
autocmd VimEnter * wincmd p
map <C-n> :NvimTreeToggle<CR>

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap & :&&<CR>
xnoremap & :&&<CR>

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldnestmax=10
set nofoldenable
set foldlevel=1
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:ale_virtualenv_dir_names = ['env']
let g:camelcasemotion_key = '<leader>'

if exists("did_load_csvfiletype")
  finish
endif
let did_load_csvfiletype=1

augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv
augroup END

autocmd FileType make set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
" autocmd FileType html,xhtml,css,xml,xslt,js,ts,json set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xhtml,html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

lua << END
require('lualine').setup{
    options = {
        theme = 'solarized',
        icons_enabled = true
    }
}
vim.opt.termguicolors = true
require('nvim-tree').setup()
require('nvim-autopairs').setup()
require('nvim-treesitter.configs').setup{
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_refex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    rainbow = {
        enable = false
    }
}
require('auto-dark-mode').setup({update_interval = 5000})
require('wincent.commandt').setup()
END
