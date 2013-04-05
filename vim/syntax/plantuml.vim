" Vim syntax file
" Language: PlantUML

if exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword syntaxKeywords activate deactivate participant actor title
syn match   syntaxKeywords 'note \(right\|left\)'
syn match   syntaxKeywords 'end note'
syn match   quotedStrings  '".\+"'
syn keyword conjunctions   as
syn match   conjunctions   ':'
syn match   syntaxKeywords '^@.\+uml$'
syn match   operators      '-\?->>\?'
syn match   specialChars   '\\.'
syn match   comments       "^'.\+"

" Constants 

" Regions
syn region activationBlock start="activate" end="deactivate" fold transparent contains=syntaxKeywords
syn region headerLine start="==" end="=="

let b:current_syntax = 'plantuml'

" Highlighting
hi def link syntaxKeywords   Statement
hi def link operators        Operator
hi def link headerLine       Title
hi def link conjunctions     Ignore
hi def link specialChars     SpecialChar
hi def link quotedStrings    String
hi def link unquotedStrings  String
hi def link comments         Comment
