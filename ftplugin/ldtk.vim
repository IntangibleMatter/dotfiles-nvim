if exists("b:did_ftplugin")
   finish
endif

augroup ldtkSyntax
   au!
   autocmd Syntax          <buffer> call SetLdtkSyntax()
augroup END
function! SetLdtkSyntax()
   " remove the augroup
   au! ldtkSyntax
   set syntax=json
endfunction
