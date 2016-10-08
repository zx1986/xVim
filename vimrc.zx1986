" Basics
set nocompatible
set noexrc
set hidden
set background=dark
set cpoptions=aABceFsmq
syntax enable
syntax on

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tomtom/tlib_vim'
Plugin 'mattn/emmet-vim'
Plugin 'Shutnik/jshint2.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Chiel92/vim-autoformat'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'kchmck/vim-coffee-script'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'L9'
call vundle#end()
filetype plugin on
filetype plugin indent on

" General
set backspace=indent,eol,start  " 讓 Backspace 鍵可用
set noerrorbells                " 關閉警示音效
set nobackup                    " 關閉自動備份
set autochdir                   " 自動辨識到檔案所在目錄
set fileformats=unix            " :e ++ff=dos [Edit file again, using dos file format, 'fileformats' is ignored]
set fileformat=unix
set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set history=500                 " keep 500 lines of command line history
set tabpagemax=50               " for vim -p *
set list
set listchars=eol:¬,tab:▸\ ,trail:~,extends:>,precedes:<,space:␣
set wrap
set formatoptions=qrn1
"set iskeyword-=_
"set ambiwidth=double
set textwidth=120
set colorcolumn=+1
"match ErrorMsg '\%>80v.\+'

" UI
set t_Co=256
set number
set numberwidth=5
set ignorecase
set smartcase
set hlsearch                    " highlight search
set incsearch                   " do incremental searching
set ruler                       " show the cursor position all the time
set nostartofline               " leave the cursor where it was
set showcmd                     " display incomplete commands
set showmatch
set cursorline                 " 高亮度顯示當前所在列
"set cursorcolumn               " 高亮度顯示當前所在欄

" Color Scheme
"colorscheme default
"colorscheme gruvbox
"colorscheme solarized
colorscheme molokai
let g:molokai_original=1

" Auto Completetion
set completeopt=longest,menu
:inoremap ( ()<ESC>i
:inoremap { {}<ESC>i
:inoremap [ []<ESC>i

" Text Formatting
set tabstop=2
set shiftwidth=2                " auto-indent amount when using cindent, stuff like >> and <<
set softtabstop=2               " when hitting tab or backspace, how many spaces should a tab be
set expandtab                   " no real tabs
set cindent
set autoindent
set smartindent
let html_no_rendering=1

" Folding
set foldenable
"set foldmethod=syntax
set foldmethod=indent
set foldlevelstart=10
set foldnestmax=10

" Mapping
let mapleader=","
let g:mapleader=","

" Status Line
set laststatus=2
set statusline=%4*%<\ %1*[%F]
set statusline+=%4*\ %5*[%{&encoding},  " encoding
set statusline+=%{&fileformat}]%m       " file format
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>

" Tab Line
" highlight User1 ctermfg=red
" highlight User2 term=underline cterm=underline ctermfg=green
" highlight User3 term=underline cterm=underline ctermfg=yellow
" highlight User4 term=underline cterm=underline ctermfg=white
" highlight User5 ctermfg=cyan
" highlight User6 ctermfg=white
" highlight TabLineFill ctermbg=DarkGreen
" highlight TabLine ctermfg=DarkGray ctermbg=DarkGreen
" highlight TabLineSel ctermfg=Yellow ctermbg=DarkGreen
" highlight TabLine term=underline cterm=bold ctermfg=darkgray ctermbg=darkgreen
" highlight TabLineSel term=bold cterm=bold ctermbg=red ctermfg=yellow

" Powerline
" let g:Powerline_symbols = 'fancy'
" let Powerline_symbols = 'compatible'
" set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline:h14
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
" set guifont=Source\ Code\ Powerline\ 14
" if has('gui_running')
"   set guifont=Monaco:h12    " set fonts for gui vim
"   set transparency=5        " set transparent window
"   set guioptions=egmrt  " hide the gui menubar
" endif

" Airline
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'ξ'
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'durant'
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" Ctrl+P
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|git|bmp)$',
\}

" ===========================================================================

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
if has("autocmd")
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
endif

autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufWritePre *.php,*.py,*.js,*.css,*.scss,*.rb,*.sh,*.config,*.ini,*.yml,*.xml,*.html :%s/\s\+$//e
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
autocmd FocusLost * :wa

" allows cursor change in tmux mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
