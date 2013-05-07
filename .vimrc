" -----------------------------------------------------------------------------
" This has to come first -- do not change order
" Vundle initialization
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'bzx/vim-theme-pack'
Bundle 'vim-scripts/vimwiki'
Bundle 'tpope/vim-commentary'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-surround'
" Bundle 'tpope/vim-rails'
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-entire'
Bundle 'tpope/vim-repeat'
Bundle 'vim-ruby/vim-ruby'
" Bundle 'scrooloose/nerdtree'
" Bundle 'vim-scripts/VimClojure'
" Bundle 'edsono/vim-matchit'
" Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/CSApprox'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'

" c-_ to close nearest tag above
" crashes...
" Bundle 'vim-scripts/closetag.vim'

" allows to % between opening and closing tags
Bundle 'AKurilin/matchit.vim'
" Bundle 'airblade/vim-gitgutter'

" Clojure
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
Bundle 'vim-scripts/paredit.vim'
" -----------------------------------------------------------------------------

filetype on
filetype plugin on
filetype indent on

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

" ignores case by default in search and CtrlP
set ignorecase

set cf
set history=256

set autowrite
set ruler
set nu
set nowrap
set timeoutlen=250
set hidden

set ts=2
set bs=2
set shiftwidth=2
set softtabstop=2
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
" set cindent
" set autoindent
set smarttab
set expandtab
autocmd FileType * set textwidth=80
autocmd FileType html set textwidth=0
set colorcolumn=81

set showmatch
set mat=5
set list

" GVim-specific
" Will remove the toolbar
set guioptions-=T
" text-style tabs
set guioptions=agim

" Show $ at end of line and trailing space as ~
" not sure I'm really hot about this one, saving edited version 
" set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set lcs=tab:\ \ ,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

" colorschemes
colorscheme desert
colorscheme earendel
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

" vimwiki let g:vimwiki_list = [{'path': '$DROPBOX/vimwiki/' , 
" 'path_html': '$DROPBOX/vimwiki_html/', 'ext': '.wiki', 
" 'template_path': '$DROPBOX/vimwiki/templates/'}]

" tpope's buffer navigation shortcuts
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" switch between tabs analogously to the above
nnoremap <silent> [t :tabprev<CR>
nnoremap <silent> ]t :tabnext<CR>

" easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" if has("autocmd")
"   " ruby specific settings
"   autocmd FileType ruby set textwidth=79 colorcolumn=80
" endif

" override default settings by filetype
" autocmd FileType html source ~/Dropbox/vim/html.vim

" Syntastic - run in passive mode i.e. don't check on each save
let g:syntastic_mode_map = { 'mode': 'passive',
  \ 'active_filetypes': [],
  \ 'passive_filetypes' : [],
  \ }

" CtrlP
" see help ctrlp_prompt_mappings for full list of commands!
" c-h isn't equal to backspace by default, gotta fix that
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<bs>', '<c-h>', '<c-]>'],
  \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
  \ }

" vim-paredit
" let g:paredit_leader = "\\"


