#!/usr/bin/env bash

install_brew () {
    if brew ls --versions $1 > /dev/null; then
        echo "$1 already installed"
    else
        brew install $@
    fi
}

install_cask () {
    if brew cask ls --versions $1 > /dev/null; then
        echo "$1 already installed"
    else
        brew cask install $@
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

    install_brew ack
    install_brew ansible
    install_brew ascii_doc
    install_brew cask
    install_brew coreutils
    install_brew ctags
    install_brew moreutils
    install_brew findutils
    install_brew gnu-sed --with-default-names
    install_brew bash
    install_brew bash-completion
    install_brew wget --with-iri
    install_brew vim --override-system-vi
    install_brew grep
    install_brew screen
    install_brew git
    install_brew git-lfs
    install_brew imagemagick --with-webpi
    install_brew tree
    install_brew curl
    install_brew darksky-weather
    install_brew findutils
    install_brew figlet
    install_brew gist
    install_brew git-extras
    install_brew hub
    install_brew jq
    install_brew jump
    install_brew lastpass-cli
    install_brew lolcat
    install_brew m-cli
    install_brew make
    install_brew mas
    install_brew moreutils
    install_brew nano
    install_brew pandoc
    install_brew python3
    install_brew sqlparse
    install_brew the_silver_searcher
    install_brew tmux
    install_brew zsh
    install_brew zsh-autosuggestions
    install_brew zsh-completions
    install_brew zsh-git-prompt
    install_brew zsh-syntax-highlighting

    install_cask iterm2
    install_cask adobe-acrobat-reader
    install_cask aerial
    install_cask anaconda
    install_cask android-studio
    install_cask atom
    install_cask docker
    install_cask drafts
    install_cask firefox
    install_cask flash-player
    install_cask font-fira-code
    install_cask github
    install_cask google-chrome
    install_cask hazel
    install_cask icloud-control
    install_cask libreoffice
    install_cask mactex
    install_cask openrefine
    install_cask send-to-kindle
    install_cask sourcetree
    install_cask textexpander
    install_cask virtualbox
    install_cask vlc
    install_cask whatsapp
    install_cask microsoft-teams

    brew cleanup

    mas install 497799835 #Xcode
    mas install 467939042 #Growl
    mas install 1179623856 #Pastebot
    mas install 881415018 #myTuner Radio
    mas install 441258766 #Magnet
    mas install 485812721 #Tweetdeck
    mas install 1055511498 #Day One
    mas install 803453959 #Slack
    mas install 407963104 #Pixelmator
    mas install 937984704 #Amphetamine
    mas install 926036361 #LastPass
    mas install 1333542190 #1Password
    mas install 823766827 #OneDrive

fi

pip install Pygments

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

$SCRIPTPATH/linuxify/linuxify install

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

rm -fr ~/.oh-my-zsh/custom/plugins/ccat
ln -s $SCRIPTPATH/oh-my-zsh-custom-plugins/ccat ~/.oh-my-zsh/custom/plugins/ccat
rm -fr ~/.oh-my-zsh/custom/plugins/mac-utils
ln -s $SCRIPTPATH/oh-my-zsh-custom-plugins/mac-utils ~/.oh-my-zsh/custom/plugins/mac-utils

