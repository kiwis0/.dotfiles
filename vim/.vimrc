" config for vim :) 
"

inoremap jk <ESC> 
filetype plugin indent on
syntax on
set encoding=utf-8
set clipboard=unnamedplus
let mapleader = " "
se mouse+=r
set backspace=indent,eol,start
set number
"pathogen plugin for syntax highlighting
"execute pathogen#infect()

"syntax check for flake8
let g:syntastic_python_checkers = ['flake8']
