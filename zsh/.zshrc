# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"
source .oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias vim='nvim'

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
export PATH=/home/cuc/scripts:/home/cuc/.local/bin:$PATH

export GOPROXY=direct
export GOSUMDB=off

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
