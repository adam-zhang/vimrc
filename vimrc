" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

set nocompatible              " required
filetype off                  " required
 
filetype plugin indent on    " required

set rnu
set nu

colorscheme desert

set tags+=~/.tags/tags
set tags+=tags
set complete-=t

set path=.,/usr/include/**,/usr/local/include/**,/usr/local/Qt-5.5.1/include/**

set makeprg=cmake\ -B\ build\ &&\ cmake\ --build\ build\ -j${nproc}

" 指定插件安装目录
call plug#begin('~/.vim/plugged')

" 在这里添加插件列表
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 初始化插件系统
call plug#end()
