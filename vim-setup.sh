#!/bin/bash

set -euo pipefail

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat <<EOF > /home/$USER/.vimrc
" Common adjustments
set nocompatible            " Turn off compatible with vi mod
set number			        " Show line numbers
syntax on			        " Turn on syntax highlighting
set tabstop=4			    " 4 spaces for tabs
set shiftwidth=4		    " 4 spaces for auto indents
set expandtab			    " Replace tabs with spaces
set autoindent			    " Auto indents
set smartindent			    " Smart indents
set cursorline			    " Highlight current line
set wildmenu			    " Enable suggestions
set clipboard=unnamedplus	" Sync with the system buffer
set mouse=a			        " Enable mouse

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'                          " Theme

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete

Plug 'preservim/nerdtree'                       " File manager

Plug 'dense-analysis/ale'                       " Code analyses:

Plug 'tpope/vim-fugitive'                       " Git

Plug 'vim-airline/vim-airline'                  " Status bar

call plug#end()

set background=dark

colorscheme gruvbox
EOF

vim +PlugInstall +qall
