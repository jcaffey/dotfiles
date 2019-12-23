## dotfiles for an efficient and awesome terminal
Manage dotfiles with GNU stow

OSX: `brew install stow`
Ubuntu: todo

Windows:
1. sudo apt install stow

2. checkout dotfiles

3. stow -vn package-name to see what files will be moved, this will perform a dry run. your filesystem will not be changed. Recommended packages: hyper, vifm, vim, tmux, zsh

4. stow will not override any existing files unless you force it to, i recommend moving your files to a .dotfiles_backup directory like this: mkdir ~/.dotfiles_backup

5. stow -v package-name Example: stow -v vim

6. some packages require additional setup, so TODO: make shell script to run stow for each package along with installing plugins, etc... actually, just make a .last-dotfiles so users can always have a backup of their last dotfile settings, similar to oh my zsh setup.

Clone this repo: 
`
git clone https://github.com/jcaffey/dotfiles.git ~/dotfiles && cd ~/dotfiles && echo "stow [ options ] package"
`

## TODO

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
* [ ] git aliases: status, commit, add, etc..
* [ ] explain vi mode awesomness in shell
* [ ] create setup guide: fonts, terminal emulator, gotchas, etc...
* [ ] install script
