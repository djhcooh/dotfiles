set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  endif
    call neobundle#begin(expand('~/.vim/bundle/'))
    
    " originalrepos on github
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'VimClojure'
    NeoBundle 'Shougo/vimshell'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'jpalardy/vim-slime'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'derekwyatt/vim-scala'
    NeoBundle 'jiangmiao/auto-pairs'

    " https://github.com/Shougo/neocomplete.vim
    NeoBundle 'Shougo/neocomplete.vim'
    call neobundle#end()
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Use underbar completion.
    let g:neocomplete#enable_underbar_completion = 1
    " ユーザ定義の辞書を指定
    let g:neocomplete#sources#dictionary#dictionaries = {
			    \ 'default' : '',
			    \ 'scala' : $HOME . '/.vim/dict/scala.dict',
			    \ }
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    " Recommended key-mappings.
    " 隣接した{}で改行したらインデント
    function! IndentBraces()
	    let nowletter = getline(".")[col(".")-1]    " 今いるカーソルの文字
	    let beforeletter = getline(".")[col(".")-2] " 1つ前の文字
	    " カーソルの位置の括弧が隣接している場合
	    if nowletter == "}" && beforeletter == "{"
		    return "\n\t\n\<UP>\<RIGHT>"
	    else
		    return "\n"
	    endif
    endfunction
    " Enterに割り当て
    inoremap <silent> <expr> <CR> IndentBraces()
    function! DeleteParenthesesAdjoin()
	    let pos = col(".") - 1  " カーソルの位置．1からカウント
	    let str = getline(".")  " カーソル行の文字列
	    let parentLList = ["(", "[", "{", "\'", "\""]
	    let parentRList = [")", "]", "}", "\'", "\""]
	    let cnt = 0
	    let output = ""
	    " カーソルが行末の場合
	    if pos == strlen(str)
		    return "\b"
	    endif
	    for c in parentLList
		    " カーソルの左右が同種の括弧
		    if str[pos-1] == c && str[pos] == parentRList[cnt]
			    call cursor(line("."), pos + 2)
			    let output = "\b"
			    break
		    endif
		    let cnt += 1
	    endfor
	    return output."\b"
    endfunction
    " BackSpaceに割り当て
    inoremap <silent> <BS> <C-R>=DeleteParenthesesAdjoin()<CR>
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
	    return pumvisible() ? neocomplete#close_popup() : "\<Cr>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    filetype plugin indent on     " required!
    filetype indent on
    syntax on
    set backspace=indent,eol,start
    set encoding=utf-8
    set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp
    set fileformats=unix,dos,mac
    set number
    set noautoindent
