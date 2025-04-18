#!/usr/bin/env bash

install_brew () {
    if brew ls --versions $1 > /dev/null; then
        echo "$1 already installed"
    else
        brew install "$@"
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

    while read -r leaf; do
        install_brew "$leaf"
    done < ./leaves.txt

    while read -r cask; do
        install_brew "$cask"
    done < ./casks.txt

    brew cleanup
fi

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

rm -f ~/.curlrc
ln -s $SCRIPTPATH/.curlrc ~/.curlrc
rm -f ~/.editorconfig
ln -s $SCRIPTPATH/.editorconfig ~/.editorconfig
rm -f ~/.vimrc
ln -s $SCRIPTPATH/.vimrc ~/.vimrc
rm -f ~/.vim
ln -s $SCRIPTPATH/.vim ~/.vim
rm -f ~/.wgetrc
ln -s $SCRIPTPATH/.wgetrc ~/.wgetrc
rm -f ~/.zshrc
ln -s $SCRIPTPATH/.zshrc ~/.zshrc
rm -f ~/.tmux.conf
ln -s $SCRIPTPATH/.tmux.conf ~/.tmux.conf
rm -f ~/.tmux
ln -s $SCRIPTPATH/.tmux ~/.tmux

rm -fr ~/.oh-my-zsh/custom/plugins/mac-utils
ln -s $SCRIPTPATH/oh-my-zsh-custom-plugins/mac-utils ~/.oh-my-zsh/custom/plugins/mac-utils

