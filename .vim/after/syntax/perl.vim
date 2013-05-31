" From http://blogs.perl.org/users/ovid/2011/06/syntax-highlight-your-sql-heredocs-in-vim.html
let s:bcs = b:current_syntax
unlet b:current_syntax
syntax include @SQL syntax/sql.vim
let b:current_syntax = s:bcs
syntax region perlHereDocSQL start=+<<SQL.*;\s*$+ end=+^\s*SQL$+ contains=@SQL
