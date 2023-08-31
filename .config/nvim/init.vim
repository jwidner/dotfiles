set nocompatible
set hidden  " switch buffers without saving
filetype off
let mapleader = "\<Space>"
let maplocalleader = "\\"

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default
" 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

call plug#begin('~/.vim/plugged')
" vim enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" language plugins
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'solarnz/thrift.vim'

" fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" automatic ctags management
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" permanent undo
set undodir=~/.vimdid
set undofile

" clear search with escape
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set number relativenumber  " hybrid numbers
set nomodeline  " mode lines = security nightmare

" <leader> hotkeys
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>? :History<CR>
nnoremap <leader>s :Rg<CR>
nnoremap <leader>v :vsplit<CR>

" window focus/insert toggles relative line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" vimtex settings
let g:vimtex_view_general_viewer='zathura'
" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'packages' : {
      \   'default' : 0,
      \ },
      \}

" jedi settings
let g:jedi#popup_on_dot=0

if !has('nvim')
    set cm=blowfish2
endif

let g:tex_flavor = 'latex'

" web dev
autocmd FileType html,css,javascript,typescript setlocal shiftwidth=2 tabstop=2

" vim-go settings
let g:go_def_mapping_enabled = 0

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" error and buffer list traversal
nnoremap ]c :cnext<CR>
nnoremap ]C :clast<CR>
nnoremap [c :cprevious<CR>
nnoremap [C :cfirst<CR>

nnoremap ]b :bnext<CR>
nnoremap ]B :blast<CR>
nnoremap [b :bprevious<CR>
nnoremap [B :bfirst<CR>

au VimLeave * set guicursor=a:ver25-blinkon0  " exit with cursor as vertical bar
set laststatus=0  " remove ugly bar at the bottom
