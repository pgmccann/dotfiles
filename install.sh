#!/usr/bin/env bash

install_brew () {
    if brew ls --versions $1 > /dev/null; then
        echo "$1 already installed"
    else
        brew install $@
    fi
}

if [ `uname -s` = "Darwin" ]; then

    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    brew update
    brew upgrade --all

    install_brew coreutils
    install_brew moreutils
    install_brew findutils
    install_brew gnu-sed --with-default-names
    install_brew bash
    install_brew bash-completion
    install_brew wget --with-iri
    install_brew vim --override-system-vi
    install_brew grep
    install_brew screen
    install_brew ack
    install_brew ag
    install_brew git
    install_brew git-lfs
    install_brew imagemagick --with-webpi
    install_brew tree
    install_brew curl
    install_brew darksky-weather
    install_brew figlet
    install_brew jump
    install_brew lolcat
    install_brew m-cli
    install_brew make
    install_brew mas
    install_brew pandoc
    install_brew python@2
    install_brew python3
    install_brew tmux
    install_brew tree
    install_brew zsh
    install_brew zsh-autosuggestions
    install_brew zsh-completions
    install_brew zsh-git-prompt
    install_brew zsh-syntax-highlighting
    install_brew ctags

    brew cleanup

fi

pip install Pygments

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

rm -f ~/.curlrc
ln -s $SCRIPTPATH/.curlrc ~/.curlrc
rm -f ~/.editorconfig
ln -s $SCRIPTPATH/.editorconfig ~/.editorconfig
rm -f ~/.vimrc
ln -s $SCRIPTPATH/.vimrc ~/.vimrc
rm -f ~/.wgetrc
ln -s $SCRIPTPATH/.wgetrc ~/.wgetrc
rm -f ~/.zshrc
ln -s $SCRIPTPATH/.zshrc ~/.zshrc

rm -fr ~/.oh-my-zsh/custom/plugins/ccat
ln -s $SCRIPTPATH/oh-my-zsh-custom-plugins/ccat ~/.oh-my-zsh/custom/plugins/ccat
rm -fr ~/.oh-my-zsh/custom/plugins/mac-utils
ln -s $SCRIPTPATH/oh-my-zsh-custom-plugins/mac-utils ~/.oh-my-zsh/custom/plugins/mac-utils

