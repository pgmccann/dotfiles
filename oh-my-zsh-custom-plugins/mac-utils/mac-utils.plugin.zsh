export EDITOR=nvim
alias python='python3'
alias ssid='m wifi status | grep "^ \+SSID" | sed -n -e "s/^.*SSID: *//p"'
alias ss='m screensaver'
alias ll='m lock'
alias zz='m lock && m sleep'
alias now='date "+%a %_d %b %Y %T %Z" | figlet | lolcat'
alias status='m info && m hostname && m network ls && m battery status && m wifi status'
alias batt='m battery status'
alias 6music='gst-play-1.0 http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p'
alias scratch='nvim +Scratch +"set syntax=markdown"'
alias cat='bat'
export BAT_PAGER='less'
alias ls="lsd"
alias ping='prettyping --nolegend'
alias du="dust"
alias df="duf --theme dark"
function pdiff () {
	diff -u $1 $2 | diff-so-fancy
}
alias ghis="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
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
alias vimwiki='source ~/.zshrc && cd ~/vimwiki && nvim -c "let g:auto_save = 1 | normal \ww"'
alias pylint='python $(which pylint)'
alias btm='if [[ $TERMCS == "light"  ]]; then btm --color=default-light; else btm; fi'
alias vim='nvim'

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
    # echo "Running conda update"
    # conda update --all -y
    echo "Running npm update"
    npm update -g
    echo "Running gem update"
    gem update
    echo "Updating Vim plugins"
    nvim +PlugUpdate +PlugUpgrade +qall
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

LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R '
if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
    export TERMCS="dark"
    export BAT_THEME="Solarized (dark)"
else
    export TERMCS="light"
    export BAT_THEME="Solarized (light)"
fi
