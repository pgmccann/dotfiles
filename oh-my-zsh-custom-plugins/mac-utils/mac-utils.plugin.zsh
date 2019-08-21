alias ssid='m wifi status | grep "^ \+SSID" | sed -n -e "s/^.*SSID: *//p"'
alias ss='m lock' #used to be screensaver
alias zz='m lock && m sleep'
alias ll='m lock'
alias now='date | figlet | lolcat'
alias status='m info && m hostname && m network ls && m battery status && m wifi status'
alias batt='m battery status'
alias 6music='gst-play-1.0 http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p'

function man() {
	CLRD_MAN=$ZSH/plugins/colored-man-pages/colored-man-pages.plugin.zsh
	PGR='less'
	OTHER_OPTS=0
	while getopts ":P:" opt; do
		case $opt in
			P ) PGR=$OPTARG ;;
			? ) OTHER_OPTS=1 ;;
		esac
	done
	if (( OTHER_OPTS == 1 )) then
		. $CLRD_MAN && man $@
	else
		/usr/bin/man -P cat ${@: -1} > /dev/null && (. $CLRD_MAN && man $@) || (${@: -1} --help > /dev/null && ${@: -1} --help | $PGR || echo "No help content found")
	fi
}

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
	echo "Updating Atom packages"
	apm upgrade --no-confirm
    echo "Updating Vim plugins"
    cd ~/.vim && git pull --recurse-submodules && cd -
	echo "Updating Microsoft Office"
    /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate -i
	echo "Updating from Mac App Store"
	m update install all
	mas upgrade
	sudo -k
}

