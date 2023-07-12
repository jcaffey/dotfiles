```ascii

     8          o   d'b  o 8
     8          8   8      8
.oPYo8 .oPYo.  o8P o8P  o8 8 .oPYo. .oPYo.
8    8 8    8   8   8    8 8 8oooo8 Yb..
8    8 8    8   8   8    8 8 8.       'Yb.
`YooP' `YooP'   8   8    8 8 `Yooo' `YooP'
:.....::.....:::..::..:::....:.....::.....:
:::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::
```

# dotfiles for an efficient and awesome terminal

- [ ] nnn vs neotree?
- [ ] nnn vs vifm?
- [ ] learn nnn an alias to n

##todo: repo completion please

## null-ls is frozen.consider ALE

## bash 2 basics debugui and DAP

## switching to wezterm
- [x] configure!

## switching to fish
- [x] move rest of zsh aliases
- [x] rewrite functions in fish
- [ ] check to see if cargo is working properly under fish - if not look at ~/.cargo/env
- [x] tmux craps the bed when starting in fish :(

## MAGIC OF Z
i hate using ^ to get to the beginning of a line because i always hit the wrong key.
use `z.`!!!

## todo
- [ ] fzf from command line
- [x] enable stage manager to hide desktop icons and rice out vim with transparency
- [ ] set cursorline
- [x] caps lock as escape
- [x] terminal key map?
- [x] focus vim window fullscreen - <c-w>o
- [ ] why are my spectre paths not working?
- [x] moving on terminal line more efficiently
- [ ] telescope selections - can i close multiple buffers with this?
- [x] floating terminals? ... i like those. - alt+i
- [x] use alt-h to toggle horizontal term. i like this better.
- [x] <leader>fh is a blessing for finding help tags!!!
- [x] keymap to escape terminal mode? - <Ctrl-x>
- [ ] learn how to use gitsigns
- [ ] workspaces?
- [x] <leader>x not closing buffer :(
- [x] ctrl-b and ctrl-e for beginning/end of line

## going to nvchad
- [x] j and k are slow - default mapping has this to work with j/k in wrapped lines
- [x] add mappings for window movement with arrow keys
- [x] alias :W because you cant type apparently
- [x] add neovim yank autocommand to highlight yanked section
- [x] get tailwind support back - see how lazyvim does this - its in lspconfig
- [x] separate clipboards...
- [x] add lazy git

## buffers
<leaderl>b new buffer
<leader>x close buffer

## comments
<leader>/ works in both normal and insert

## lsp
gd goto definition
gD goto declaration

## telescope
<leader>ff find files
<leader>fa find all
<leader>fw find word (live grep)
<leader>fb find buffer
<leader>fh find help tags
<leader>fo find old files - whats this?
<leader>fz find in buffer - LOVE THIS

## git
<leader>cm telescope git commits
<leader>gt telescope git status

## terminal
<leader>pt telescope terminals
TODO: alacritty isnt sending alt with option key
<A-i> floating terminal
<A-h> horizontal terminal
<A-v> vertical terminal

## bookmarks
`m R` to mark file under R then...
<leader>ma telescope bookmarks

## keymaps
<leader>wK - which key to view all keymaps

## todo:
hows <leader>cc work? cc is current context

## lsp servers
TODO:
ruby lsp
rubyfmt
rustfmt

## linters
null-ls - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
swiftlint
eslint
etc...


## usage with vagrant

NOTE: this is probably broken at the moment. I don't know. #todo

```shell
git clone https://github.com/jcaffey/dotfiles
cd dotfiles
vagrant up
```

## bufferline

shift and shift+tab to cycles tabs
<leader>kt - keep tab to pin tab
:BufferLineCloseRight - close all tabs to right

## nvim-cmp

## luasnip

## friendly-snippets

## mini.ai - this is what you use for tags

{( abc )}
"stringinsidequotes"

- VAT - VISUAL AROUND TAG
- vit - visual IN tag

try it...

```html
<div>contnt</div>
```

- vatat - visual AROUND tag 2 levels up
- vitit - visual IN tag 2 levels up

try it...

```html
<div>
  <p>content</p>
</div>
```

- use a for argument motion
  function (a, b, c)

this deserves more understanding for sure.
https://github.com/echasnovski/mini.ai

## nvim surround

    Old text                    Command         New text

    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls

## neotest

https://www.lazyvim.org/plugins/extras/test.core

## leap and flit

- im not sure about this.. we will try
  `s` two characters to search forward and jump to label
  `f` or `t` and 1 char to search forward and jump to label

## dap

- [ ] todo the voodoo baby yeahhhh

## undotree

- :UndotreeToggle - never lose changes - even outside of git

## spectre is awesome

- <leader>sr for spectre search/Replace
- enter search and narrow by file glob
- <leader>q to send all files to qf list
- <leader>rc to Replace Current

## mini surround

- [ ] todo: go back to tpope's surround - need tag support at least

* gza Add surrounding n, v
* gzd Delete surrounding n
* gzf Find right surrounding n
* gzF Find left surrounding n
* gzh Highlight surrounding n
* gzr Replace surrounding n ... this one kinda sucks...

```text
surroundme
surround me
other text "surround me" more text
fn t: i32 (a: i32, b: i32) {
  // make me a different scope - surround me
  surround me
}
```

## guided installation for WSL users

guides/wsl/setup.txt

## vim

guides/vim/\*

## tmux

guides/tmux/\*

## don't forget the power of z.sh

## TODO

- [ ] vim context (so dope)
- [ ] ag, tig, fpp, urlviewer, tmux-copycat|yank|open
- [ ] seems like we need a git section since fpp, tig, git gutter, and fugitive kick so much ass
- [ ] vim git gutter
- [ ] bat for markdown, gitignore, etc..
- [ ] forgit + diff-so-fancy
- [ ] giphy recorder + screen keys
- [ ] Did you know that most google apps use the vim keybindings? You can just open gmail and use j/k to move up and down! https://medium.com/@gregsramblings/gmail-keyboard-shortcuts-using-3c845bb77043
- [ ] add examples for :0r %:h/darwin.conf with tmux darwin/wsl config in vim guide
- [ ] rainbow is a shitty plugin but it's useful and can reset with `:e`
- [ ] that last thing you copied as you get better with vim
- [ ] tabularize examples: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
- [ ] `vi}`, `vi[`, `vi(` for json, arrays, arguments
- [ ] zplug: curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
- [ ] rspec By default vroom maps <Leader>r to |VroomRunTestFile|, <Leader>R to
      |VroomRunNearestTest| and <Leader>l to VroomRunLastTest. This can be turned off
      by simply putting `let g:vroom_map_keys = 0` in your vimrc.
- [ ] `:lcl` and `:ccl` for location window close and quick fix window close respectively. (use `:lcl` with syntastic)
- [ ] nerd tree `<Leader>+s` to search for dir
- [ ] nerd tree cd and CD also, cd + ctrl+p or fzf
- [ ] nerd commenter: `<leader>c space` toggle
- [ ] https://geoff.greer.fm/ag/speed/ ack vs ag
- [ ] add pwd to airline
- [ ] surround `v$` vs `vf{char}` behaves different at end of line!
- [ ] `escape` vs `ctrl+[`
- [ ] section on vim types, flags, and +clipboard
- [ ] vim copy to unix/windows clipboard * register: `V"*y`to yank and`"\*p` to put.
- [ ] start moving dotfiles to .sugar for sugar term
- [ ] why sugar term TL;DR because it kicks ass, but mostly because i have so many thoughts in my crazy brain i can't keep up with them and i need to be efficient
  - no mouse days. make everything hard, so you can be awesome later.
  - `gpg --list-secret-keys --keyid-format long | sed -n -e '3s/.*\///p' | sed -e 's/ .*//' | pbcopy`
- [ ] `yf]` example for mardkdown list
- [ ] introduce snippets concept with `:0r!snip todo.md | sed 's/new/add vimux + rspec to environment for jojo/'`
- [ ] tmux new pane vim pwd / shell pwd
- [ ] make note about using % with `:!cp % ~/.last_dotfiles` for backing up files in vim
- [x] rubocop runner + highlighting
- [x] tmux statusline fix when in vim
- [x] tmux-resurrect and tmux-continuum
- [x] vifm
- [x] stow
- [x] dotfiles repo
- [x] swap folder
- [x] vim windows in tmux use leader arrows and show divider
- [x] tmux pane sizing - <Leader>+ctrl+{down|up|left|right}
- [ ] lf + aliases
- [ ] xml format
- [ ] json format
- [ ] vim jump to method / youtube video on ios
- [ ] vim c# / .net
- [ ] windows vim
- [ ] setup / walkthrough / ideology w/ workflow
- [ ] folder structure. nothing in ~ except dotfiles please.
- [ ] instantly better vim extensions - highlight
- [ ] symlink Desktop
- [ ] toggle number line issue
- [x] git aliases: status, commit, add, etc..
- [ ] explain vi mode awesomness in shell
- [ ] create setup guide: fonts, terminal emulator, gotchas, etc...
- [ ] install script
  - zsh, ohmyzsh, git, bash, spaceship, rvm, ruby, yarn, nvm, node 12, gpg, mutt, figlet, vifm, vim/macvim/gvim, tmux, vundle, tpm, pass, curl, wget, brew, apt, monoid nerd font, powerline symbols, ag, ack, fzf
- [ ] fix tmux + vim arrow keys between panes and windows
- [ ] fix status bar color in tmux + vim
- [ ] netrw `i` cycle views
- [ ] remove hyper in favor of alacritty and add alacritty yml
- [ ] aliases using exa with ls - TODO: install exa
