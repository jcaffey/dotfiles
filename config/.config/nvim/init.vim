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

" flash yanked section
au TextYankPost * silent! lua vim.highlight.on_yank()

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

" Case insensitive search - do we need this in neovim?
" set ic
" set hlsearch  " Higlhight search
" set incsearch " Find as you type search
