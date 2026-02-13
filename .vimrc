" -----------------------------------------------------------------------------
" This has to come first -- do not change order
" Vundle initialization
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" color schemes
Plug 'AKurilin/vim-colorschemes'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'tomtom/tlib_vim'
Plug 'AKurilin/matchit.vim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

if has('nvim')
  " Javascript / Typescript syntax
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-lualine/lualine.nvim'
endif

" Markdown
Plug 'tpope/vim-markdown'

" Quickfix / Location list toggle
Plug  'milkypostman/vim-togglelist'

" Ansi Colors support
Plug 'vim-scripts/AnsiEsc.vim'

" Mustache syntax support
Plug 'juvenn/mustache.vim'

" advanced ga character info
Plug 'tpope/vim-characterize'

" vim easymotion
Plug 'Lokaltog/vim-easymotion'

" call vundle#end()
call plug#end()
" -----------------------------------------------------------------------------

" syntax have to come first so that ftplugin folder is the one running last
syntax on
filetype on
filetype indent on
filetype plugin on

" prevents creation of .swp (use :w more, son)
set noswapfile
set backupdir-=.
set backupdir^=/tmp

" turns sounds off
set vb t_vb=

" prevents certain security exploits
set modelines=0

set viminfo^=!

set ignorecase
set smartcase

set cf
set history=256

set autowrite
set ruler
set nu
set nowrap
set timeoutlen=1000
set hidden

set tabstop=2
set backspace=2
set shiftwidth=2
set softtabstop=2
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr

" These MUST be disabled
set nocindent
set nosmartindent
set autoindent
set smarttab
set expandtab
set textwidth=80
set colorcolumn=+1

" vertical and horizontal line highlighting
set cursorline
set cursorcolumn

set showmatch
set mat=5
set list

" disable code folding
set nofoldenable

" " GVim-specific
" " Will remove the toolbar
" set guioptions-=m
" set guioptions-=T
" set guioptions-=r
" " text-style tabs
" set guioptions=agi

" make tabs and trailing spaces visible
set lcs=tab:»·,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" colorschemes
colorscheme desert
silent! colorscheme earendel

" map jk and kj to equal Esc
:inoremap jk <Esc>
:inoremap kj <Esc>

" tpope's buffer navigation shortcuts
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" flip through the arglist
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" switch between tabs analogously to the above
nnoremap <silent> [t :tabprev<CR>
nnoremap <silent> ]t :tabnext<CR>

" switch between quickfix list entries
nnoremap <silent> [c :cprev<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap <silent> [C :cfirst<CR>
nnoremap <silent> ]C :clast<CR>

" switch between quickfix list entries
nnoremap <silent> [x :lprev<CR>
nnoremap <silent> ]x :lnext<CR>
nnoremap <silent> [X :lfirst<CR>
nnoremap <silent> ]X :llast<CR>

" easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" RELATIVE NUMBERS
au BufEnter * setl relativenumber

" " Always show line numbers, but only in current window.
:au WinEnter * :setlocal relativenumber
:au WinLeave * :setlocal number

" Absolute Line Numbers in Insert Mode
:au InsertEnter * :setlocal number
:au InsertLeave * :setlocal relativenumber

function! NumberToggle()
  if(&relativenumber == 1)
    setlocal number
  else
    setlocal relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Git gutter turn off by default
let g:gitgutter_enabled = 0

" vim2hs
let g:haskell_conceal = 0

"
" vim-easymotion
"
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
"
" map <Leader>l <Plug>(easymction-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<Bar>doautocmd <nomodeline> FileType<CR>

" center screen on these keys
nnoremap N Nzz
nnoremap n nzz
nnoremap { {zz
nnoremap } }zz

" make the screen advance up or down when within n lines of the edge
set scrolloff=10

" move up and down by line, not row, useful when :wrap option is set
nnoremap j gj
nnoremap k gk
" move up and down by row with these commands
nnoremap gj j
nnoremap gk k

" remove commands we never use
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" remove startup message
set shortmess+=I

" make filename completion be like in bash
set wildignorecase
set wildmode=longest,list,full

" make split appear in the more intuitive location
set splitbelow
set splitright

"
" NEOVIM specific
"

" block cursor in normal mode, pipe in insert mode
" NB: only works for later versions of gnome terminal
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" FZF
" relies on fzf binary being present on the PATH somewhere
" \\t fuzzy file matching
nnoremap <leader>t :<C-u>Files<CR>

if executable('rg')
  let $FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
endif

if has('nvim')
lua << EOF
local ok, configs = pcall(require, 'nvim-treesitter.configs')
if ok then
  configs.setup({
    ensure_installed = {
      "bash",
      "css",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
  })
end
EOF
endif

" open tag definition in a new vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Lualine
if has('nvim')
lua << EOF
local ok, lualine = pcall(require, 'lualine')
if ok then
  lualine.setup({})
end
EOF
endif
