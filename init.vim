" load/install plugins
call plug#begin('~/.local/share/nvim/plugged')
" fuzzy file finding
Plug 'ctrlpvim/ctrlp.vim'
" easy commenting of lines
Plug 'scrooloose/nerdcommenter'
" tab completion
Plug 'ncm2/ncm2'
" requires nvim-yarp
Plug 'roxma/nvim-yarp'
" specific language/buffers
Plug 'ncm2/ncm2-go' " golang
Plug 'ncm2/ncm2-pyclang' " c/c++
Plug 'ncm2/ncm2-jedi' " python
Plug 'ncm2/ncm2-tern', {'do': 'npm install'} " javascript
Plug 'ncm2/ncm2-bufword' " words from current buffer

" linting
Plug 'w0rp/ale'
" tag viewing (testing)
Plug 'majutsushi/tagbar'
" status bar
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
" git showing things
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" multiple cursors
Plug 'terryma/vim-multiple-cursors'
" easy surrounding (parens, brackets, quotes)
Plug 'tpope/vim-surround'
" color schemes!
Plug 'dracula/vim', {'as': 'dracula'}

" go support
Plug 'fatih/vim-go'
" for autocompletion
Plug 'mdempsky/gocode', {'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh >> ~/tmp.log 2>&1'}
" coquille (coq IDE in vim)
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille', { 'branch': 'pathogen-bundle' }
" haskell
Plug 'neovimhaskell/haskell-vim'
" react
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

" to give cloudformation templates correct filetype and syntax
au BufReadPost *.template set filetype=cloudformation
au BufReadPost *.template set syntax=yaml

" colors and basic look/feel
set termguicolors
set background=dark
colorscheme dracula

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

" terminal
" remap escape to exit terminal, while in terminal mode
:tnoremap <Esc> <C-\><C-n>

" PLUGIN CONFIGURATION

" lightline
set laststatus=2
set noshowmode
set showtabline=2
let g:lightline={
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok', 'linter_checking' ],
      \              [ 'lineinfo', 'percent' ],
      \              [ 'spell' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component': {
      \   'lineinfo': '⭡ %3l:%-2v',
      \ },
      \ 'component_function': {
      \   'fileformat': 'FileformatIgnoreWhenSmall',
      \   'filetype': 'FiletypeIgnoreWhenSmall',
      \   'readonly': 'LightlineReadonly',
      \   'gitbranch': 'LightlineFugitive',
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'linter': 'LinterStatus',
      \   'linter_checking': 'LinterChecking',
      \   'linter_warnings': 'LinterWarnings',
      \   'linter_errors': 'LinterErrors',
      \   'linter_infos': 'LinterInfos',
      \   'linter_ok': 'LinterOkay',
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel',
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_infos': 'left',
      \   'linter_ok': 'left',
      \ },
      \ 'tabline': {
      \   'left': [ [ 'buffers' ] ],
      \   'right': [ [ 'gitbranch' ] ],
      \ },
      \ }
function! FiletypeIgnoreWhenSmall()
    return winwidth(0)>70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! FileformatIgnoreWhenSmall()
    return winwidth(0)>70 ? &fileformat : ''
endfunction
function! LightlineReadonly()
    return &readonly ? '⭤' : ''
endfunction

" ale lightline functions
function! LinterChecking() abort
    return ale#engine#IsCheckingBuffer(bufnr('')) ? 'Linting...' : ''
endfunction
function! AleLinted() abort
    return get(g:, 'ale_enabled', 0) == 1 && getbufvar(bufnr(''), 'ale_linted', 0) > 0 && !ale#engine#IsCheckingBuffer(bufnr(''))
endfunction
function! LinterErrors() abort
    if !AleLinted()
        return ''
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:all_errors == 0 ? '' : printf('E: %d', all_errors)
endfunction
function! LinterWarnings() abort
    if !AleLinted()
        return ''
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_warn = l:counts.warning + l:counts.style_warning
    return l:all_warn == 0 ? '' : printf('W: %d', all_warn)
endfunction
function! LinterInfos() abort
    if !AleLinted()
        return ''
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.info == 0 ? '' : printf('I: %d', counts.info)
endfunction
function! LinterOkay() abort
    if !AleLinted()
        return ''
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.total == 0 ? 'OK' : ''
endfunction
augroup ALEProgress
    autocmd!
    autocmd User ALELintPre call lightline#update()
    autocmd User ALELintPost call lightline#update()
augroup END

" git-fugitive lightline fn
function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction


" ale
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_insert_leave=1

" ctrlp config
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = 'i'
nnoremap <Leader>b :CtrlPBuffer<CR>

" ncm2 config
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
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
let g:go_metalinter_enabled = [
 \  'deadcode',
 \  'errcheck',
 \  'gofmt',
 \  'goimports',
 \  'ineffassign',
 \  'megacheck',
 \  'misspell',
 \  'vet'
 \ ]
" make a `lint entire project` comamnd
command GoMetaLint :execute "GoMetaLinter " . FugitiveGitDir() . "/../..."



let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

" coquille config
nnoremap <Leader>n :CoqNext<CR>
nnoremap <Leader>u :CoqUndo<CR>
nnoremap <Leader>k :CoqKill<CR>
nnoremap <Leader>c :CoqToCursor<CR>
let g:coquille_auto_move = 'true'
" change indentation for coq files
autocmd FileType coq setlocal shiftwidth=2 tabstop=2


