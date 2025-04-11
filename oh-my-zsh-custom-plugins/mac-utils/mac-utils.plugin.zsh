export EDITOR=nvim

alias python='python3'

if command -v m > /dev/null 2>&1; then
    alias ssid='m wifi status | grep "^ \+SSID" | sed -n -e "s/^.*SSID: *//p"'
    alias ss='m screensaver'
    alias ll='m lock'
    alias zz='m lock && m sleep'
fi

if command -v figlet > /dev/null 2>&1 && command -v lolcat > /dev/null 2>&1; then
    alias now='date "+%a %_d %b %Y %T %Z" | figlet | lolcat'
fi

if command -v nvim > /dev/null 2>&1; then
    alias vim='nvim'
fi
alias vim='nvim'
alias scratch='vim +Scratch +"set syntax=markdown"'
alias vimwiki='cd ~/vimwiki && vim -c "let g:auto_save = 1 | exe \":Copilot disable\" | normal \ww"'

if command -v bat > /dev/null 2>&1; then
    alias cat='bat'
    export BAT_PAGER='moar'
fi

if command -v lsd > /dev/null 2>&1; then
    alias ls='lsd'
fi

if command -v prettyping > /dev/null 2>&1; then
    alias ping='prettyping --nolegend'
fi

if command -v dust > /dev/null 2>&1; then
    alias du='dust'
fi

if command -v duf > /dev/null 2>&1; then
    alias df='duf'
fi

if command -v diff-so-fancy > /dev/null 2>&1; then
    function pdiff () {
        diff -u $1 $2 | diff-so-fancy
    }
fi

alias ghis="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

if command -v /opt/cisco/secureclient/bin/vpn > /dev/null 2>&1; then
    alias vpnstatus='/opt/cisco/secureclient/bin/vpn status | grep -c Connected'
    alias vc='/opt/cisco/secureclient/bin/vpn connect https://vpn.st-andrews.ac.uk/duo'
    alias vd='/opt/cisco/secureclient/bin/vpn disconnect'
    prompt_vpn() {
      if [ "$(vpnstatus)" -gt "0" ]; then
        prompt_segment black default ""
      fi
    }
fi

if command -v pylint > /dev/null 2>&1; then
    alias pylint='python $(which pylint)'
fi

if command -v btm > /dev/null 2>&1; then
    alias btm='if [[ $TERMCS == "light"  ]]; then btm --color=default-light; else btm; fi'
fi

alias swcsplit='~/Sites/carpentries/swc-shell-split-window/swc-shell-split-window.sh'

if command -v moar > /dev/null 2>&1; then
    export PAGER="moar"
fi

if command -v glab > /dev/null 2>&1; then
    alias check_mirror="glab api projects/:id/mirror/pull | jq . | grep last_successful | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}[^\"]*'"
    alias mirror='glab api -X POST projects/:id/mirror/pull'
    alias ci_trace='glab ci trace'
fi

if command -v gron > /dev/null 2>&1; then
    alias ungron="gron --ungron"
    alias norg=ungron
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

function spacer() {
    echo ""
    echo "================================================================================"
    echo $1
    echo "================================================================================"
}

function update() {
	# Ask for the administrator password upfront.
	sudo -v
    spacer "============================== Updating Homebrew ==============================="
	brew update
	brew upgrade --greedy
	brew cleanup --prune-prefix
    spacer "============================== Updating Oh My Zsh =============================="
    $ZSH/tools/upgrade.sh
    spacer "============================== Running npm update =============================="
    npm update -g
    spacer "============================== Running gem update =============================="
    gem update
    gem cleanup
    spacer "============================= Updating vim plugins ============================="
    nvim +PlugUpdate +PlugUpgrade +qall
    spacer "============================ Updating TMUX plugins ============================="
    ~/.tmux/plugins/tpm/bin/update_plugins all
    spacer "============================= Mac software updates ============================="
	m update install all
    spacer "========================= Updating from Mac App Store =========================="
	mas upgrade
    spacer "========================== Updating Microsoft Office ==========================="
    /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate -i
	sudo -k
}
alias up=update

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

DISABLE_UPDATE_PROMPT=true

eval "$(jump shell)"
export PATH="/usr/local/opt/ncurses/bin:$PATH"

export DEFAULT_USER=`whoami`

autoload zmv
autoload zcalc

export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="${HOME}/Library/Android/sdk/platform-tools:$PATH"
export PATH="${HOME}/Library/Android/sdk/tools/bin:$PATH"
export PATH="${HOME}/Library/Android/sdk/emulator:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$(brew --prefix sqlite)/bin:$PATH"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$PATH:/opt/cisco/anyconnect/bin"
export PATH="$PATH:${HOME}/.cargo/bin"

RPS1="%*"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/zsh-git-prompt/zshrc.sh
fpath=(/opt/homebrew/share/zsh-completions $fpath)
eval "$(rbenv init -)"
export PATH="/usr/local/opt/openssl/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source /Users/pgm5/.config/broot/launcher/bash/br
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
eval "$(zoxide init zsh)"
PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
# source <(ng completion script)

export PATH="/opt/homebrew/opt/tomcat@9/bin:$PATH"

# Created by `pipx` on 2024-06-03 13:29:29
export PATH="$PATH:/Users/pgm5/.local/bin"
eval "$(atuin init zsh --disable-up-arrow)"
export DYLD_INSERT_LIBRARIES="/Users/pgm5/Sites/stderred/build/libstderred.dylib${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES}"
