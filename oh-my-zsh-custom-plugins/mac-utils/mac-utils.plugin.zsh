alias ssid='m wifi status | grep "^ \+SSID" | sed -n -e "s/^.*SSID: *//p"'
alias ss='m screensaver'
alias zz='m sleep'
alias now='date | figlet | lolcat'

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
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
	echo "Updating Homebrew"
	brew update
	brew upgrade
	brew cask upgrade
	brew prune
	brew cleanup
	echo "Updating Oh My Zsh"
	upgrade_oh_my_zsh
	echo "Updating Ruby Gems"
	gem update
	gem cleanup
	echo "Updating Python Libraries"
	pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
	pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
	echo "Updating R Packages"
	Rscript -e 'r = getOption("repos"); r ["CRAN"] = "https://cran.rstudio.com/"; options(repos = r); update.packages(ask = FALSE)'
	echo "Updating Atom packages"
	apm upgrade --no-confirm
	echo "Updating Node"
	npm i npm
	npm i -g npm
	npm update
	npm update -g
	echo "Running Google Software Update"
	/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/CheckForUpdatesNow.command
	echo "Launching Microsoft AutoUpdate"
	open -a /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app
	echo "Updating from Mac App Store"
	m update install all
	mas upgrade
	sudo -k
}

