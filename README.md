## dotfiles for an efficient and awesome terminal

In MacOS you need to disable shortcuts for ctrl+arrows in System Preferences -> Keyboard -> Shortcuts. Uncheck the boxes for mission control labeled ^->, ^<-, etc...

1. Install zsh if < 5.2
2. Install oh my zsh
3. Install nerd font
4. Install powerline font
5. Install spaceship
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
6. Install homebrew
7. brew install stow
NOTE: you need a bash installed and available in your $PATH for my tmux config to work correctly. If you are on MacOS Catalina, you can just `brew install bash`
Install tmux `brew install tmux`
Clone TPM repository `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
`prefix + I` to install plugins
Now you can `prefix + ctrl-s` to save your session between reboots or just let tmux continuum save it for you every 15 minutes. Vim sessions will automatically be restored if you are using my config via vim-obsession.
need env variables for things like fonts, paths, etc...

Manage dotfiles with GNU stow

OSX: `brew install stow`
Ubuntu: todo

Windows:
1. sudo apt install stow

2. checkout dotfiles

3. stow -vn package-name to see what files will be moved, this will perform a dry run. your filesystem will not be changed. Recommended packages: hyper, vifm, vim, tmux, zsh

4. stow will not override any existing files unless you force it to, i recommend moving your dotfiles to a directory like this: `mkdir ~/.dotfiles-last && mv ~/.* ~/.dotfiles-last` (automate this and have it automatically do a cp)

You can also use stow's `--adopt` option to replace the existing file with a symbolic link and move that file to the dotfiles repo.

5. stow -v package-name Example: stow -v vim

6. some packages require additional setup, so TODO: make shell script to run stow for each package along with installing plugins, etc... actually, just make a .last-dotfiles so users can always have a backup of their last dotfile settings, similar to oh my zsh setup.

Clone this repo: 
`
git clone https://github.com/jcaffey/dotfiles.git ~/dotfiles && cd ~/dotfiles && echo "stow [ options ] package"
`

## TODO
* [ ] introduce snippets concept with `:0r!snip todo.md | sed 's/new/add vimux + rspec to environment for jojo/'`
* [ ] tmux new pane vim pwd / shell pwd
* [ ] make note about using % with `:!cp % ~/.last_dotfiles` for backing up files in vim
* [ ] figure out how to use tmux panes with multiple vim sessions and not have to deal with swap overwriting issues...
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
