set nocompatible
" File ~\vimfiles\_vimrc
" {
" ($HOME\_vimrc on Windows)
source $VIMRUNTIME/defaults.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" use `zo` to open folds and `zc` to close them
" use `zO` and `zC` to do the same but for all heirarchies

"plugins and vundle {
" for vundle to work on windows, you need to install Git for Windows
" you also need to install Curl from the cURL downloads page
" also make sure that the %HOME% variable is set like ~/. in Unix

"Alternate lines for Windows
set nocompatible
filetype off
set rtp+='$Vim/vimfiles/bundle/Vundle.vim'
call vundle#begin('$Vim/vimfiles/bundle/')

"Let vundle manage vundle
Plugin 'VundleVim/Vundle.vim'
" vundle plugins go here
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'ap/vim-css-color'
" Plugin 'Yggdroot/indentLine'
Plugin 'Ron89/thesaurus_query.vim'
Plugin 'vim-scripts/ScrollColors'
Plugin 'vim-syntastic/syntastic'

Plugin 'junegunn/goyo.vim'
" Plugin 'junegunn/limelight.vim'

" The below are for ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<F2>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

call vundle#end()
filetype plugin indent on
" }

filetype plugin indent on
winpos 9999 2           "vim always opens on RHS screen
set lines=50 columns=80 "might also work

" omni complete {
filetype plugin on
set omnifunc=syntaxcomplete#Complete
" inserts the longest common text of the matches, even only for one match
set completeopt=longest,menuone

" where to look for word completions
    "buffer, windows, other buffers, unloaded buffers, tags, includes/imports
    "kspell looks in dictionary when using spelling  
set complete=.,w,b,u,t,i,kspell 
" the following change the key mappings of omni complete
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"

" this function maps <Tab> to either insert a <Tab> if the current line is
    " only whitespace, or start/continue a CTRL-N completeion operation
function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
" }

" default styling {
colorscheme solarized

set antialias                                   "smooths fonts
set tw=0                                            " textwidth doesnt wrap
set number
set relativenumber            "page numbering
set nowrap
set smarttab
set smartcase

" use 4 spaces for tabs
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set shiftround      "indents rounded to a multiple
set noexpandtab

set ignorecase      " searching
set showmatch
set hlsearch

set history=100     " history
set undolevels=100
set noerrorbells    " error noise

set title
set modelines=0
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
set encoding=utf-8

set nowritebackup
set noswapfile
set nobackup
" }

" File explorer {
let g:netrw_winsize=40
let g:netrw_altv = 1 " open from the right
let g:netrw_browse_split=4 " opens in previous tab
let g:netrw_banner=0 " removes the useless banner up the top
" Use :Vexplore to open a file explorer in vertical mode
" }

" mappings {
nnoremap ; :
command WQ wq
command Wq wq
command W w
command Q q
" maps the F3 key to file viewer
nnoremap <F3> :Vexplore<CR> 
" maps normal-mode <tab> key to switching windows
nnoremap <tab> <C-W>w
" normal-mode backspace to switch into other direction
nnoremap <bs> <C-W>W
" }

" word processor {

" `:call WP()`      opens the word processor mode
" `z=`              displays corrections
" `zg`              adds words to dictionary
function! WP()
    setlocal noexpandtab        "When the tab key is pressed, inserts a tab and not several spaces
    setlocal formatoptions=1
    map j gj
    map k gk
    setlocal formatprg=par
    setlocal wrap
    setlocal linebreak
    setlocal spellfile="C:\Program Files (x86)\Vim\vimfiles\spell\en.utf-8.add"
    setlocal spell spelllang=en_au      " http://vimdoc.sourceforge.net/htmldoc/spell.html
  setlocal spell syntax=off
    setlocal complete+=s
  retab

    UniCycleOn
    Goyo 85%x85%-2%                     " margins
    " Wordy weak " plugin for some proofreading
  
    colorscheme pencil
    setlocal lines=65 columns=90
endfunction

function! LazyWP()
    setlocal noexpandtab
    setlocal formatoptions=1
    map j gj
    map k gk
    setlocal formatprg=par
    setlocal wrap
    setlocal linebreak  " line wraps don't break up words

    UniCycleOn
    " Wordy redundant " plugin for some light proofreading

  colorscheme materialtheme
    setlocal lines=65 columns=90
endfunction
" }

" airline tabs {
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemode = ':t'       " shows tail of file name       
let g:airline#extensions#branch#format = 1              " only shows file name
let g:airline_theme='distinguished'
" }

" indentline settings {
let g:indentLine_setColors = 1  " 0 or 1 for grey or colourscheme
"let g:indentLine_color_gui = '#BADA55'
"let g:indentLine_char = '¦'
" }

" native indentation guides {
" display indentation guides
set list listchars=tab:\|\ 

" convert spaces to tabs when reading file
let fts = ['txt', 'md', 'text']
if index(fts, &filetype) != -1
    autocmd! bufreadpost * set noexpandtab | retab! 4

    " convert tabs to spaces before writing file
    autocmd! bufwritepre * set expandtab | retab! 4

    " convert spaces to tabs after writing file (to show guides again)
    autocmd! bufwritepost * set noexpandtab | retab! 4
endif
" }

" syntastic for noobs {
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_check_on_wq = 0 " file is not checked when quitted
    let g:syntastic_aggregate_errors = 1 " aggregates and displays all errors
    let g:syntastic_loc_list_height = 3 " location list window height
" }

" unicycle {
" best to use only for certain filetypes
" utf-8 MUST BE ON
" -- is en dash; --- is em dash; ---- is back to hyphen-minus
"  ... is ellipsis
"  double and single quotes are automatically done
" :UniCycleOn
" http://www.vim.org/scripts/script.php?script_id=1384
" }

" folds {
set foldmethod=marker
set foldmarker={,}
set foldlevel=2
set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
" }
" }
