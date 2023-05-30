-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--  __  __    _    ____  ____
-- |  \/  |  / \  |  _ \/ ___|
-- | |\/| | / _ \ | |_) \___ \
-- | |  | |/ ___ \|  __/ ___) |
-- |_|  |_/_/   \_\_|   |____/
--
--
-- move cursor with arrows
vim.keymap.set("n", "<left>", "<C-w>h", {
  noremap = true,
  desc = "move cursor to split left",
})

vim.keymap.set("n", "<right>", "<C-w>l", {
  noremap = true,
  desc = "move cursor to split right",
})

vim.keymap.set("n", "<up>", "<C-w>k", {
  noremap = true,
  desc = "move cursor to split above",
})

vim.keymap.set("n", "<down>", "<C-w>j", {
  noremap = true,
  desc = "move cursor to split below",
})

-- source
vim.keymap.set("n", "<leader><cr>", ":source ~/.config/nvim/init.lua<cr>", {
  noremap = true,
  desc = "source config",
})

-- paste from *
vim.keymap.set({ "n", "v" }, "<leader>P", '"*p', {
  noremap = true,
  desc = "paste from * register",
})

-- yank to *
vim.keymap.set({ "n", "v" }, "<leader>Y", '"*y', {
  noremap = true,
  desc = "yank to * register",
})

-- move selected lines up and down with j/k
vim.keymap.set({ "n", "v" }, "<leader>j", ":m '>+1<cr>gv=gv", {
  noremap = true,
  desc = "move selected line down",
})

vim.keymap.set({ "n", "v" }, "<leader>k", ":m '<-2<cr>gv=gv", {
  noremap = true,
  desc = "move selected line up",
})

-- use tab and shift-tab to cycle tabs
vim.keymap.set({ "n", "v" }, "<tab>", ":BufferLineCycleNext<cr>", {
  noremap = true,
  desc = "next tab",
})

vim.keymap.set({ "n", "v" }, "<S-Tab>", ":BufferLineCyclePrev<cr>", {
  noremap = true,
  desc = "previous tab",
})

vim.keymap.set({ "n", "v" }, "<leader>\\", ":vsplit<cr>", {
  noremap = true,
  desc = "vertical split",
})

-- TODO: lots more!
-- " paste multiple times
-- vnoremap <leader>p "_dP
--
--
-- " quickfix list
-- nnoremap <leader>qf :copen<cr>
-- nnoremap <leader>j :cnext<cr>
-- nnoremap <leader>k :cprev<cr>
--
-- " Telescope
-- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- nnoremap <leader>gf <cmd>Telescope git_files<cr>
-- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- nnoremap <leader>fh <cmd>Telescope help_tags<cr>
--
-- " Explore
-- nnoremap <leader>e :Vex<cr>
--
-- " Use <Leader>l to toggle line numbers. This is useful when copying something from vim
-- " while using tmux and you don't want lines.
-- nnoremap <leader>l :set nu! rnu!<CR>
--
--
-- " navigate panes with arrows
-- nnoremap <Left> <C-w><Left>
-- nnoremap <Right> <C-w><Right>
-- nnoremap <Up> <C-w><Up>
-- nnoremap <Down> <C-w><Down>
--
-- " make splits work the same as in tmux
-- nnoremap <Leader>x :q<CR>
-- nnoremap <Leader>\ :vsp<CR>
-- nnoremap <Leader>- :sp<CR>
--
-- " get rid of highlights with <esc><esc>
-- nnoremap <leader>h :nohl<cr>
--
-- " buffers
-- nnoremap <leader>] :bnext<cr>
-- nnoremap <leader>[ :bprev<cr>
--
-- "           _
-- "  ___ ___ | | ___  _ __ ___
-- " / __/ _ \| |/ _ \| '__/ __|
-- "| (_| (_) | | (_) | |  \__ \
-- " \___\___/|_|\___/|_|  |___/
-- "
-- set background=dark
-- colorscheme everforest
--
-- if exists('+termguicolors')
--   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
--   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
--   set termguicolors
-- endif
--
-- "       _   _
-- "  ___ | |_| |__   ___ _ __
-- " / _ \| __| '_ \ / _ \ '__|
-- " | (_) | |_| | | |  __/ |
-- " \___/ \__|_| |_|\___|_|
-- "
--
-- " Encoding
-- set encoding=UTF-8
--
-- " Case insensitive search
-- set ic
-- set hlsearch  " Higlhight search
-- set incsearch " Find as you type search
--
-- " Wrap text instead of being on one line
-- set lbr
-- set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
--
-- set wildmenu " Better command-line completion
-- set showcmd  " Show partial commands in the last line of the screen
--
-- " not using this because it breaks :find with * for some reason
-- " set wildmode=longest,list,full " Command <Tab> completion, list matches, then longest common part, then all.
--
-- " Use case insensitive search, except when using capital letters
-- set ignorecase
-- " set smartcase
--
-- " Allow backspacing over autoindent, line breaks and start of insert action
-- set backspace=indent,eol,start
--
-- " Always display the status line, even if only one window is displayed
-- set laststatus=2
--
-- " Instead of failing a command because of unsaved changes, instead raise a
-- " dialogue asking if you wish to save changed files.
-- set confirm
--
-- " Enable use of the mouse for all modes
-- set mouse=a
--
-- " Quickly time out on keycodes, but never time out on mappings
-- set notimeout ttimeout ttimeoutlen=200
--
-- set nofixendofline
-- set linespace=0       " No extra spaces between rows
-- set showmatch         " Show matching brackets/parenthesis
-- set scrolljump=5      " Lines to scroll when cursor leaves screen
-- set scrolloff=3       " Minimum lines to keep above and below cursor
-- set nofoldenable        " Auto fold code
-- set foldmethod=indent " fold based on indent level
-- set foldlevelstart=20
--
-- set list
-- set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
-- set colorcolumn=160
-- set backspace=2 " make backspace work like most other apps
--
-- " https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
-- set backupdir=.backup/,~/.vim/.backup/,/tmp//
-- set directory=.swp/,~/.vim/.swp/,/tmp//
-- set undodir=.undo/,~/.vim/.undo/,/tmp//
--
-- " Style splits like tmux if you are using hybrid_material
-- " hi VertSplit ctermfg=65
-- set fillchars+=vert:│
--
-- " Ex commands
-- " command abbreviations for typos:
-- ca Wq wq
-- ca W w
-- ca Q q
--
-- " show current line cursor is on
-- set cursorline
--
-- " Line numbers should be hybrid by default because it is more efficient to
-- " work with chunks of text that way. Toggle absolute numbers with `:set nornu`
-- " and `:set rnu`
-- set nu rnu
--
-- " SPLITS:
-- " see: https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
-- set splitbelow
-- set splitright
--
-- " Indent automatically depending on filetype
-- "filetype indent plugin on
-- "set autoindent
-- syntax enable
--
-- " Indentation, tab to spaces
-- set smartindent
-- set tabstop=4
-- set shiftwidth=4
-- set softtabstop=4
-- set expandtab
--
-- " Set syntax on
-- syntax on
-- -- abbreviations
-- vim.abbreviations.set("")

-- tabs
-- todo:fixme
-- vim.keymap.set({ "n", "v" }, "<leader><j>", "<cmd>tabprev<cr>", {
--   noremap = true,
--   desc = "move cursor to split below",
-- })
