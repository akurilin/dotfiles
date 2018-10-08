" -----------------------------------------------------------------------------
" This has to come first -- do not change order
" Vundle initialization
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

Plugin 'bzx/vim-theme-pack'
Plugin 'AKurilin/vim-colorschemes'
Plugin 'tpope/vim-commentary'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-surround'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'tpope/vim-repeat'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/CSApprox'
Plugin 'w0rp/ale'
Plugin 'benekastah/neomake'
Plugin 'bling/vim-airline'
Plugin 'AKurilin/matchit.vim'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Haskell plugins
Plugin 'dag/vim2hs'
Plugin 'merijn/haskellFoldIndent'
" ghc-mod is no longer supported in modern GHCs
" Plugin 'eagletmt/neco-ghc'
Plugin 'pbrisbin/html-template-syntax'
Plugin 'bitc/vim-hdevtools' " requires cabal install hdevtools

" !!! THIS REQUIRES A SEPARATE COMPILATION STEP
Plugin 'Shougo/vimproc.vim'
" ghc-mod is no longer supported in modern GHCs
" Plugin 'eagletmt/ghcmod-vim'

" Markdown
Plugin 'tpope/vim-markdown'

" Ack / AG grep support
Plugin 'mileszs/ack.vim'

" Quickfix / Location list toggle
Plugin  'milkypostman/vim-togglelist'

" Ansi Colors support
Plugin 'vim-scripts/AnsiEsc.vim'

" Mustache syntax support
Plugin 'juvenn/mustache.vim'

" advanced ga character info
Plugin 'tpope/vim-characterize'

" Marks git diff lines
Plugin 'airblade/vim-gitgutter'

" Ansible YAML
" Plugin 'chase/vim-ansible-yaml'
" Plugin 'ingydotnet/yaml-vim'

" vim easymotion
Plugin 'Lokaltog/vim-easymotion'

" vim-index-guides
Plugin 'nathanaelkane/vim-indent-guides'

call vundle#end()
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

set omnifunc=syntaxcomplete#Complete

" GVim-specific
" Will remove the toolbar
set guioptions-=m
set guioptions-=T
set guioptions-=r
" text-style tabs
set guioptions=agi

" make tabs and trailing spaces visible
set lcs=tab:»·,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

" colorschemes
colorscheme desert

silent! colorscheme earendel

if has('gui_running')
  "   "set guifont=Consolas:h12
  if has("gui_gtk2")
    set guifont=DejaVu\ Sans\ Mono\ 10
  else
    set guifont=DejaVu_Sans_Mono:h10:cANSI
  endif
endif

" map jk and kj to equal Esc
:inoremap jk <Esc>
:inoremap kj <Esc>

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

" PWD will always be that of the currently selected file.
" Play with it for a bit and see how that works out.
" set autochdir

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

" easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Fireplace
nnoremap <S-F5> :Require!<CR>
nnoremap <F5> :Require<CR>

" vim-clojure-static
let g:clojure_align_multiline_strings = 1

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

" Ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" Git gutter turn off by default
let g:gitgutter_enabled = 0

" vim2hs
let g:haskell_conceal = 0

" " Syntastic
" let g:syntastic_haskell_checkers = ['hlint']
" let g:syntastic_haskell_hlint_args = '-i "Eta reduce" -i "Use if"'

" Neomake
"
" let g:neomake_haskell_enabled_makers = ['ghcmod']
" " let g:neomake_haskell_hlint_maker = {
" "     \ 'args': ['-i "Eta reduce" -i "Use if"'],
" "     \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
" "     \ }
autocmd! BufWritePost * Neomake

" vim-hdevtools
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>


" let g:syntastic_aggregate_errors = 1

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
" map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

map <Leader>v :e ~/.vimrc<CR>

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
" NB: requires env var set in bashrc to use AG to find files, that way
" .gitignore is respected
nnoremap <leader>t :<C-u>FZF<cr>

" w0rp/ale
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_open_list = 1
