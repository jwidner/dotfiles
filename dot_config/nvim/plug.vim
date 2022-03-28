call plug#begin('~/.vim/plugged')
" vim enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'

" semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'lervag/vimtex'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" syntactic language support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'pangloss/vim-javascript'
" Plug 'rust-lang/rust.vim'
" Plug 'solarnz/thrift.vim'

" fuzzy finder
Plug 'airblade/vim-rooter'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" GUI
Plug 'morhetz/gruvbox'
Plug 'machakann/vim-highlightedyank'
Plug 'hoob3rt/lualine.nvim'

" automatic ctags management
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

runtime ./lsp.lua
runtime ./evil_lualine.lua
