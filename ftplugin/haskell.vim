" Tab specific option
setlocal tabstop=2                   "A tab is 8 spaces
setlocal expandtab                   "Always uses spaces instead of tabs
setlocal softtabstop=2               "Insert 4 spaces when tab is pressed
setlocal shiftwidth=2                "An indent is 4 spaces
setlocal smarttab                    "Indent instead of tab at start of line
setlocal shiftround                  "Round spaces to nearest shiftwidth multiple
setlocal nojoinspaces                "Don't convert spaces to tabs
setlocal tw=120
setlocal iskeyword-=.

setlocal omnifunc=necoghc#omnifunc

" w0rp/ale
let b:ale_linters = ['hlint']
let b:ale_fixers = ['hlint', 'brittany', 'stylish-haskell']
let b:ale_haskell_hlint_executable='stack'
let b:ale_haskell_brittany_executable='stack'
let b:ale_haskell_stylish_haskell_executable='stack'

" Tags
" not sure I'm actually using this
" let b:fzf_tags_command = 'fast-tags -v'

" Haskell Vim
let b:haskell_enable_quantification = 1 "to enable highlighting of forall
let b:haskell_enable_recursivedo = 1 "to enable highlighting of mdo and rec
let b:haskell_enable_arrowsyntax = 1 "to enable highlighting of proc
let b:haskell_enable_pattern_synonyms = 1 "to enable highlighting of pattern
let b:haskell_enable_typeroles = 1 "to enable highlighting of type roles

" " Haskell Indentation
" let g:haskell_indent_before_where = 1
" let g:haskell_indent_after_bare_where = 2
" let g:haskell_indent_in = 0
"
" renegerate ctags through fast-tags in a folder that stack can work with
" nnoremap <F5> :call jobstart('find . -not -path "*/\.*" -type f -name "*.hs" -exec stack exec -- fast-tags -v {} +')<CR>
nnoremap <F5> :! find . -not -path "*/\.*" -type f -name "*.hs" -exec stack exec -- fast-tags -v {} +<CR>

" vim-hdevtools
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
