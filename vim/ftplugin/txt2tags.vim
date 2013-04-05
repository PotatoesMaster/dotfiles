" Vim filetype plugin

if exists('b:did_txt2tags')
  finish
endif
let b:did_txt2tags = 1

set et

" Fix txt2tags ugly highlighting
hi link t2tTitle Title
hi link t2tTitleMark t2tTitle
hi link t2tNumTitle t2tTitle
hi link t2tNumTitleMark t2tTitle
hi link t2t_Verb Identifier
hi link t2t_Raw PreProc
hi! link t2tComment Comment
