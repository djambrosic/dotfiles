" INSTALL PLUGINS

set t_Co=256

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'

call plug#end()

let g:airline_powerline_fonts = 1

" BASIC CONFIGURATION

syntax on
set nocompatible
set wrap
set number relativenumber
set laststatus=2
set ignorecase
set showmatch
set smartcase

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set noswapfile
set incsearch
set scrolloff=10
set showcmd
set showmode
set cursorline
set background=dark
colorscheme onedark
