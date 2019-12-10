alias ssid='m wifi status | grep "^ \+SSID" | sed -n -e "s/^.*SSID: *//p"'
alias ss='m lock' #used to be screensaver
alias zz='m lock && m sleep'
alias ll='m lock'
alias now='date | figlet | lolcat'
alias status='m info && m hostname && m network ls && m battery status && m wifi status'
alias batt='m battery status'
alias 6music='gst-play-1.0 http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p'
alias scratch='vim +Scratch +"set syntax=markdown"'
alias diff='diff-so-fancy'
alias cat='bat'
export BAT_PAGER='less'
alias ls="exa"

if command -v most > /dev/null 2>&1; then
    export PAGER="most"
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

function update() {
	# Ask for the administrator password upfront.
	sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished.
###	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
	echo "Updating Homebrew"
	brew update
	brew upgrade
	brew cask upgrade
	brew cleanup --prune-prefix
	echo "Updating Oh My Zsh"
	upgrade_oh_my_zsh
    echo "Running conda update"
    conda update --all -y
    echo "Updating Vim plugins"
    cd ~/.vim && git pull --recurse-submodules && cd -
    export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins/tpm
    echo "Updating TMUX plugins"
    ~/.tmux/plugins/tpm/bin/update_plugins all
	echo "Updating Microsoft Office"
    /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate -i
	echo "Updating from Mac App Store"
	m update install all
	mas upgrade
	sudo -k
}

