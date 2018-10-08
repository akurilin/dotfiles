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
