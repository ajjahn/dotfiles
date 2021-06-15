lua require 'init'

filetype off                  " required

set rtp +=~/.config/nvim

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'moll/vim-bbye'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-scripts/EnhCommentify.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'easymotion/vim-easymotion'
Plug 'rizzatti/dash.vim'

"Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
"Plug 'machakann/vim-highlightedyank'

let g:polyglot_disabled = ['typescript']
Plug 'leafgarland/typescript-vim'
"Plug 'HerringtonDarkholme/yats.vim'

" Ruby block awareness: ar/ir
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

" Ruby block syntax toggling
Plug 'jgdavey/vim-blockle'

call plug#end()

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
augroup END

augroup SpellCheck
  au!
  au FileType markdown setlocal spell
  au FileType gitcommit setlocal spell
augroup END
set complete+=kspell

" Use Endwise for Ruby, manually add mapping here to avoid COC conflict
let g:endwise_no_mappings = 1
augroup vimrc-ruby-settings
  autocmd!
  autocmd FileType ruby imap <expr> <CR> pumvisible() ? "\<C-Y>\<Plug>DiscretionaryEnd" : "\<CR>\<Plug>DiscretionaryEnd"
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"speed
set noshowcmd
set noruler

set synmaxcol=128
set nofoldenable
set nowrap
" Force vim to use older regex engine.
" https://stackoverflow.com/a/16920294/655204
"set re=1
augroup Ruby
  au!
  au FileType ruby set re=1
augroup END

if has("nvim") " Configure UI Colors
  " This is only necessary if you use "set termguicolors".
  "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  "set termguicolors

  " fixes glitch? in colors when using vim with tmux
  "set t_Co=256
else
  set term=screen-256color
endif

colorscheme kolor
"colorscheme palenight
let g:palenight_terminal_italics=1
set guifont=Monaco:h12

"augroup ColorsForFileTypes " Map file extensions to the proper filetype
"  au!
"  au FileType typescript colorscheme Tomorrow-Night-Eighties
"augroup END


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

set lazyredraw

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


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

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
  if executable('ag')
    set grepprg=ag\ --nogroup
    let g:grep_cmd_opts = '--line-numbers --noheading'
    let g:ctrlp_user_command = 'ag %s -l -g ""'
    let g:ctrlp_use_caching = 0
  endif
endif

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.min.js;*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" zoom a vim pane like in tmux
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
" zoom back out
nnoremap <leader>= :wincmd =<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jj <ESC>

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

"set noexpandtab " Make sure that every file uses real tabs, not spaces
"set autoindent  " Copy indent from current line, over to the new line
"set shiftround  " Round indent to multiple of 'shiftwidth'
"set smartindent " Do smart indenting when starting a new line

" Set the tab width
let s:tabwidth=2
exec 'set tabstop='    .s:tabwidth
exec 'set shiftwidth=' .s:tabwidth
"exec 'set softtabstop='.s:tabwidth

" Don't break long lines in insert mode.
set formatoptions=l

if has("nvim") " Live substitution
  set inccommand=split
endif

" Command to remove trailing whitespace
command! Dwhitespace %s/\s*$//g

" Quick search and replace
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" bind K to search word under cursor
"nnoremap K :Ag \b<C-R><C-W>\b<CR>

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
map - :NERDTreeToggle<CR>

" convert hash rockets
nmap <leader>rh :%s/\v:(\w+) \=\>/\1:/g<cr>1

" Reload in safari
map <leader>l :w\|:silent !reload-safari<cr>\|:redraw!<cr>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX/LINTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ale_linters = {
"  \ 'eruby': ['ruumba'],
"  \ 'javascript': [],
"  \ 'typescript': [],
"\}
"let g:ale_fixers = {
"  \ 'ruby': ['rubocop', 'trim_whitespace'],
"  \ 'sh': ['shellcheck'],
"  \ 'javascript': [],
"\}
"let g:ale_enabled = 1
"let g:ale_fix_on_save = 1
"let g:ale_pattern_options = {
"\   '*schema\.rb$': {'ale_fix_on_save': 0, 'ale_fixers': []},
"\   'schema\.rb$': {'ale_fix_on_save': 0, 'ale_fixers': []},
"\}
"let g:ale_ruby_rubocop_executable = 'bundle'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CODE COMPLETION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dash Docset Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> doc <Plug>DashSearch

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