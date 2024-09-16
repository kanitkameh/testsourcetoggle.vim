" don't source if already sourced
if exists('g:loaded_toggle_test_source')
    finish
endif
let g:loaded_toggle_test_source = 1

function! TestSourceToggle()
    let l:current_file = expand('%')
    if l:current_file =~ 'src/main'
        let l:current_file = substitute(l:current_file, 'src/main', 'src/test', '')
        let l:current_file = substitute(l:current_file, '\.scala$', 'Spec.scala', '')
    else
        let l:current_file = substitute(l:current_file, 'src/test', 'src/main', '')
        let l:current_file = substitute(l:current_file, 'Spec\.scala$', '.scala', '')
    endif
    
    let l:dir = fnamemodify(l:current_file, ':h')
    if !isdirectory(l:dir)
        call mkdir(l:dir, 'p')
    endif

    execute 'edit ' . l:current_file
endfunction

command -nargs=0 TestSourceToggle call TestSourceToggle()
