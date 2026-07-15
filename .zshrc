# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # Changed from 'quiet' to 'verbose' to allow P10k to detect and fix issues
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# --- User configuration ---

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- Initializations below this line are now silenced to stop prompt jumping ---

# Load NVM (Silenced)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" > /dev/null
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" > /dev/null

# Load Cargo (Silenced)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" > /dev/null

# Aliases and Environment Variables
alias lg=lazygit
export PATH="$HOME/.local/bin:$PATH"

TIME_STAMP() {
  date +%Y-%m-%d_%H-%M-%S
}

tmx() {
    local session_name="${1:-main}"

    # If the 'work' session already exists, just attach to it cleanly.
    if command tmux has-session -t "$session_name" 2>/dev/null; then
        command tmux attach-session -t "$session_name"
    else
        # If it doesn't exist, spin it up with your exact 4-window layout natively
        command tmux new-session -s "$session_name" -n nv \; \
            new-window -n term \; \
            new-window -n zsh \; \
            new-window -n zsh \; \
            select-window -t 1
    fi
}
