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
Plugin 'vim-scripts/vimwiki'
Plugin 'tpope/vim-commentary'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-surround'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'tpope/vim-repeat'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/CSApprox'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'bling/vim-airline'
Plugin 'AKurilin/matchit.vim'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'vim-scripts/paredit.vim'
Plugin 'kien/rainbow_parentheses.vim'

" Haskell plugins
Plugin 'dag/vim2hs'
Plugin 'merijn/haskellFoldIndent'
" neco-ghc
Plugin 'pbrisbin/html-template-syntax'

" !!! THIS REQUIRES A SEPARATE COMPILATION STEP
Plugin 'Shougo/vimproc.vim'
Plugin 'eagletmt/ghcmod-vim'

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
Plugin 'chase/vim-ansible-yaml'

call vundle#end()
" -----------------------------------------------------------------------------

filetype on
filetype indent on
filetype plugin on

" prevents creation of .swp (use :w more, son)
set noswapfile

" turns sounds off
set vb t_vb=

" prevents certain security exploits
set modelines=0

" vim-ruby
compiler ruby

syntax on

set viminfo^=!

let g:rails_default_file='config/database.yml'

syntax on

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
" set autoindent
set smarttab
set expandtab
set textwidth=80
set colorcolumn=81

" vertical and horizontal line highlighting
set cursorline
set cursorcolumn

set showmatch
set mat=5
set list

" disable code folding
set nofoldenable

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

" " Syntastic - run in passive mode i.e. don't check on each save
" let g:syntastic_mode_map = { 'mode': 'passive',
"   \ 'active_filetypes': [],
"   \ 'passive_filetypes' : [],
"   \ }

" CtrlP
" see help ctrlp_prompt_mappings for full list of commands!
" c-h isn't equal to backspace by default, gotta fix that
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<bs>', '<c-h>', '<c-]>'],
  \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
  \ }

let g:ctrlp_custom_ignore = '\vnode_modules\/.*'

" ignore certain folders and file types
set wildignore+=*/target/*,*.so,*.swp,*.zip,*.jar,*.hi,*.o,*.dyn_hi,*.dyn_o,*.jpg,*.png

" Fireplace
nnoremap <S-F5> :Require!<CR>
nnoremap <F5> :Require<CR>

" vim-clojure-static
let g:clojure_align_multiline_strings = 1

" Clojure Parentheses
silent! au VimEnter * RainbowParenthesesToggle
silent! au Syntax   * RainbowParenthesesLoadRound
silent! au Syntax   * RainbowParenthesesLoadSquare
silent! au Syntax   * RainbowParenthesesLoadBraces
  " let g:rbpt_loadcmd_toggle = 0
  "

" let g:rbpt_colorpairs = [
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid1'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['darkmagenta', 'DarkOrchid1'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid1'],
"     \ ['red',         'firebrick3'],
"     \ ]

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

" vimwiki let g:vimwiki_list = [{'path': '$DROPBOX/vimwiki/' ,
" 'path_html': '$DROPBOX/vimwiki_html/', 'ext': '.wiki',
" 'template_path': '$DROPBOX/vimwiki/templates/'}]
source ~/.vimrc.vimwiki

" Git gutter turn off by default
let g:gitgutter_enabled = 0

" vim2hs
let g:haskell_conceal = 0

" Syntastic
let g:syntastic_haskell_checkers = ['hlint']
