" load/install plugins
call plug#begin('~/.local/share/nvim/plugged')
" fuzzy file finding
Plug 'ctrlpvim/ctrlp.vim'
" easy commenting of lines
Plug 'scrooloose/nerdcommenter'
" tab completion
Plug 'roxma/nvim-completion-manager'
" language specific tab completion
Plug 'roxma/ncm-clang' " c/c++
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'} " javascript
Plug 'fgrsnau/ncm-otherbuf' " other buffers
" linting
Plug 'w0rp/ale'
" tag viewing (testing)
Plug 'majutsushi/tagbar'
" status bar
Plug 'vim-airline/vim-airline'
" git showing things
Plug 'airblade/vim-gitgutter'
" multiple cursors
Plug 'terryma/vim-multiple-cursors'
" easy surrounding (parens, brackets, quotes)
Plug 'tpope/vim-surround'
" color schemes!
Plug 'chriskempson/vim-tomorrow-theme'

" go support
Plug 'fatih/vim-go'
" for autocompletion
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
" coquille (coq IDE in vim)
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille', { 'branch': 'pathogen-bundle' }
" haskell
Plug 'neovimhaskell/haskell-vim'
call plug#end()

" colors and basic look/feel
set termguicolors
set background=dark
colorscheme Tomorrow-Night-Bright

set colorcolumn=79,119
set number

set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

set sidescroll=4
set listchars=tab:>\ ,trail:·,extends:~,precedes:~,conceal:?,nbsp:⎵
set nowrap
" to toggle the trailing thing on
set list!

" space = <Leader>
let mapleader=" "
" <Leader>s re-sources the config file
map <Leader>s :source ~/.config/nvim/init.vim<CR>

" convenience for using multiple buffers
set hidden

" filetype nice things (language specific indents, plugins)
filetype indent on
filetype plugin on

" wildmenu (the autocompletion thing)
set wildmenu
set wildmode=longest:list,full
set wildignorecase

" search options
set hlsearch
set incsearch

" show matching paren
set showmatch

" show pressed keys (bottom right)
set showcmd

" make backspace work over lines
set backspace=2
" so we can scroll other splits without being in them
set mouse=a

" PLUGIN CONFIGURATION

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
set ttimeoutlen=10
set laststatus=2
set noshowmode
" ale integration
let g:airline#extensions#ale#enabled = 1

" ctrlp config
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = 'i'
nnoremap <Leader>b :CtrlPBuffer<CR>

" nvim-completion-engine config
" if i hit enter, i want a newline, damnit
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" tab to select popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" tagbar config
" go tag support
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }


" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" coquille config
nnoremap <Leader>n :CoqNext<CR>
nnoremap <Leader>u :CoqUndo<CR>
nnoremap <Leader>k :CoqKill<CR>
nnoremap <Leader>c :CoqToCursor<CR>
let g:coquille_auto_move = 'true'
" change indentation for coq files
autocmd FileType coq setlocal shiftwidth=2 tabstop=2


