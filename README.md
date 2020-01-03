## dotfiles for an efficient and awesome terminal
Did you know that most google apps use the vim keybindings? You can just open gmail and use j/k to move up and down!

https://medium.com/@gregsramblings/gmail-keyboard-shortcuts-using-3c845bb77043

## TODO
* [ ] add examples for :0r %:h/darwin.conf with tmux darwin/wsl config in vim guide
* [ ] rainbow is a shitty plugin but it's useful and can reset with `:e`
* [ ] that last thing you copied as you get better with vim
* [ ] tabularize examples: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
* [ ] `vi}`, `vi[`, `vi(` for json, arrays, arguments
* [ ] bat for markdown, gitignore, etc..
* [ ] forgit + diff-so-fancy
* [ ] zplug: curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
* [ ] rspec By default vroom maps <Leader>r to |VroomRunTestFile|, <Leader>R to
|VroomRunNearestTest| and <Leader>l to VroomRunLastTest. This can be turned off
by simply putting `let g:vroom_map_keys = 0` in your vimrc.
* [ ] `:lcl` and `:ccl` for location window close and quick fix window close respectively. (use `:lcl` with syntastic)
* [ ] nerd tree `<Leader>+s` to search for dir
* [ ] nerd tree cd and CD also, cd + ctrl+p or fzf
* [ ] ag, tig, fpp, urlviewer, tmux-copycat|yank|open
* [ ] seems like we need a git section since fpp, tig, git gutter, and fugitive kick so much ass
* [ ] vim git gutter
* [ ] nerd commenter: `<leader>c space` toggle
* [ ] https://geoff.greer.fm/ag/speed/ ack vs ag
* [ ] add pwd to airline
* [ ] surround `v$` vs `vf{char}` behaves different at end of line!
* [ ] `escape` vs `ctrl+[`
* [ ] section on vim types, flags, and +clipboard
* [ ] vim copy to unix/windows clipboard * register: `V"*y` to yank and `"*p` to put.
* [ ] start moving dotfiles to .sugar for sugar term
* [ ] giphy recorder + screen keys
* [ ] why sugar term TL;DR because it kicks ass, but mostly because i have so many thoughts in my crazy brain i can't keep up with them and i need to be efficient
  - no mouse days. make everything hard, so you can be awesome later.
  - `gpg --list-secret-keys --keyid-format long | sed -n -e '3s/.*\///p' | sed -e 's/ .*//' | pbcopy`
* [ ] `yf]` example for mardkdown list
* [ ] introduce snippets concept with `:0r!snip todo.md | sed 's/new/add vimux + rspec to environment for jojo/'`
* [ ] tmux new pane vim pwd / shell pwd
* [ ] make note about using % with `:!cp % ~/.last_dotfiles` for backing up files in vim
* [x] rubocop runner + highlighting
* [x] tmux statusline fix when in vim
* [x] tmux-resurrect and tmux-continuum
* [x] vifm
* [x] stow
* [x] dotfiles repo
* [x] swap folder
* [x] vim windows in tmux use leader arrows and show divider
* [x] tmux pane sizing - <Leader>+ctrl+{down|up|left|right}
* [ ] lf + aliases
* [ ] xml format
* [ ] json format
* [ ] vim jump to method / youtube video on ios
* [ ] vim c# / .net
* [ ] windows vim
* [ ] setup / walkthrough / ideology w/ workflow
* [ ] folder structure. nothing in ~ except dotfiles please.
* [ ] instantly better vim extensions - highlight
* [ ] symlink Desktop
* [ ] toggle number line issue
* [x] git aliases: status, commit, add, etc..
* [ ] explain vi mode awesomness in shell
* [ ] create setup guide: fonts, terminal emulator, gotchas, etc...
* [ ] install script
  - zsh, ohmyzsh, git, bash, spaceship, rvm, ruby, yarn, nvm, node 12, gpg, mutt, figlet, vifm, vim/macvim/gvim, tmux, vundle, tpm, pass, curl, wget, brew, apt, monoid nerd font, powerline symbols, ag, ack, fzf
