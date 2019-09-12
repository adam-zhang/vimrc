" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

set rnu
set nu

colorscheme desert

set nocompatible              " be iMproved, required
filetype off                  " required

"coding 
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"English menu
so $VIMRUNTIME/delmenu.vim
set langmenu=none
so $VIMRUNTIME/menu.vim

set tags+=~/.tags/tags 
set tags+=tags
set autochdir

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"au BufNewFile,BufRead *.cpp set syntax=cpp11
"au BufNewFile,BufRead *.h set syntax=cpp11
":let c_no_curly_error = 1

"set cindent
"set smartindent
map <F3> :call FormatCode()<CR>
func! FormatCode()
	exec "w"
	if &filetype == 'C' || &filetype == 'h'
		exec "!astyle --style=bsd --indent=spaces=8 %"
	elseif &filetype == 'cpp'
		exec "!astyle --style=bsd --indent=spaces=8 %"        
		return
	endif
endfunc

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'adam-zhang/a.vim'
Plugin 'jiangmiao/auto-pairs'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"YouCompleteMe
"配置默认文件路径
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
""打开vim时不再询问是否加载ycm_extra_conf.py配置
"let g:ycm_confirm_extra_conf = 0
"set completeopt=longest,menu
""自动开启语义补全
"let g:ycm_seed_identifiers_with_syntax = 1
""在注释中也开启补全
"let g:ycm_complete_in_comments = 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 0
""字符串中也开启补全
"let g:ycm_complete_in_strings = 1
"let g:ycm_collect_identifiers_from_tags_files = 1
""开启基于tag的补全，可以在这之后添加需要的标签路径  
"let g:ycm_collect_identifiers_from_tags_files = 1
""开始补全的字符数
"let g:ycm_min_num_of_chars_for_completion = 2
""补全后自动关闭预览窗口
"let g:ycm_autoclose_preview_window_after_completion = 1
""禁止缓存匹配项,每次都重新生成匹配项
"let g:ycm_cache_omnifunc=0
""离开插入模式后自动关闭预览窗口
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
""语法关键字补全
"let g:ycm_seed_identifiers_with_syntax = 1  
""整合UltiSnips的提示
"let g:ycm_use_ultisnips_completer = 1 
""在实现和声明之间跳转,并分屏打开
"let g:ycm_goto_buffer_command = 'horizontal-split'
"nnoremap <Leader>g :YcmCompleter GoTo<CR>
""与syntastic有冲突，建议关闭
"let g:ycm_show_diagnostics_ui = 0
""let g:ycm_error_symbol = '>>'
""let g:ycm_warning_symbol = '>>'
"let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_enable_diagnostic_highlighting = 0
"let g:ycm_echo_current_diagnostic = 0
"
"ctags

"toggle the size of application in windows
function ToggleWindowSize(act)
	if a:act < 0 || a:act > 2 | return | endif
	let posX = getwinposx()
	let posY = getwinposy()
	let actTab = "XXX__X_XR__XX_X__RRRR__R"
	let idx = ((exists("g:twsWM") + exists("g:twsHM") * 2) * 3 + a:act) * 2
	let actW = strpart(actTab, idx, 1)
	let actH = strpart(actTab, idx + 1, 1)
	" note. g:tws + [Width,Height,X,Y] + [Maximized,Saved]
	if actW == "X"
		let g:twsWS = &columns | let g:twsXS = posX
		set columns=999
		let posX = getwinposx()
		let g:twsWM = &columns | let g:twsXM = posX
	elseif actW == "R"
		if g:twsWM == &columns
			let &columns = g:twsWS
			if g:twsXM == posX | let posX = g:twsXS | endif
		endif
		unlet g:twsWM g:twsWS g:twsXM g:twsXS
	endif
	if actH == "X"
		let g:twsHS = &lines | let g:twsYS = posY
		set lines=999
		let posY = getwinposy()
		let g:twsHM = &lines | let g:twsYM = posY
	elseif actH == "R"
		if g:twsHM == &lines
			let &lines = g:twsHS
			if g:twsYM == posY | let posY = g:twsYS | endif
		endif
		unlet g:twsHM g:twsHS g:twsYM g:twsYS
	endif
	execute "winpos " . posX . " " . posY
endfunction
nnoremap <F11> :call ToggleWindowSize(2)<CR>
nnoremap <S-F11> :call ToggleWindowSize(1)<CR>
nnoremap <C-F11> :call ToggleWindowSize(0)<CR>
imap <F11> <C-O><F11>
imap <S-F11> <C-O><S-F11>
imap <C-F11> <C-O><C-F11>
