set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " Plugins
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'colepeters/spacemacs-theme.vim'
  Plugin 'pablopunk/sunset.vim'
  Plugin 'sunaku/vim-dasht'
  Plugin 'preservim/tagbar'
  Plugin 'rust-lang/rust.vim'
  Plugin 'dracula/vim', { 'name': 'dracula' }
  Plugin 'lifepillar/vim-colortemplate'
  Plugin 'cocopon/iceberg.vim'
  Plugin 'arcticicestudio/nord-vim'
  Plugin 'benmills/vimux'
  Plugin 'bluz71/vim-nightfly-guicolors'
  Plugin 'chrisbra/unicode.vim'
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'easymotion/vim-easymotion'
  Plugin 'edkolev/tmuxline.vim'
  Plugin 'ervandew/supertab'
  Plugin 'godlygeek/tabular'
  Plugin 'honza/vim-snippets'
  Plugin 'jlanzarotta/bufexplorer'
  Plugin 'junegunn/fzf', { 'do': './install --bin' }
  Plugin 'junegunn/fzf.vim'
  Plugin 'luochen1990/rainbow'
  Plugin 'mileszs/ack.vim'
  Plugin 'morhetz/gruvbox'
  Plugin 'NLKNguyen/papercolor-theme'
  Plugin 'pineapplegiant/spaceduck', { 'branch': 'main' }
  Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plugin 'rafi/awesome-vim-colorschemes'
  Plugin 'sainnhe/everforest'
  Plugin 'roxma/vim-tmux-clipboard'
  Plugin 'ryanoasis/vim-devicons'
  Plugin 'SirVer/ultisnips'
  Plugin 'skalnik/vim-vroom'
  Plugin 'tmux-plugins/vim-tmux-focus-events'
  Plugin 'tpope/vim-eunuch'
  Plugin 'tpope/vim-commentary'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-vinegar'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'vim-ruby/vim-ruby'
  " Plugin 'dense-analysis/ale'
  Plugin 'ycm-core/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required

" Tagbar
nmap <F8> :TagbarToggle<CR>

" ALE
"" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
" let g:ale_completion_enabled = 1

" use ALE
" set omnifunc=ale#completion#OmniFunc
" let g:ale_linters = {'rust': ['cargo']}

" YCM
set omnifunc=syntaxcomplete#Complete
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nmap <leader>fsw <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>fsd <Plug>(YCMFindSymbolInDocument)
nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gD :YcmCompleter GoToDeclaration<CR>

let g:ycm_auto_hover = "off"
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<Enter>', '<TAB>', '<Down>']
let g:ycm_key_list_stop_completion = ['<C-y>']

" inc/dec numbers and chars
set nrformats+=alpha

" build tags
set tags=./tags;/

" disable ycm
let g:ycm_show_diagnostics_ui = 0

" better tab bindings
nnoremap tk :tabnext<cr>
nnoremap tj :tabprev<cr>

command! PrettyPrintJSON %!python -m json.tool
command! PrettyPrintHTML !tidy -mi -html -wrap 0 %
command! PrettyPrintXML !tidy -mi -xml -wrap 0 %

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this linel plug#end()

" Plugin settings

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Ultisnips
" let g:UltiSnipsExpandTrigger="<S-tab>"
" let g:UltiSnipsJumpForwardTrigger="<C-l>"
" let g:UltiSnipsJumpBackwardTrigger="<c-K>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" devicons
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" Fugitive
set diffopt+=vertical

" Use ag instead of ack
let g:ackprg = 'ag --hidden'

" vroom
let g:vroom_use_vimux = 1

" rainbow
" only turn this on if using nord colorscheme.
" i find it quite annoying in other colorschemes, but nord
" is clearly the best colorscheme ever, so just use nord. duh.
let g:rainbow_active = 1

" NEOVIM SPECIFIC CONFIG
if !has('nvim')
  " Get the defaults that most users want.
  source $VIMRUNTIME/defaults.vim
endif

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
" let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings


"  __  __    _    ____  ____
" |  \/  |  / \  |  _ \/ ___|
" | |\/| | / _ \ | |_) \___ \
" | |  | |/ ___ \|  __/ ___) |
" |_|  |_/_/   \_\_|   |____/

" I'm using space as the leader key because it's hard to miss, doesn't do
" anything useful in normal/visual mode and both hands can reach it easily
noremap <Space> <Nop>
map <Space> <Leader>

" buffers
nnoremap <c-b> :BufExplorer<cr>

" preview files - equivalent of Ctrl+p in other editors
nnoremap <C-f> :Files<CR>

" <Leader> o and O to open line above/below without insert mode
nnoremap <Leader>o o<esc>
nnoremap <Leader>O O<esc>

" Disable arrow keys to get used to hjkl movement
" Make this optional
" nnoremap <Left> :echo "don't be stupid."<CR>
" vnoremap <Left> :<C-u>echo "don't be stupid."<CR>
"
" nnoremap <Right> :echo "don't be stupid."<CR>
" vnoremap <Right> :<C-u>echo "don't be stupid."<CR>
"
" nnoremap <Up> :echo "don't be stupid."<CR>
" vnoremap <Up> :<C-u>echo "don't be stupid."<CR>
"
" nnoremap <Down> :echo "don't be stupid."<CR>
" vnoremap <Down> :<C-u>echo "don't be stupid."<CR>
"

" completion
set complete=".,w,b,u,t,i"

" Call noh on esc+esc because just escape causes vim bugs
" like starting in replace mode.
" nnoremap <esc> :noh<CR>
nnoremap <esc><esc> :noh<CR>

" Use <Leader>l to toggle line numbers. This is useful when copying something from vim
" while using tmux and you don't want lines.
nnoremap <Leader>l :set nu! rnu!<CR>

" toggle netrw
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" file explorer
nnoremap <c-e> :call ToggleNetrw()<cr>
nnoremap <Leader>e  :call ToggleNetrw()<cr>

" SPLITS:
" see: https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright


" navigate panes with arrows
nnoremap <Left> <C-w><Left>
nnoremap <Right> <C-w><Right>
nnoremap <Up> <C-w><Up>
nnoremap <Down> <C-w><Down>

" make splits work the same as in tmux
nnoremap <Leader>x :q<CR>
nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>- :sp<CR>

" Encoding
set encoding=UTF-8

" show current line cursor is on
set cursorline

"let g:enable_bold_font = 1
"let g:enable_italic_font = 1
"let g:hybrid_transparent_background = 1
" Disable tmuxline since tmux.conf has lines to source-file theme
let g:airline#extensions#tmuxline#enabled = 0 " dont change tmux status line to what is in vim

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
" ----------------------------------------
let g:EasyMotion_do_mapping = 1 " disable default mappings
map <Leader> <Plug>(easymotion-prefix)

" This is the 'minimal' easymotion config, I like `s` for {char}{char} searches as 1 char tends to make me type longer anchors like ';f' and i'd rather just type 2 chars im looking for. s is also mnemonic for search or seek and I don't mind using x and i to do a character substituion + insert mode.
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

"   Mapping              | Details
" ----------------------------------------
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
"   <Leader>s                    | Find(Search) {char}{char} forward and backward.
"                        | See |f| and |F|.

" Indent automatically depending on filetype
"filetype indent plugin on
"set autoindent
syntax enable

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

" not using this because it breaks :find with * for some reason
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
set nofoldenable        " Auto fold code
" set foldmethod=indent " fold based on indent level
" set foldlevelstart=20

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
cnoreabbrev lc lclose

" nord comments arent readable to me unless they are bold
highlight Comment cterm=bold
highlight Visual ctermbg=red

" Templates
if has("autocmd")
  augroup templates
    autocmd BufNewFile *.cs 0r ~/.vim/templates/csharp
  augroup END
endif

" Tabs
if has("autocmd")
  augroup tabs
    autocmd FileType *.cs set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  augroup END
endif

" colors
set background=dark
" this is great with monokai theme for status
" colorscheme sunset
colorscheme everforest
" colorscheme nord
" colorscheme dracula
" colorscheme monokai
" colorscheme sunset
" colorscheme iceberg
" colorscheme onedark
" colorscheme nightfly
" colorscheme Tomorrow-Night
" colorscheme spaceduck
" set t_Co=256
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

