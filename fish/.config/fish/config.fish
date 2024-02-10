# vi mode
fish_vi_key_bindings

# starship
starship init fish | source

# PATH
fish_add_path ~/bin
fish_add_path (yarn global bin)
fish_add_path ~/flutter/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.n/bin
fish_add_path ~/.rvm/bin
fish_add_path /opt/homebrew/opt/go@1.20/bin

# environment variables
set -gx RIPGREP_CONFIG_PATH $HOME/ripgrep.rc
set -gx XDG_CONFIG_HOME ~/.config
set -gx EDITOR 'nvim'
set -g fish_greeting "all your base are belong to us"
set -gx N_PREFIX $HOME/.n
set -gx TARGET_CC x86_64-linux-musl-gcc

# Aliases
source $HOME/.config/fish/aliases/common
source $HOME/.config/fish/aliases/git
source $HOME/.config/fish/aliases/ls
source $HOME/.config/fish/aliases/terraform
source $HOME/.config/fish/aliases/tmux
source $HOME/.config/fish/aliases/yazi.fish

abbr --add python python3

# functions
source $HOME/.config/fish/functions/yazi.fish

# zoxide
zoxide init fish | source

# TODO: use BASS and fisher for install
# source $HOME/.config/fish/nnn.sh

# TODO: setup rvm ... it complains that wezterm isnt a login shell
# rvm default
