set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Plugins!
" ----------------------------------------------------------------------
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'

  " Other
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'edkolev/tmuxline.vim'
  Plugin 'easymotion/vim-easymotion'
  Plugin 'kien/ctrlp.vim'
  Plugin 'kristijanhusak/vim-hybrid-material'
  Plugin 'scrooloose/nerdtree'
  Plugin 'tpope/vim-obsession'
  Plugin 'tpope/vim-surround'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this linel plug#end()

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" enable syntax and plugins
syntax enable
filetype plugin on

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" FILE BROWSING:
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" I'm using space as the leader key because it's hard to miss, doesn't do
" anything useful in normal/visual mode and both hands can reach it easily
noremap <Space> <Nop>
map <Space> <Leader>

" Disable arrow keys to get used to hjkl movement
nnoremap <Left> :echo "don't be stupid."<CR>
vnoremap <Left> :<C-u>echo "don't be stupid."<CR>

nnoremap <Right> :echo "don't be stupid."<CR>
vnoremap <Right> :<C-u>echo "don't be stupid."<CR>

nnoremap <Up> :echo "don't be stupid."<CR>
vnoremap <Up> :<C-u>echo "don't be stupid."<CR>

nnoremap <Down> :echo "don't be stupid."<CR>
vnoremap <Down> :<C-u>echo "don't be stupid."<CR>

" Call noh on esc+esc because just escape causes vim bugs
" like starting in replace mode.
" nnoremap <esc> :noh<CR>
nnoremap <esc><esc> :noh<CR>

" Use <Leader>l to toggle line numbers. This is useful when copying something from vim
" while using tmux and you don't want lines.
nnoremap <Leader>l :set nu! rnu!<CR>

" sequences for ctrl+arrow in WSL
map <esc>b <C-Left>
map <esc>f <C-Right>
map <C-k> <C-Up>
map <C-@> <C-Down>

" sequences for shift+arrow in WSL
map <esc>[1;2D <S-Left>
map <esc>[1;2C <S-Right>
map <esc>[1;2A <S-Up>
map <esc>[1;2B <S-Down>

" map page up/down to h and l for stupid laptops
map <PageUp> h
map <PageDown> l

" Allow copy/paste between vims and system
" NOTE: this wont work in WSL even with vim-gnome +clipboard
" so just use ctrl+shift+c / ctrl+shift+v in hyper
set clipboard=unnamed

" colorscheme
set background=dark
colorscheme hybrid_material
let g:airline_theme = "hybrid"
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
let g:airline#extensions#tmuxline#enabled = 0 " source-file .hybrid-theme.tmuxline so dont update when vim opens

" Line numbers should be hybrid by default because it is more efficient to
" work with chunks of text that way. Toggle absolute numbers with `:set nornu`
" and `:set rnu`
set nu rnu

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Easy Motion
" ----------------------------------------------------------------------
let g:EasyMotion_do_mapping = 1 " Enable default mappings
map <Leader> <Plug>(easymotion-prefix)

" This is the 'minimal' easymotion config, I like `s` for {char}{char} searches as 1 char tends to make me type longer anchors like ';f' and i'd rather just type 2 chars im looking for. s is also mnemonic for search or seek and I don't mind using x and i to do a character substituion + insert mode.
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

"   Mapping              | Details
"   ---------------------|----------------------------------------------
"   <Leader>f{char}      | Find {char} to the right. See |f|.
"   <Leader>F{char}      | Find {char} to the left. See |F|.
"   <Leader>t{char}      | Till before the {char} to the right. See |t|.
"   <Leader>T{char}      | Till after the {char} to the left. See |T|.
"   <Leader>w            | Beginning of word forward. See |w|.
"   <Leader>W            | Beginning of WORD forward. See |W|.
"   <Leader>b            | Beginning of word backward. See |b|.
"   <Leader>B            | Beginning of WORD backward. See |B|.
"   <Leader>e            | End of word forward. See |e|.
"   <Leader>E            | End of WORD forward. See |E|.
"   <Leader>ge           | End of word backward. See |ge|.
"   <Leader>gE           | End of WORD backward. See |gE|.
"   <Leader>j            | Line downward. See |j|.
"   <Leader>k            | Line upward. See |k|.
"   <Leader>n            | Jump to latest "/" or "?" forward. See |n|.
"   <Leader>N            | Jump to latest "/" or "?" backward. See |N|.
"   s                    | Find(Search) {char}{char} forward and backward.
"                        | See |f| and |F|.

" Indent automatically depending on filetype
filetype indent plugin on
syntax enable
set autoindent

" Indentation, tab to spaces
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Set syntax on
syntax on

" Case insensitive search
set ic
set hlsearch  " Higlhight search
set incsearch " Find as you type search

" Wrap text instead of being on one line
set lbr
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set wildmenu " Better command-line completion
set showcmd  " Show partial commands in the last line of the screen

" not using this because it breaks fuzzy :find with * for some reason
" set wildmode=longest,list,full " Command <Tab> completion, list matches, then longest common part, then all.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

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
set foldenable        " Auto fold code
set foldmethod=indent " fold based on indent level
set foldlevelstart=20
"nnoremap <space> za   " space open/close folds

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set colorcolumn=160
set backspace=2 " make backspace work like most other apps

" Fix line numbers in vim when using tmux
highlight LineNr ctermfg=grey

" https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set backupdir=.backup/,~/.vim/.backup/,/tmp//
set directory=.swp/,~/.vim/.swp/,/tmp//
set undodir=.undo/,~/.vim/.undo/,/tmp//

" Yellow splits in vim with green splits in tmux
hi VertSplit ctermfg=yellow
