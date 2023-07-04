# vi mode
fish_vi_key_bindings

# starship
starship init fish | source

# PATH
fish_add_path ~/bin
fish_add_path (yarn global bin)

# environment variables
set -gx RIPGREP_CONFIG_PATH $HOME/ripgrep.rc
set -gx XDG_CONFIG_HOME ~/.config
set -gx EDITOR 'nvim'
set -g fish_greeting "all your base are belong to us"

# Aliases
source $HOME/.config/fish/aliases/common
source $HOME/.config/fish/aliases/git
source $HOME/.config/fish/aliases/ls
source $HOME/.config/fish/aliases/tmux

# TODO: write a new function for figlet in fish
# source $HOME/.zsh_aliases/figlet
# TODO: zellij is still bash
# source $HOME/.zsh_aliases/zellij

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
fish_add_path "$HOME/.rvm/bin" 
