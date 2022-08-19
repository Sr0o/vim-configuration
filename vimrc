" ========== Auto load Vim-Plugin for first time uses ==========
let data_dir = has('nvim') ? stdpath('data').'/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))	
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ========== Vim default configuration ==========
set nocompatible
set backspace=indent,eol,start
set ruler
set showcmd
set wildmenu
set scrolloff=5
syntax on
filetype plugin indent on
set autoindent

" ========== Custom vim configuration ==========
set fileencoding=utf-8
set number
set confirm
set nobackup
set nowritebackup
set whichwrap=b,s,<,>,[,]
set iskeyword+=_,$,@,%,#,-
set showmode
set cmdheight=1
set linespace=0
set laststatus=2
set statusline=\ %F%m%r%h%w\ %{\"[fenc=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ %<[asc=%03.3b]\ [hex=%02.2B]\ %=[POS=%v,%o,%p%%]\ %=%L\ \%{strftime(\"%Y-%m-%d\ \ %H:%M\")}\ 
set shiftwidth=4
set softtabstop=4
set smartindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set report=0
set noerrorbells
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set showmatch
set matchtime=5
set ignorecase
set infercase
set linebreak
set formatoptions=tcrqn
set cursorline 
highlight CursorLine cterm=NONE ctermbg=235 guibg=NONE guifg=NONE

" ========== some custom keymap ==========
" so we can use <LEADER> like " "
let mapleader=" "

" 括号自动补全
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT><RETURN><ESC>O
" inoremap < <><LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" inoremap ` ``<LEFT>

" auto remove unneccessary ) ] } >
function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]
    if a:char == l:next_char
	execute "normal! l"
    else
	execute "normal! a" . a:char . ""
    end
endfunction
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
" inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a

" use " c" to cancel search highlight
nnoremap <LEADER>c :noh<return><esc>

" ========== Install Plugins with Vim-Plugin ========== 
call plug#begin()

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" python
" about indent
" Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'vim-plug'] }
" Plug 'tweekmonster/braceless.vim', { 'for': ['python', 'vim-plug']}

call plug#end()

" ========== plug and configuration ==========
" ========== coc.nvim plug ==========
let g:coc_global_extensions = ['coc-marketplace', 'coc-vimlsp', 'coc-json', 'coc-explorer']

" ========== coc.nvim adapted configuration ==========
" to avoid some messages
set shortmess+=c

" 将侧边栏显示的东西与行号栏共用. 
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use ` -` and ` =` to navigate diagnostics
nmap <silent> <LEADER>-  <Plug>(coc-diagnostic-prev) 
nmap <silent> <LEADER>=  <Plug>(coc-diagnostic-next) 

" Goto code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" open explorer
nnoremap <LEADER>t :CocCommand explorer<CR>

" nvim Use <c-space> and vim use <c-o> to trigger completion. 
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-o> coc#refresh()
endif

