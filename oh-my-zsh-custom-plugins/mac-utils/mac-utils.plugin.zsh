export EDITOR=vim
alias ssid='m wifi status | grep "^ \+SSID" | sed -n -e "s/^.*SSID: *//p"'
alias ss='m lock' #used to be screensaver
alias zz='m lock && m sleep'
alias ll='m lock'
alias now='date "+%a %_d %b %Y %T %Z" | figlet | lolcat'
alias status='m info && m hostname && m network ls && m battery status && m wifi status'
alias batt='m battery status'
alias 6music='gst-play-1.0 http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p'
alias scratch='vim +Scratch +"set syntax=markdown"'
alias cat='bat'
export BAT_PAGER='less'
alias ls="exa"
alias ping='prettyping --nolegend'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
function pdiff () {
	diff -u $1 $2 | diff-so-fancy
}
alias gh="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias vpnstatus='vpn status | grep -c Connected'
alias vc='vpn connect https://vpn.st-andrews.ac.uk/duo'
alias vd='vpn disconnect'
# alias docker='open --background -a Docker && while ! docker system info > /dev/null 2>&1; do sleep 1; done && docker'
alias docker-compose='open --background -a Docker && while ! docker system info > /dev/null 2>&1; do sleep 1; done && docker -v && docker-compose'
prompt_vpn() {
  if [ "$(vpnstatus)" -gt "0" ]; then
    prompt_segment black default ""
  fi
}
alias ql='qlmanage -p'
alias vimwiki='cd ~/vimwiki && vim -c "let g:auto_save = 1 | normal \ww"'

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
	brew upgrade --greedy
	brew cleanup --prune-prefix
	echo "Updating Oh My Zsh"
    $ZSH/tools/upgrade.sh
    echo "Running conda update"
    conda update --all -y
    echo "Running npm update"
    npm update -g
    echo "Running gem update"
    gem update
    echo "Updating Vim plugins"
    cd ~/.vim && git pull --recurse-submodules && cd -
    export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins/tpm
    echo "Updating TMUX plugins"
    ~/.tmux/plugins/tpm/bin/update_plugins all
    echo "Mac software updates"
	m update install all
	echo "Updating from Mac App Store"
	mas upgrade
	echo "Updating Microsoft Office"
    /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate -i
	sudo -k
}

# Enabling cdr as per https://github.com/willghatch/zsh-cdr
if [[ -z "$ZSH_CDR_DIR" ]]; then
    ZSH_CDR_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/zsh-cdr
fi
mkdir -p $ZSH_CDR_DIR
autoload -Uz chpwd_recent_dirs cdr
autoload -U add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-file $ZSH_CDR_DIR/recent-dirs
zstyle ':chpwd:*' recent-dirs-max 1000
# fall through to cd
zstyle ':chpwd:*' recent-dirs-default yes
eval $(thefuck --alias)
