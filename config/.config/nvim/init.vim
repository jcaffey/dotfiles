"  __  __    _    ____  ____
" |  \/  |  / \  |  _ \/ ___|
" | |\/| | / _ \ | |_) \___ \
" | |  | |/ ___ \|  __/ ___) |
" |_|  |_/_/   \_\_|   |____/
"

" SPACE
let mapleader = " "

" source
nnoremap <leader><cr> :source ~/.config/nvim/init.vim<cr>

" paste from *
noremap <leader>P "*p

" yank to *
vnoremap <leader>Y "*y

" paste multiple times
vnoremap <leader>p "_dP

" move lines up and down
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" quickfix list
nnoremap <leader>qf :copen<cr>
nnoremap <leader>k :cprev<cr>
nnoremap <leader>j :cnext<cr>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Explore
nnoremap <leader>e :Vex<cr>

" Use <Leader>l to toggle line numbers. This is useful when copying something from vim
" while using tmux and you don't want lines.
nnoremap <leader>l :set nu! rnu!<CR>


" navigate panes with arrows
nnoremap <Left> <C-w><Left>
nnoremap <Right> <C-w><Right>
nnoremap <Up> <C-w><Up>
nnoremap <Down> <C-w><Down>

" make splits work the same as in tmux
nnoremap <Leader>x :q<CR>
nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>- :sp<CR>


" Plugins
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'sainnhe/everforest'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

"           _
"  ___ ___ | | ___  _ __ ___
" / __/ _ \| |/ _ \| '__/ __|
"| (_| (_) | | (_) | |  \__ \
" \___\___/|_|\___/|_|  |___/
"
set background=dark
colorscheme everforest

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"       _   _
"  ___ | |_| |__   ___ _ __
" / _ \| __| '_ \ / _ \ '__|
" | (_) | |_| | | |  __/ |
" \___/ \__|_| |_|\___|_|
"

" Encoding
set encoding=UTF-8

" Case insensitive search
set ic
set hlsearch  " Higlhight search
set incsearch " Find as you type search

" Wrap text instead of being on one line
set lbr
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set wildmenu " Better command-line completion
set showcmd  " Show partial commands in the last line of the screen

" not using this because it breaks :find with * for some reason
" set wildmode=longest,list,full " Command <Tab> completion, list matches, then longest common part, then all.

" Use case insensitive search, except when using capital letters
set ignorecase
" set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
" set mouse=a

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

set nofixendofline
set linespace=0       " No extra spaces between rows
set showmatch         " Show matching brackets/parenthesis
set scrolljump=5      " Lines to scroll when cursor leaves screen
set scrolloff=3       " Minimum lines to keep above and below cursor
set nofoldenable        " Auto fold code
set foldmethod=indent " fold based on indent level
set foldlevelstart=20

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set colorcolumn=160
set backspace=2 " make backspace work like most other apps

" https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set backupdir=.backup/,~/.vim/.backup/,/tmp//
set directory=.swp/,~/.vim/.swp/,/tmp//
set undodir=.undo/,~/.vim/.undo/,/tmp//

" Style splits like tmux if you are using hybrid_material
" hi VertSplit ctermfg=65
set fillchars+=vert:│

" Ex commands
" command abbreviations for typos:
ca Wq wq
ca W w
ca Q q

" show current line cursor is on
set cursorline

" Line numbers should be hybrid by default because it is more efficient to
" work with chunks of text that way. Toggle absolute numbers with `:set nornu`
" and `:set rnu`
set nu rnu

" SPLITS:
" see: https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" Indent automatically depending on filetype
"filetype indent plugin on
"set autoindent
syntax enable

" Indentation, tab to spaces
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Set syntax on
syntax on

"  _ __   ___  ___
" | '_ \ / _ \/ _ \
" | | | |  __/ (_) |
" |_| |_|\___|\___/
" neovim specific

" flash yanked section - LOVE THIS.
au TextYankPost * silent! lua vim.highlight.on_yank()

