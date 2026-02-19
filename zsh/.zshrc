# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnosterzak"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
fastfetch

# fastfetch. Will be disabled if above colorscript was chosen to install
#fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias discord='nohup flatpak run com.discordapp.Discord &'
alias macos='echo "connect to macos \nip addr 192.168.1.153 port 2223"; kitten ssh -i ~/.ssh/macos -p 2223 cuc@77.239.106.193'
alias asus='echo "connect to asus \nip addr 192.168.1.73 port 2222"; kitten ssh -i ~/.ssh/asus -p 2222 cuc@77.239.106.193'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

function y() {
  local tmpfile=$(mktemp)
  yazi --cwd-file="$tmpfile" "$@"
  if [[ -f "$tmpfile" ]]; then
    local last_dir=$(<"$tmpfile")
    rm -f "$tmpfile"
    if [[ -d "$last_dir" ]]; then
      cd "$last_dir"
    fi
  fi
}

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init - bash)"
fi
export PATH=/home/cuc/.local/bin:$PATH

export GOPROXY=direct
export GOSUMDB=off

