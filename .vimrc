unlet! skip_defaults_vim
runtime defaults.vim

set nocompatible
set hidden  " switch buffers without saving
if version >= 600
  filetype plugin indent on
endif

set background=light
colorscheme solarized
set tw=79  " TODO: should come up with something better...

let g:slime_target = "vimterminal"

set modelines=0
set nomodeline
set number relativenumber
set scrolloff=0  " no margins/padding when scrolling
set shortmess-=S  " display search match count [1/n]

if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

let mapleader = "\<Space>"
let maplocalleader = "\\"

" toggles buffers
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>? :History<CR>
nnoremap <Leader>s :Rg<CR>

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif
set backupdir^=~/.vim/backup//
set undodir^=~/.vim/undo//
set directory^=~/.vim/swap//

" TODO detect based on file
set expandtab
set tabstop=4
set shiftwidth=4

" clear search highlighting & popups with esc
nnoremap <silent><esc> :noh<CR>:call popup_clear()<CR><esc>

" buffer next/prev
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[b :bprevious<CR>
" quickfix next/prev
nnoremap <silent>[q :cprevious<CR>
nnoremap <silent>]q :cnext<CR>
nnoremap <silent>[Q :cfirst<CR>
nnoremap <silent>]Q :clast<CR>

" center scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" center searches
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
" center jumps
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" paste without clobbering the delete registers
xnoremap <leader>p "_dP

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
packadd! editorconfig

set belloff=all

" python settings
let g:python_indent = {}
let g:python_indent.open_paren = 'shiftwidth()'
