# install
In MacOS you need to disable shortcuts for ctrl+arrows in System Preferences -> Keyboard -> Shortcuts. Uncheck the boxes for mission control labeled `^->`, `^<-`, etc...

## zsh
1. TODO: Install zsh if lt 5.2
2. TODO: Install oh my zsh
3. TODO: Install nerd font
4. TODO: Install powerline font
5. Install spaceship
```shell
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```
Install nvm: curl -o- `https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash`
Set default node: `nvm use 12 && nvm alias default 12`
Install utility programs. Unless noted, each app can be installed with either:
  OSX: `brew install package`
  Ubuntu: `sudo apt update` then `sudo apt install package`
  - yarn
  - fzf `git clone --depth 1 https://github.com/junegunn/fzf.git ~/bin/fzf && ~/bin/fzf/install` answer y to prompts, reload .zshrc with `reload`
  - urlview
  - diff-so-fancy `yarn global add diff-so-fancy`
  - ag (faster ack) sudo apt install silversearcher-ag
  - tig
6. Install zplug: curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
6. Mac only: Install homebrew
7. Install GNU stow

NOTE: you need a bash installed and available in your $PATH for my tmux config to work correctly. If you are on MacOS Catalina, you can just `brew install bash`
Install tmux `brew install tmux`
Clone TPM repository `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
`prefix + I` to install plugins
Now you can `prefix + ctrl-s` to save your session between reboots or just let tmux continuum save it for you every 15 minutes. Vim sessions will automatically be restored if you are using my config via vim-obsession.

Manage dotfiles with GNU stow

OSX: `brew install stow`

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
zplug
