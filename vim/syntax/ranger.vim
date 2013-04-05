if exists("b:current_syntax")
    finish
endif

runtime syntax/vim.vim

syn match rangerComment	"#.*$"

" Highlighting
hi def link rangerComment vimComment
