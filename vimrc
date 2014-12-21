set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-projectionist'
Plugin 'jiangmiao/auto-pairs'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'dkprice/vim-easygrep'
Plugin 'kien/ctrlp.vim'

call vundle#end()    
filetype plugin indent on

" Non-Plugin config after this line...
execute pathogen#infect()
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set number
colorscheme railscasts
set directory=~/.vim/swaps
set backupdir=~/.vim/backups
set guifont=Monaco:h12
set undodir=~/.vim/undo
set splitbelow
set splitright
"set cursorline for current pane
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" tmux will only forward escape sequences to the terminal if surrounded by a
" DCS sequence
" "
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
  
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Airline Config
" display buffers when no tabs open
let g:airline#extensions#tabline#enabled = 1

inoremap jj <ESC>
