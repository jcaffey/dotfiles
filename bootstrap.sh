VAGRANT_HOME="/home/vagrant"
sudo apt-get update
sudo apt-get install --yes curl git silversearcher-ag stow vim-gtk3 zplug zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
zsh
chsh -s $(which zsh) vagrant
git clone -b vagrant https://github.com/jcaffey/dotfiles $VAGRANT_HOME/dotfiles
git clone https://github.com/zplug/zplug $VAGRANT_HOME/.zplug
DOTFILES_HOME=$VAGRANT_HOME
cd $VAGRANT_HOME/dotfiles
stow -v ack bin git nvm tmux vim zsh
NVM_PATH=$VAGRANT_HOME/.nvm
mkdir -p $NVM_PATH
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | NVM_DIR=$NVM_PATH zsh
#source $VAGRANT_HOME/.zshrc
