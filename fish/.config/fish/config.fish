# vi mode
fish_vi_key_bindings

# starship
source (~/.nix-profile/bin/starship init fish --print-full-init | psub)

# nix
fish_add_path /run/current-system/sw/bin
fish_add_path ~/.nix-profile/bin
fish_add_path /nix/var/nix/profiles/default/bin

# PATH
fish_add_path ~/bin
fish_add_path ~/flutter/bin
# binaries from cargo install
fish_add_path ~/.cargo/bin
# elastic beanstalk cli
fish_add_path ~/.ebcli-virtual-env/executables
# mason install path for nvim tools
fish_add_path ~/jcaffey/.local/share/nvim/mason/bin
# binaries from go install
fish_add_path ~/go/bin

# environment variables
set -g fish_greeting "all your base are belong to us"
set -gx BROWSER w3m
set -gx EDITOR "nvim"
set -gx N_PREFIX $HOME/.n
set -gx RIPGREP_CONFIG_PATH $HOME/ripgrep.rc
set -gx SHELL "fish"
set -gx WWW_HOME "google.com"
set -gx XDG_CONFIG_HOME ~/.config

# TODO: Does anything actually use this?
# I've only ever used config home and nushell
# doesn't seem to care if this is set - it wants to use
# the stupid application support path. bleh.
# set -gx XDG_DATA_HOME ~/.local

# pay-respects
pay-respects fish | source

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
source $HOME/.config/fish/functions/fzf-input.fish

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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
