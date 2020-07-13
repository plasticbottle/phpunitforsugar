function! RunPHPUnitTest(filter)
    cd %:p:h
    if a:filter
        normal! T yw
        let result = system("../../../vendor/bin/phpunit --filter " . @" . " " . bufname("%"))
    else
        let result = system("../../../vendor/bin/phpunit " . bufname("%"))
    endif
    split __PHPUnit_Result__
    normal! ggdG
    setlocal buftype=nofile
    call append(0, split(result, '\v\n'))
    cd -
endfunction
 
nnoremap <leader>u :call RunPHPUnitTest(0)<cr>
nnoremap <leader>f :call RunPHPUnitTest(1)<cr>
nnoremap <leader>p :s/\%#/\=repeat(" ", 4)/<cr>

function! AddSeparateProcessText(where)
    call append(a:where+0, "/*")
    call append(a:where+1, "*@runInSeparateProcess")
    call append(a:where+2, "*/")
endfunction

command! -nargs=1 R :call AddSeparateProcessText(<q-args>)
