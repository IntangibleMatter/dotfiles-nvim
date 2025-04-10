" set syntax=arduino
if exists("b:did_ftplugin")
   finish
endif

augroup pdeSyntax
   au!
   autocmd Syntax          <buffer> call SetPdeSyntax()
augroup END
function! SetPdeSyntax()
   " remove the augroup
   au! pdeSyntax
   setlocal syntax=java
   setlocal shiftwidth=4
   setlocal softtabstop=4
   setlocal tabstop=4
   setlocal expandtab
endfunction
