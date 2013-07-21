" clojure-static plugin has a very quirky iskeyword which I override back to
" default here
set iskeyword=@,48-57,_,192-255,:,-

" syntax match clojureComment "(defn\s\+\S\+\_s\+\zs\"\_.\{-}\""
" syntax region clojureComment start=/(defn\s\+\S\+\_s\+"/hs=e,rs=e,ms=e end=/"$/
" syntax region clojureComment start=/(defn\s\+\S\+\_s\+\zs"/ end=/"$/
