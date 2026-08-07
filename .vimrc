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

" System-agnostic setting making the unnamed clipboard register act like
" clipboard in any other editor. <https://news.ycombinator.com/item?id=40388040>
if has('unnamedplus')
  set clipboard=unnamedplus,unnamed
else
  set clipboard+=unnamed
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

" buffer next/prev
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[b :bprevious<CR>
" quickfix next/prev
nnoremap <silent>[q :cprevious<CR>
nnoremap <silent>]q :cnext<CR>
nnoremap <silent>[Q :cfirst<CR>
nnoremap <silent>]Q :clast<CR>
" accept "file:lineno" as a format for manual qfix lists
set errorformat+=%f:%l

" paste without clobbering the delete registers
xnoremap <leader>p "_dP

" yank file path
nnoremap yp :let @+ = expand("%:p:~")<CR>

" yank file name
nnoremap yf :let @+ = expand("%:t")<CR>

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
if version >= 901
  packadd! editorconfig
endif

set belloff=all

" python settings
let g:python_indent = {}
let g:python_indent.open_paren = 'shiftwidth()'

" templates
autocmd BufNewFile  main.c,test.c	0r ~/.vim/templates/skeleton.c

" plugins
call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'michaeljsmith/vim-indent-object'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

function! OpenDailyFile()
  let year  = strftime('%Y')
  let month = strftime('%m')
  let day   = strftime('%d')

  let dir = year . '/' . month
  let file = dir . '/' . day

  call mkdir(dir, 'p')
  let is_new_file = !filereadable(file)

  " Open the file (creates it on write if it doesn't exist).
  execute 'edit' fnameescape(file)
  if is_new_file
    call append(0, [
          \ 'Notes for ' . strftime('%a ') . strftime('%Y-%m-%d'),
          \ '========================',
          \ ''
          \ ])
  endif
  setlocal filetype=markdown
endfunction

command! Daily call OpenDailyFile()

if !exists('*ResourceMyVimrc')
  function! ResourceMyVimrc()
    source $MYVIMRC
  endfunction
endif

command! Resource call ResourceMyVimrc()

if !has('nvim')
  " clear search highlighting & popups with esc
  nnoremap <silent><esc> :noh<CR>:call popup_clear()<CR><esc>
else
  nnoremap <silent><esc> :noh<CR><esc>
endif
