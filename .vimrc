call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
call plug#end()

syntax on
set smarttab
" 设置tab符长度为4个空格
set tabstop=4
" 设置换行自动缩进长度为4个空格
set shiftwidth=4
" 设置tab符自动转换为空格
set expandtab
" 设置智能缩进，其他可选缩进方式：autoindent, cindent, indentexpr
set smartindent
" 设置显示行号，关闭行号显示命令：set nonumber
set number
" 设置配色方案
" colorscheme desert

" 设置NerdTree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

"SET Comment START

autocmd BufNewFile *.h,*.c,*.cpp exec ":call SetComment()" |normal 10Go
func SetComment()
    if expand("%:e") == 'h'
        call setline(1, '//head file')
    elseif expand("%:e") == 'c'
        call setline(1, '//C file')
    elseif expand("%:e") == 'cpp'
        call setline(1, '//C++ file')
    endif
    call append(1, '')
    call append(2, '//================================================')
    call append(3, '//')
    call append(4, '//      Filename: '.RemoveDirName(expand("%")))
    call append(5, '//')
    call append(6, '//        Author: sphc - jinkai0916@outlook.com')
    call append(7, '//   Description: ---')
    call append(8, '//       Created: '.strftime("%Y-%m-%d %H:%M:%S"))
    call append(9, '// Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
    call append(10, '//================================================')
    call append(11, '')
    "call setline(11, ' ')
    if expand("%:e") == 'h'
        call append(12, '#ifndef '.toupper(SplitName((expand("%:r")))).'__H')
        call append(13, '#define '.toupper(SplitName((expand("%:r")))).'__H')
        call append(14, '')
        call append(15, '')
        call append(16, '')
        call append(17, '#endif')
    elseif expand("%:e") == 'c'
        call append(12, 'int main(void)')
        call append(13, '{')
        call append(14, '    return 0;')
        call append(15, '}')
    elseif expand("%:e") == 'cpp'
        call append(12, 'int main()')
        call append(13, '{')
        call append(14, '    return 0;')
        call append(15, '}')
    endif
endfunc

map <F2> :call SetComment()<CR>:10<CR>o
"SET Comment END

"SET Last Modified Time START
func DataInsert()
    call cursor(10,1)
    if search ('Last Modified') != 0
        let line = line('.')
        call setline(line, '// Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
    endif
endfunc

autocmd FileWritePre,BufWritePre *.h,*.c,*.cpp ks|call DataInsert() |'s
"SET Last Modified Time END

" function SplitName
func SplitName(name)
    let str = ""
    if 0 < len(a:name) 
        let str = join([str, a:name[0]], "")
    endif
    
    let i = 1
    while i < len(a:name)
        if toupper(a:name[i]) == a:name[i]
            let str = join([str, "_"], "")
        endif
        let str = join([str, a:name[i]], "")
        let i += 1
    endwhile       
    return str
endfunc

" function RemoveDirName
func RemoveDirName(name)
    let str = ""
    let i = 0
    while i < len(a:name)
        if "/" == a:name[i]
            let str = ""
        else
            let str = join([str, a:name[i]], "")
        endif
        let i += 1
    endwhile       
    return str
endfunc
