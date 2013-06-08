" Vim:set foldmarker={{{,}}} foldlevel=0 spell

" Basics
" {{{
    set nocompatible                " 關閉 vi 相容模式
    set background=dark             " 設定背景爲黑色系
    set noexrc                      " 不使用 .exrc
    set cpoptions=aABceFsmq
    syntax on                       " 開啓語法高亮度顯示
" }}}

" Vundle
" {{{
    filetype off
    set rtp+=$GOROOT/misc/vim
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()    
    Bundle 'gmarik/vundle'

    """ original repos on github
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-rails.git'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-markdown'
    Bundle 'tpope/vim-haml'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'rodjek/vim-puppet'
    Bundle 'bartekd/vim-dart'
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'tomtom/tlib_vim'
    Bundle 'garbas/vim-snipmate'
    Bundle 'mattn/zencoding-vim'
    Bundle 'kien/ctrlp.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'StanAngeloff/php.vim'
    Bundle 'xenoterracide/html.vim.git'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'wgibbs/vim-irblack'
    Bundle 'therubymug/vim-pyte'
    Bundle 'juvenn/mustache.vim'
    Bundle 'vim-scripts/phpfolding.vim'
    Bundle 'vim-scripts/Align'
    Bundle 'vim-scripts/Jinja'
    Bundle 'vim-scripts/desert256.vim'
    Bundle 'vim-scripts/wombat256.vim'
    Bundle 'vim-scripts/moria'
    Bundle 'vim-scripts/mayansmoke'
    Bundle 'vim-scripts/peaksea'
    Bundle 'vim-scripts/taglist.vim'
    Bundle 'vim-scripts/PDV--phpDocumentor-for-Vim'
    """ vim-scripts repos
    Bundle 'L9'
    Bundle 'FuzzyFinder'
    """ non github repos
    "Bundle 'git://git.wincent.com/command-t.git'
" }}}

" General
" {{{
    filetype plugin indent on
    set backspace=indent,eol,start  " 讓 Backspace 鍵可用
    "set mouse=a                    " 開啓滑鼠功能
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
" }}}

" UI
" {{{
    set number                      " 顯示列（row）號
    set numberwidth=5               " 列號的位數
    "set cursorline                 " 高亮度顯示當前所在列
    "set cursorcolumn               " 高亮度顯示當前所在欄
    set hlsearch                    " highlight search
    set incsearch                   " do incremental searching
    set ruler                       " show the cursor position all the time
    set nostartofline               " leave the cursor where it was
    set showcmd                     " display incomplete commands
    set showmatch
    "colorscheme default            " default, blue, darkblue, slate, delek ...
    "colorscheme solarized
    "colorscheme peaksea
    "colorscheme ir_black
    "colorscheme pyte
    "colorscheme moria
    "colorscheme mayansmoke
    "colorscheme desert256
    "colorscheme wombat256mod
" }}}

" Text Formatting 
" {{{
    set tabstop=4
    set shiftwidth=4                " auto-indent amount when using cindent, stuff like >> and <<
    set softtabstop=4               " when hitting tab or backspace, how many spaces should a tab be
    set expandtab                   " no real tabs
    "set nowrap                     " do not wrap line
    "set paste
    set cindent
    set autoindent
    set smartindent
    let html_no_rendering=1
" }}}

" Folding
" {{{
    set foldenable
    set foldmethod=syntax
" }}}

" Mapping
" {{{
    " 讓 ,n 相當於使用 :new
    " map ,n :new
    let mapleader=","
    inoremap <C-U> <C-G>u<C-U>
" }}}

" 狀態列與分頁條設定
" {{{
     set laststatus=2
     set statusline=%4*%<\ %1*[%F]
     set statusline+=%4*\ %5*[%{&encoding},  " encoding
     set statusline+=%{&fileformat}]%m       " file format
     set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
"      highlight User1 ctermfg=red
"      highlight User2 term=underline cterm=underline ctermfg=green
"      highlight User3 term=underline cterm=underline ctermfg=yellow
"      highlight User4 term=underline cterm=underline ctermfg=white
"      highlight User5 ctermfg=cyan
"      highlight User6 ctermfg=white 
"      highlight TabLineFill ctermbg=DarkGreen
"      highlight TabLine ctermfg=DarkGray ctermbg=DarkGreen
"      highlight TabLineSel ctermfg=Yellow ctermbg=DarkGreen
     highlight TabLine term=underline cterm=bold ctermfg=darkgray ctermbg=darkgreen
     highlight TabLineSel term=bold cterm=bold ctermbg=red ctermfg=yellow
" }}}

" 自動補齊括號
" {{{
     :inoremap ( ()<ESC>i
     :inoremap ) <c-r>=ClosePair(')')<CR>
     :inoremap { {}<ESC>i
     :inoremap } <c-r>=ClosePair('}')<CR>
     :inoremap [ []<ESC>i
     :inoremap ] <c-r>=ClosePair(']')<CR>
     :inoremap < <><ESC>i
     :inoremap > <c-r>=ClosePair('>')<CR>
     :inoremap ' ''<ESC>i
     :inoremap " ""<ESC>i
     function ClosePair(char)
         if getline('.')[col('.') - 1] == a:char
             return "\<Right>"
         else
             return a:char
         endif
     endf
" }}}

" Javascript Folding
" {{{
    function! JavaScriptFold() 
        setl foldmethod=syntax
        setl foldlevelstart=1
        syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
        function! FoldText()
           return substitute(getline(v:foldstart), '{.*', '{...}', '')
        endfunction
        setl foldtext=FoldText()
    endfunction
"    au FileType javascript call JavaScriptFold()
"    au FileType javascript setl fen
" }}}

" Plugins Setting
" {{{
    " c9s simple comment
    " {{{
       let g:scomment_default_mapping=1
    " }}}

    " vim-indent-guides
    " {{{
        hi IndentGuidesOdd  ctermbg=black
        hi IndentGuidesEven ctermbg=darkgrey
        let g:indent_guides_start_level=2
        let g:indent_guides_guide_size=1
    " }}}

    " PDV a.k.a. php-doc
    " {{{
        inoremap <C-H> <ESC>:call PhpDocSingle()<CR>i 
        nnoremap <C-H> :call PhpDocSingle()<CR> 
        vnoremap <C-H> :call PhpDocRange()<CR>
    " }}}
    
    " Powerline
    " {{{
        set t_Co=16
        let g:Powerline_symbols = 'fancy'
        "let Powerline_symbols = 'compatible'
        "set guifont=Bitstream\ Vera\ Sans\ Mono\ for\ Powerline:h14
        "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
        "if has('gui_running')
        "  set guifont=Monaco:h12    " set fonts for gui vim
        "  set transparency=5        " set transparent window
        "  set guioptions=egmrt  " hide the gui menubar
        "endif
    " }}}
" }}}

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

" for coffee-toaster
"autocmd BufRead,BufNewFile *.coffee setlocal backupcopy=yes
"set nobackup       " no backup files
"set nowritebackup  " only in case you don't want a backup file while editing
"set noswapfile     " no swap files
