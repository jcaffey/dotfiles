# vi mode
fish_vi_key_bindings

# starship
starship init fish | source

# PATH
#
# nix-darwin
fish_add_path /run/current-system/sw/bin
fish_add_path ~/bin
# fish_add_path (yarn global bin)
fish_add_path ~/flutter/bin
fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path ~/.cargo/bin
# moving from n to nix
# fish_add_path ~/.n/bin
fish_add_path ~/.rvm/bin
fish_add_path /opt/homebrew/Cellar/go/1.23.0/bin
# sqlite
fish_add_path /opt/homebrew/opt/sqlite/bin
# elastic beanstalk cli
fish_add_path ~/.ebcli-virtual-env/executables
# mason install path for nvim tools
fish_add_path ~/jcaffey/.local/share/nvim/mason/bin
# binaries from go install
fish_add_path ~/go/bin
# binutils - readelf, strings, etc...
fish_add_path /opt/homebrew/opt/binutils/bin

# nix
fish_add_path ~/.nix-profile/bin

# global ruby
fish_add_path ~/.gem/ruby/3.3.0/bin


# environment variables
set -gx RIPGREP_CONFIG_PATH $HOME/ripgrep.rc
set -gx XDG_CONFIG_HOME ~/.config
set -gx EDITOR "nvim"
set -g fish_greeting "all your base are belong to us"
set -gx N_PREFIX $HOME/.n
set -gx WWW_HOME "google.com"
set -gx BROWSER w3m

# cross compile to linux-musl
# set -gx TARGET_CC x86_64-linux-musl-gcc

# Aliases
source $HOME/.config/fish/aliases/common
source $HOME/.config/fish/aliases/git
source $HOME/.config/fish/aliases/ls
source $HOME/.config/fish/aliases/tailscale.fish
source $HOME/.config/fish/aliases/terraform
source $HOME/.config/fish/aliases/tmux
source $HOME/.config/fish/aliases/w3m
source $HOME/.config/fish/aliases/yazi.fish

# functions
source $HOME/.config/fish/functions/mkd.fish
source $HOME/.config/fish/functions/figlet.fish
source $HOME/.config/fish/functions/git.fish
source $HOME/.config/fish/functions/yazi.fish

# cd to parent dir of git repo (git parengit parenet)
function gp
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

# zoxide
zoxide init fish | source

# TODO: use BASS and fisher for install
# source $HOME/.config/fish/nnn.sh

# TODO: setup rvm ... it complains that wezterm isnt a login shell
# rvm default

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
