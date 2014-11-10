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
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/unite.vim'
Plugin 'bling/vim-airline'
Plugin 'AKurilin/matchit.vim'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
" Plugin 'vim-scripts/paredit.vim'
Plugin 'AKurilin/paredit.vim'
Plugin 'amdt/vim-niji'

" Haskell plugins
Plugin 'dag/vim2hs'
Plugin 'merijn/haskellFoldIndent'
Plugin 'eagletmt/neco-ghc'
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

" " Syntastic - run in passive mode i.e. don't check on each save
" let g:syntastic_mode_map = { 'mode': 'passive',
"   \ 'active_filetypes': [],
"   \ 'passive_filetypes' : [],
"   \ }

"
" CtrlP
"
" see help ctrlp_prompt_mappings for full list of commands!
" c-h isn't equal to backspace by default, gotta fix that
" let g:ctrlp_prompt_mappings = {
"   \ 'PrtBS()':              ['<bs>', '<c-h>', '<c-]>'],
"   \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
"   \ }

" let g:ctrlp_custom_ignore = '\vnode_modules\/.*'

" ignore certain folders and file types
" set wildignore+=*/target/*,*.so,*.swp,*.zip,*.jar,*.hi,*.o,*.dyn_hi,*.dyn_o,*.jpg,*.png

"
" Unite.vim
"
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" force unite to use ag if available - this overrides the default unite behavior
" that ignores .gitignore with ag's default behavior that leverages .gitignore
if executable('ag')
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
endif

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)

  " enable closing of unite buffer from insert mode
  imap <buffer> <C-c>   <Plug>(unite_exit)
endfunction

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

" Syntastic
let g:syntastic_haskell_checkers = ['hlint']
let g:syntastic_haskell_hlint_args = '-i "Eta reduce" -i "Use if"'

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
