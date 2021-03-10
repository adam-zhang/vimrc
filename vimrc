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
 
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle
Plugin 'adam-zhang/a.vim'
Plugin 'adam-zhang/auto-pairs'
Plugin 'vim-scripts/fcitx.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'https://github.com/iamcco/markdown-preview.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set rnu
set nu

colorscheme desert

set tags+=~/.tags/tags
set tags+=tags

set path=.,/usr/include/**,/usr/local/include/**,/usr/local/Qt-5.5.1/include/**

autocmd InsertLeave * :silent !fcitx-remote -c
autocmd BufCreate *  :silent !fcitx-remote -c
autocmd BufEnter *  :silent !fcitx-remote -c
autocmd BufLeave *  :silent !fcitx-remote -c

