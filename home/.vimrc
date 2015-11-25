syntax on
syntax enable
set nocompatible
filetype off
filetype plugin indent on

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/Users/u524/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('/Users/u524/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/vimwiki'

call neobundle#end()
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" Set color, miscellaneous formatting options
set background=light
colorscheme solarized
set autoindent
set number
set ruler
set encoding=utf-8
set colorcolumn=120
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" HTML specific
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" Cool mappings
let mapleader = ","
imap jj <Esc>

" Script exec shortcuts
map <Leader>r :!ruby %<CR>
map <Leader>p :!python %<CR>
map <Leader>t :!/Users/u524/work/sse_tests/bin/run.sh %<CR>

" Nerttree shortcuts
map <Leader>n :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" vimwiki config
filetype plugin on
map <Leader>d :VimwikiToggleListItem<CR>
let g:vimwiki_list = [{'path': '/Users/u524/vimwiki/'}]

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" close all open buffers if the only one left is NERDTree
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Cursor restore
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" show and strip extra whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$/ containedin=ALL
autocmd BufWritePre *.py,*.xml :%s/\s\+$//e

setlocal nospell
augroup END
