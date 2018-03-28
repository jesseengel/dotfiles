call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'tacahiroy/ctrlp-funky'
Plug 'mbbill/undotree'
Plug 'chriskempson/base16-vim'
Plug 'reedes/vim-thematic'
Plug 'scrooloose/nerdcommenter'

" Initialize plugin system
call plug#end()

"""VIM
set nocompatible          " get rid of Vi compatibility mode. SET FIRST!
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
set number                " show line numbers
"set relativenumber        " show relative line number
set laststatus=2          " last window always has a statusline
filetype indent on        " activates indenting for files

set autoindent            " auto-indent
set tabstop=2             " tab spacing
set softtabstop=2         " unify
set shiftwidth=2          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
"set nowrap                " don't wrap text
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set mouse=a               " Automatically enable mouse usage
set mousehide             " Hide the mouse cursor while typing

set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore   " Allow for cursor beyond last character
set history=1000          " Store a ton of history (default is 20)
set hidden                " Allow buffer switching without saving
set cursorline            " Highlight current line

set hlsearch              " Highlight search terms
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set smartcase             " Case sensitive when uc present
set ruler                 " Always show info along bottom.

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
"set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace


set splitbelow   " Open splits below and to the right, more natural than vim defalut
set splitright   " Open splits below and to the right, more natural than vim defalut



""" Reminder need x-clipoard enabled (Use homebrew version of vim)
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

"Automatically switch to the current file directory when a new buffer is opened
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif


" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Setting up the directories
set backup                  " Backups are nice ...
set backupdir=~/.backup,/tmp
set directory=~/.backup,/tmp

if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    set undodir="~/.backup/"
endif

" Thin cursor in insert mode
set guicursor=i:ver25-iCursor
if $TERM_PROGRAM =~ "iTerm"
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"  " Vertical bar in inser
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"  " Block in normal mode
endif
endif

" Turn on/off line cursor in insert mode
":autocmd InsertEnter * set cul
":autocmd InsertLeave * set nocul

" Make commands easier
nnoremap ; :

inoremap jj <Esc>

" Turn off highlight
nmap <silent> ,/ :nohlsearch<CR>

" Shift seletion of text with arrows
nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> v<Left>
nnoremap <S-Right> v<Right>
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
inoremap <S-Up> <Esc> v<Up>
inoremap <S-Down> <Esc> v<Down>
inoremap <S-Left> <Esc> v<Left>
inoremap <S-Right> <Esc> v<Right>


" Easier moving between buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Easier Scrolling (Half-Page)
nnoremap <Space> 10j
nnoremap <NUL> 10k

" Easier moving in windows and splits
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Save without exiting insert mode
noremap <silent> <C-W>          :update<CR>
vnoremap <silent> <C-W>         <C-C>:update<CR>
inoremap <silent> <C-W>         <C-O>:update<CR>

" Clear search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

" Shell autocomplete
inoremap <C-Tab> <C-X><C-F>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Quick search and replace like Sublime. Use with '.' command
nnoremap <Leader>r *Ncgn

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

"""" PACKAGES

""" Color Schemes
let base16colorspace=256 " Access colors present in 256 colorspace
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

""" Color Schemes : Thematic
let g:thematic#defaults = {'background': 'dark'}
let g:thematic#themes = {
\ 'solarized'      : {},
\ 'base16-default' : {},
\ }

let g:thematic#theme_name = 'base16-default'
"let g:thematic#theme_name = 'solarized'


"""Color Scheme : Solarized
"set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"
"colorscheme solarized

"""Color Scheme : Base 16
"set background=dark
"colorscheme base16-default


"""Python Syntax
let python_highlight_all = 1

"""REMAPPING
let mapleader = ","

"""Airline
if isdirectory(expand("~/.vim/bundle/vim-airline"))
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme = 'solarized'
endif

"""Tagbar
if isdirectory(expand("~/.vim/bundle/tagbar"))
    nnoremap <leader>tt :TagbarToggle<CR>
endif

""" NerdTree
if isdirectory(expand("~/.vim/bundle/nerdtree"))
    map <C-e> <plug>NERDTreeTabsToggle<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=0
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
endif

""" ctrlp
if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <silent> <D-t> :CtrlP<CR>
    nnoremap <silent> <D-r> :CtrlPMRU<CR>
    nnoremap <leader>b :CtrlPBuffer<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

    if executable('ag')
        let s:ctrlp_fallback = 'ag %s -i --nocolor --nogroup --hidden
              \ --ignore .git
              \ --ignore .svn
              \ --ignore .hg
              \ --ignore .DS_Store
              \ --ignore .cache
              \ --ignore "**/*.pyc"
              \ --ignore .git5_specs
              \ --ignore review
              \ -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif
    if exists("g:ctrlp_user_command")
        unlet g:ctrlp_user_command
    endif

    let g:ctrlp_user_command = {
       \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': s:ctrlp_fallback
    \ }

    if isdirectory(expand("~/.vim/bundle/ctrlp-py-matcher"))
        let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    endif

    if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
        " CtrlP extensions
        let g:ctrlp_extensions = ['funky']

        "funky
        nnoremap <Leader>f :CtrlPFunky<Cr>
    endif
endif


""" UndoTree
if isdirectory(expand("~/.vim/bundle/undotree/"))
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif

""" indentLine
if isdirectory(expand("~/.vim/bundle/indentline/"))
    let g:indentLine_char = '┆'
    let g:indentLine_enabled = 1
endif

""" indentLine
if isdirectory(expand("~/.vim/bundle/nerdcommenter/"))
    " <Leader>cc, <Leader>cu, <Leader>c<Space>
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1

    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1

    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'

    " Set a language to use its alternate delimiters by default
    "let g:NERDAltDelims_java = 1

    " Add your own custom formats or override the defaults
    "let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1

    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
endif


""" C++ Extended Highlighting
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1


source ~/.vim/osc52.vim
vmap <C-c> y:call SendViaOSC52(getreg('"'))<cr>


""`" Use the 'google' package by default (see http://go/vim/packages).
"""source /usr/share/vim/google/google.vim
source ~/.vimrc_google
Glug g4



