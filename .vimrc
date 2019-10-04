set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"fast html
"Plug 'rstacruz/sparkup'
"Codeschnipsel
"Plug 'honza/vim-snippets'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'
"Zusammengehörende Klammern durch andere ersetzen (mit cs"')
Plug 'tpope/vim-surround'
"Erweiterung des .-Befehls
Plug 'tpope/vim-repeat'
"git Änderungsanzeige
Plug 'airblade/vim-gitgutter'
"schönere Statusleiste
Plug 'itchyny/lightline.vim'
set laststatus=2
"colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'sheerun/vim-polyglot'
"Operatoren hervorheben
Plug 'Valloric/vim-operator-highlight'
"python ide
Plug 'python-mode/python-mode'
"python interactive
Plug 'jalvesaq/vimcmdline'
"completion
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
"Verzeichnis durchsuchen
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"view Konzept defitionen
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
"buffer explorer
Plug 'jlanzarotta/bufexplorer', { 'on': 'ToggleBufExplorer' }
"super searching
Plug 'kien/ctrlp.vim', { 'on': 'CtrlP' }
"latex ide
Plug 'lervag/vimtex'
"semantic highlighting
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
"Plug 'jaxbot/semantic-highlight.vim'
"compile/run
Plug 'vim-scripts/SingleCompile', { 'on': 'SCCompile' }
"R studio
Plug 'jalvesaq/Nvim-R'
"csv viewer
Plug 'chrisbra/csv.vim'
"multiple cursors
Plug 'terryma/vim-multiple-cursors'
call plug#end()

"solarized colorscheme
let g:solarized_termcolors=256

"CtrlP
noremap <C-p> :CtrlP<CR>

"vimtex
let g:vimtex_view_method = 'zathura'
let g:ycm_autoclose_preview_window_after_insertion = 1

"vimcmdline
let cmdline_vsplit = 1
let cmdline_map_send = '<space>'
let cmdline_map_send_paragraph = '<C-space>'

"semshi
let g:semshi#mark_selected_nodes = 0
let g:semshi#simplify_markup = v:false
let g:semshi#error_sign = v:false

"pymode
let g:pymode_python = 'python3'
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_lint = 0
let g:pymode_syntax = 0

"SingleCompile'
let g:SingleCompile_usetee = 0
let g:SingleCompile_usequickfix = 0

"YCM
filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"Nvim-R
let R_in_buffer = 1
let R_term = 'xterm'
let R_esc_term = 0
let R_close_term = 1
let R_min_editor_width = -80

autocmd VimEnter * if exists(':RSend') | noremap <space> :call SendParagraphToR('silent', 'stay')<CR>| endif
autocmd VimEnter * if exists(':RSend') | noremap <C-space> :call SendLineToR('stay')<CR>| endif
"autocmd VimEnter * if exists(':RSend') | noremap <C-s> :call SendFileToR('silent')<CR>| endif
autocmd VimEnter * if exists(':RSend') | noremap \s :call StartR('R')<CR>| endif
autocmd VimEnter * if exists(':RSend') | noremap \e :call RQuit('nosave')<CR>| endif
autocmd VimEnter * if exists(':RSend') | noremap \h :call RAction('help')<CR>| endif
autocmd VimEnter * if exists(':RSend') | noremap \v :call RAction('viewdf')<CR>| endif

" Virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
EOF

colorscheme monokai-phoenix
syntax on

set splitbelow
set splitright

set number
set cursorline
set ignorecase

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab

set clipboard=unnamedplus
set nowrap
set encoding=utf-8
set scrolloff=8

set backspace=indent,eol,start

set relativenumber

noremap Q :qa<CR>
noremap <C-q> :bd<CR>
noremap gs :vsplit<CR>
noremap gS :split<CR>
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :TagbarToggle<CR>
noremap <F4> :ToggleBufExplorer<CR>
noremap g+ :tabnew<CR>
noremap <left> <C-W>H
noremap <right> <C-W>L
noremap <up> <C-W>K
noremap <down> <C-W>J
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
noremap <F5> :setlocal spell! spelllang=en_us<CR>
noremap <F6> :setlocal spell! spelllang=de_de<CR>
noremap <F7> :noh<CR>
noremap ZW :w<CR>

let python_highlight_all = 1

inoremap <F9> <Esc>:w<CR>:SCCompile<CR>
nnoremap <F9> <Esc>:w<CR>:SCCompile<CR>

tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-j> <C-\><C-n><C-W>j
tnoremap <C-k> <C-\><C-n><C-W>k
tnoremap <C-l> <C-\><C-n><C-W>l

autocmd FileType tex :set dictionary+=~/.vim/dictionary/texdict
autocmd FileType tex :set tabstop=2
autocmd FileType tex :set shiftwidth=2
autocmd FileType tex :set softtabstop=2
