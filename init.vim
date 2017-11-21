call plug#begin('~/.local/share/nvim/plugged')
" fuzzy file finding
Plug 'ctrlpvim/ctrlp.vim'
" easy commenting of lines
Plug 'scrooloose/nerdcommenter'
" tab completion
Plug 'roxma/nvim-completion-manager'
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
" coquille (coq IDE in vim)
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille'
call plug#end()



set termguicolors
set background=dark
colorscheme Tomorrow-Night-Bright






