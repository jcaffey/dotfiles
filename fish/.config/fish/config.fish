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
source $HOME/.config/fish/aliases/nnn

# jump
jump shell fish | source

# Put the line below in ~/.config/fish/config.fish:
#
#   jump shell fish | source
#
# The following lines are autogenerated:

function __jump_add --on-variable PWD
  status --is-command-substitution; and return
  jump chdir
end

function __jump_hint
  set -l term (string replace -r '^j ' '' -- (commandline -cp))
  jump hint "$term"
end

function j
  set -l dir (jump cd "$argv")
  test -d "$dir"; and cd "$dir"
end

complete --command j --exclusive --arguments '(__jump_hint)'

# nnn
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'

# TODO: use BASS and fisher for install
# source $HOME/.config/fish/nnn.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
fish_add_path "$HOME/.rvm/bin" 
