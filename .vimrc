source "$VIMRUNTIME/defaults.vim"

set nocompatible
set hidden  " switch buffers without saving
if version >= 600
  filetype plugin indent on
endif

colorscheme gruvbox  " TODO: if gruvbox is not available, use slate
set background=dark
set tw=79  " TODO: should come up with something better...

let g:slime_target = "vimterminal"

set modelines=0
set nomodeline
set number relativenumber
set scrolloff=0  " no margins/padding when scrolling
set shortmess-=S  " display search match count [1/n]

set clipboard=unnamedplus

let mapleader = "\<Space>"
let maplocalleader = "\\"

" toggles buffers
nnoremap <Leader><Leader> <c-^>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>? :History<CR>
nnoremap <Leader>s :Rg<CR>
nnoremap <Leader>v :vsplit<CR>

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir=~/.vim/backup//,.
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" TODO detect based on file
set expandtab
set tabstop=4
set shiftwidth=4

" clear search highlighting with esc
nnoremap <silent><esc> :noh<CR><esc>

" buffer next/prev
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[b :bprevious<CR>

if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
