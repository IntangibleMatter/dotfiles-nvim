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
   set syntax=arduino
endfunction
