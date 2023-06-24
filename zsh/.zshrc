# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
#li Fig pre block. Keep at the top of this file.
# sugarterm
# Get $DOTFILES_OS for darwin/wsl/linux
source $HOME/dotfiles/.dotfiles_os

# If you come from bash you might have to change your $PATH.
# export PATH=$PATH:$HOME/bin:/usr/local/bin:/usr/local/sbin
export PATH=$HOME/bin:$HOME/dasht/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# if not using WSL i reccomend using these plugins as well, but WSL needs all the help it can get.
#git
#bundler
#dotenv
#osx
#rake
#ruby
plugins=(
  colored-man-pages
  vi-mode
)

# load ohmyzsh
source $ZSH/oh-my-zsh.sh

# load starship
eval "$(starship init zsh)"

# User configuration

# ripgrep config
export RIPGREP_CONFIG_PATH=$HOME/ripgrep.rc

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# configs
export XDG_CONFIG_HOME=~/.config

# neovimmm
export EDITOR='nvim'

# Aliases
source $HOME/.zsh_aliases/common
source $HOME/.zsh_aliases/figlet
source $HOME/.zsh_aliases/fzf
source $HOME/.zsh_aliases/git
source $HOME/.zsh_aliases/ls
source $HOME/.zsh_aliases/dotnet
source $HOME/.zsh_aliases/tmux
source $HOME/.zsh_aliases/zellij

# z.sh
. $HOME/bin/z.sh

# zplug
# source $HOME/.zplug/init.zsh
# zplug 'wfxr/forgit'

# Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#   zplug install
# fi

# # Then, source plugins and add commands to $PATH
# zplug load

# Syntax highlighting
if [ "$DOTFILES_OS" = "$DOTFILES_DARWIN" ]; then
  # brew
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# yarn globals
export PATH="$PATH:$(yarn global bin)"

if [ "$DOTFILES_OS" = "$DOTFILES_DARWIN" ]; then
  # openssl with brew if you need to recompile an old ruby, you need openssl 1!
  # For compilers to find openssl@1.1 you may need to set
  export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

  # For pkg-config to find openssl@1.1 you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
fi

# TODO: all this stuff needs to be in modules
# need a chef ticket.

# fzf if installed via git
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
export FZF_DEFAULT_COMMAND="find . -maxdepth 1"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# python2 / pip2
# export PATH="$PATH:/Users/jcaffey/Library/Python/2.7/bin"

# Arduino
alias arduino="arduino-cli"

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/packer packer

source /Users/jcaffey/.config/broot/launcher/bash/br

# autocomplete expand on hidden
setopt globdots

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/jcaffey/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
