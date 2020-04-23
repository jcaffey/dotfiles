sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt-get install --yes build-essential cmake curl wget git gnupg2 golang-go mono-complete python3-dev silversearcher-ag stow vim-gtk3 zsh

VAGRANT_HOME="/home/vagrant"
DOTFILES=$VAGRANT_HOME/dotfiles

cd $VAGRANT_HOME

# rvm
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source $VAGRANT_HOME/.rvm/scripts/rvm
rvm install 2.6.3
rvm --default use 2.6.3

# nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$VAGRANT_HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install 12.14.0
nvm use 12
npm install -g yarn

# ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zplug
export ZPLUG_HOME=$VAGRANT_HOME/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME

# set default shell
sudo chsh -s $(which zsh) vagrant

# spaceship prompt
export ZSH_CUSTOM=$VAGRANT_HOME/.oh-my-zsh/custom
mkdir -p $ZSH_CUSTOM/themes/spaceship-prompt
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# dotfiles
git clone https://github.com/jcaffey/dotfiles.git $DOTFILES
cd $DOTFILES
rm ~/.nvm/.npmrc ~/.zshrc
stow -v ack bin git nvm tmux vim zsh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install 

# better diffs with diff-so-fancy
yarn global add diff-so-fancy

# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# YCM
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all

# install plugins
vim +PluginInstall +qall

# backup vimrc and uncomment nord color scheme
sed -i.bak 's/" colorscheme nord/colorscheme nord/' ~/.vimrc
