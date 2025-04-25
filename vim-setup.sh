#!/bin/bash

set -euo pipefail

cat <<EOF > /home/$USER/.vimrc
" Common adjustments
set nocompatible 		" Disable vi compatibility mode
set number			" Show line numbers
set relativenumber		" Show relative line numbers
syntax on			" Turn on syntax highlighting
set tabstop=4			" 4 spaces for tabs
set shiftwidth=4		" 4 spaces for auto indents
set expandtab			" Replace tabs with spaces
set autoindent			" Auto indents
set smartindent			" Smart indents
set cursorline			" Highlight current line
set wildmenu			" Enable suggestions
set clipboard=unnamedplus	" Sync with the system buffer
set mouse=a			" Enable mouse
EOF
