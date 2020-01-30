filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tommcdo/vim-exchange'
Plugin 'jeetsukumaran/vim-filebeagle'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'moll/vim-bbye'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/EnhCommentify.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'elixir-lang/vim-elixir'
Plugin 'w0rp/ale'

" Fuzzy Commands + AG
Plugin 'junegunn/fzf.vim'

" Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

" Ruby block awareness: ar/ir
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'

" Ruby block syntax toggling
Plugin 'jgdavey/vim-blockle'

" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

call vundle#end()
" --- END Vundle Config ---


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASE CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Required for textobj-user
runtime macros/matchit.vim

" Add runtime path for FZF
set rtp+=/usr/local/opt/fzf

" Enable filetype detection
filetype plugin indent on

" Restore cursor position in irb
au BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Source the vimrc file after saving it
augroup VimRC
  au!
  au BufWritePost .vimrc source $MYVIMRC
augroup END
set exrc " source local .vimrc files

if !has("nvim")
  set ttyfast
  set nocompatible
  set autoread
endif

augroup FileTypes " Map file extensions to the proper filetype
  au!
  au BufNewFile,BufRead *.stache set filetype=mustache
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  au BufNewFile,BufRead *.md set filetype=markdown
augroup END

augroup SpellCheck
  au!
  au FileType markdown setlocal spell
  au FileType gitcommit setlocal spell
augroup END
set complete+=kspell


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("nvim") " Configure UI Colors
  set termguicolors
else
  set term=screen-256color
endif

colorscheme kolor
set guifont=Monaco:h12

syntax on " Enable syntax highlighting
set rnu " Use relative line numbers
set number " Display the current line number

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
set winwidth=81

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Highlight cursor line only in current pane
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUFFER HANDLING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowritebackup
set noswapfile
set autowriteall
set hidden


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPLITS & NAVIGATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright
set diffopt+=vertical " Prefer vertical splits when diffing

" Navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <BS> <C-W><C-H>

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup
  let g:grep_cmd_opts = '--line-numbers --noheading'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.min.js;*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jj <ESC>

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

" Command to remove trailing whitespace
command! Dwhitespace %s/\s*$//g

" Quick search and replace
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" bind K to search word under cursor
nnoremap K :Ag \b<C-R><C-W>\b<CR>

" Lazy Line Move
" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" Normal mode
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==

" System clipboard shortcuts [http://stackoverflow.com/a/30489686/1279177]
noremap ty "+y
" copy a whole line to the clipboard
noremap tY "+Y
" put the text from clipboard after the cursor
noremap tp "+p
" put the text from clipboard before the cursor
noremap tP "+P

" Remove a buffer, keep split (with vim-bbye plugin)
nnoremap <Leader>d :Bdelete <CR>

" Easy comment toggle
nmap <C-x> <Plug>Traditional
vmap <C-x> <Plug>VisualTraditional
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyUseBlockIndent = 'Yes'

" Open NERD Tree
map <F10> :NERDTreeToggle<CR>
map <TAB> :NERDTreeToggle<CR>

" convert hash rockets
nmap <leader>rh :%s/\v:(\w+) \=\>/\1:/g<cr>1

" Reload in safari
map <leader>l :w\|:silent !reload-safari<cr>\|:redraw!<cr>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX/LINTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_fixers = {
  \ 'javascript': ['standard'],
  \ 'ruby': ['rubocop'],
  \ 'elixir': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_enabled = 1
let g:ale_fix_on_save = 1

augroup Fixers
  au!
  au BufWritePost *.js silent !standard --fix %
  au BufWritePost *.jsx silent !standard --fix %
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CODE COMPLETION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
" https://github.com/garybernhardt/dotfiles/blob/33be2d73d2ed51b64c7813d611e0190c9afaaa1c/.vimrc#L198-L209
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>
