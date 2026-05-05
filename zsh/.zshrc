# --- Instant prompt (Powerlevel10k) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- PATH and environment ---
export PATH="$HOME/scripts:$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"

# --- Go environment ---
export GOPROXY=direct
export GOSUMDB=off

# --- Oh-My-Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    archlinux
)

source $ZSH/oh-my-zsh.sh

# --- Powerlevel10k config ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- External plugins (after Oh-My-Zsh) ---
if [[ -f $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# --- Aliases ---
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias vim='nvim'

# --- FZF key bindings ---
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_ignore_dups
setopt share_history

# --- Autocorrect ---
setopt correct
setopt correct_all

# --- Yazi helper ---
function y() {
    local tmpfile tmpdir
    tmpfile=$(mktemp)
    yazi --cwd-file="$tmpfile" "$@"
    if [[ -f "$tmpfile" ]]; then
        tmpdir=$(<"$tmpfile")
        rm -f "$tmpfile"
        [[ -d "$tmpdir" ]] && cd "$tmpdir"
    fi
}

# --- Pyenv ---
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init - zsh)"
fi
