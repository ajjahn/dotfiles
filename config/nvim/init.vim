" fix diagnostic underline, virtual text and float diagnostic colors
" tune completion
" endwise ruby
" git-worktree
" telescope-github
" vimspector

let g:polyglot_disabled = ['typescript']
lua require 'init'

filetype off                  " required

set rtp +=~/.config/nvim

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
"set noshowcmd
"set noruler

"set synmaxcol=128
"set nofoldenable
"set nowrap
" Force vim to use older regex engine.
" https://stackoverflow.com/a/16920294/655204
"set re=1
augroup Ruby
  au!
  au FileType ruby set re=1
  "autocmd BufWritePre * !git diff --name-only | grep .rb | xargs -r rubocop -a
  "autocmd BufWritePost * !rubocop -a %
augroup END

if (has("termguicolors"))
  set termguicolors
endif
if has("nvim") " Configure UI Colors
  " This is only necessary if you use "set termguicolors".
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors

  " fixes glitch? in colors when using vim with tmux
  "set t_Co=256
else
  set term=screen-256color
endif

"colorscheme kolor
"colorscheme palenight
let g:palenight_terminal_italics=1
set guifont=Monaco:h12

"augroup ColorsForFileTypes " Map file extensions to the proper filetype
"  au!
"  au FileType typescript colorscheme Tomorrow-Night-Eighties
"augroup END


syntax on " Enable syntax highlighting
"set rnu " Use relative line numbers
"set number " Display the current line number

" Make it obvious where 80 characters is
"set textwidth=80
"set colorcolumn=+1
"set winwidth=81

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

augroup GoddamnTabs
  autocmd!
  autocmd FileType go set noexpandtab
  set list listchars=tab:\ \ ,trail:·,nbsp:·
augroup END

" Highlight cursor line only in current pane
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

set lazyredraw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUFFER HANDLING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set nobackup
"set nowritebackup
"set noswapfile
"set autowriteall
"set hidden


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPLITS & NAVIGATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set splitbelow
"set splitright
"set diffopt+=vertical " Prefer vertical splits when diffing

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

" zoom a vim pane like in tmux
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
" zoom back out
nnoremap <leader>= :wincmd =<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set noexpandtab " Make sure that every file uses real tabs, not spaces
"set autoindent  " Copy indent from current line, over to the new line
"set shiftround  " Round indent to multiple of 'shiftwidth'
"set smartindent " Do smart indenting when starting a new line

" Set the tab width
let s:tabwidth=2
exec 'set tabstop='    .s:tabwidth
exec 'set shiftwidth=' .s:tabwidth
"exec 'set softtabstop='.s:tabwidth

" Don't break long lines in insert mode. Allow formating comments. See :help
" fo-table
set formatoptions=l,c,q

"if has("nvim") " Live substitution
"  set inccommand=split
"endif

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

" Remove a buffer, keep split
nnoremap <Leader>d :bp\|bd #<CR>

" Fast switch to alternate file
nnoremap <BS> <C-^>

" Easy comment toggle
nmap <C-x> <Plug>Traditional
vmap <C-x> <Plug>VisualTraditional
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyUseBlockIndent = 'Yes'

" Open NERD Tree
"map <F10> :NERDTreeToggle<CR>
"map - :NERDTreeToggle<CR>

"let NERDTreeIgnore=['\.pyc$', '__pycache__']

" convert hash rockets
nmap <leader>rh :%s/\v:(\w+) \=\>/\1:/g<cr>1

" Reload in safari
map <leader>l :w\|:silent !reload-safari<cr>\|:redraw!<cr>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

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

" vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "dispatch"

nmap <silent> cn :cn<CR>
nmap <silent> cp :cp<CR>
