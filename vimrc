" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on
"color solarized

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
set ignorecase         " Do case insensitive matching
set incsearch          " Incremental search
set hlsearch
set nocompatible
set swapsync=
set nofsync
set ruler
set number
set encoding=utf-8
"set columns=80
set cursorline
hi CursorLine cterm=NONE ctermbg=black
nnoremap H :set cursorline!<CR>
"set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
"set expandtab

"set spell
"set spelllang=de,en

" folding
set foldenable
"set foldmethod=marker
"set foldmarker={,}

" Show trailing spaces and highlight hard tabs
set listchars=trail:·

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Map Ctrl+l to clear highlighted searches
noremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Highlight characters behind the 80 chars margin
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%<82v.\%>81v', -1)

" auto paranthesis
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<cr><Esc>O<TAB><cr>}<Esc>ka
inoremap < <><Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap <c-k> <Esc>/[)}"'\]>]/<cr>a

" don't jump over wraped lines
map <DOWN> gj
map <UP> gk
imap <UP> <ESC>gki
imap <DOWN> <ESC>gji

" move in tabs
"map <C-t><up> :tabr<cr>
"map <C-t><down> :tabl<cr>
"map <C-t><left> :tabp<cr>
"map <C-t><right> :tabn<cr>

" buffer/file change
map <C-right> <Esc>:bn<cr>
map <C-left> <Esc>:bp<cr>

" session management
autocmd VimEnter * call LoadSession ()
autocmd VimLeave * call SaveSession ()
function! SaveSession()
	execute 'mksession! $HOME/.vimsession'
endfunction
function! LoadSession()
	if argc() == 0
		execute 'source $HOME/.vimsession'
	endif
endfunction

" tabline
set tabline=%!ShortTabLine()
function ShortTabLine()
	let ret = ''
	for i in range(tabpagenr('$'))
		"select the color group for highlighting active tab
		if i + 1 == tabpagenr()
			let ret .= '%#errorMsg#'
		else
			let ret .= '%#TabLine#'
		endif
		" find the buffername for the tablabel
		let buflist = tabpagebuflist(i+1)
		let winnr = tabpagewinnr(i+1)
		let buffername = bufname(buflist[winnr-1])
		let filename = fnamemodify(buffername,':t')
		" check if there is no name
		if filename == ''
			let filename = 'noname'
		endif
		" only show the first 10 letters of the name  and
		" .. if the filename is more than 10 letters long
		if strlen(filename) >=12
			let ret .= '['. filename[0:9].'..]'
		else
			let ret .= '['.filename.']'
		endif
	endfor
	" after the last tab fill with TabLineFill and reset tab page #
	let ret .= '%#TabLineFill#%T'
	return ret
endfunction

" diffmode
if &diff
	map <c-j> ]c
	map <c-k> [c
	map <c-down> ]c
	map <c-up> [c
	map <c-p> <esc>:diffput<cr>
	map <c-g> <esc>:diffget<cr> 
endif

" headline maps
map h1 :s/\(.*\)/= \1 =/<cr>yykpVr=yyjpo
map h2 yypVr=o
map h3 yypVr-o

" shortcuts 
"source ~/.abbreviations.vim
inoremap <c-j> <ESC>/+.\{-1,}+<cr>c/+/e<cr>
match Error /+.\++/
iabbr class class +NAME+ {
iabbr subclass class +NAME+ inherits +CLASS+ {
