export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Specifically for g14
asus-status() {
  echo "$(tput setaf 9)Current CPU Power Profile$(tput sgr0): $(asusctl profile -p | awk 'NR==2')"
  echo "$(tput setaf 9)Avaliable CPU Power Profiles$(tput sgr0): [LowPower, Balanced, Performance]"
  printf "$(tput setaf 9)Set CPU With$(tput sgr0): asusctl profile -P <profile>\n\n"
  
  echo "$(tput setaf 9)Current GPU Status$(tput sgr0): $(supergfxctl -S)"
  echo "$(tput setaf 9)Current GPU Power Profile$(tput sgr0): $(supergfxctl -g)"
  echo "$(tput setaf 9)Avaliable GPU Power Profiles$(tput sgr0): [Integrated, Hybrid, AsusMuxDgpu]"
  echo "$(tput setaf 9)Set GPU With$(tput sgr0): supergfxctl -m <profile>"
}

# Make neovim my default editor
export VISUAL=nvim
export EDITOR=nvim

# Old habits die hard
alias vim=nvim
alias hypr=hyprland

# Python venv
alias venvs="python3 -m venv .venv"
alias venvl="source .venv/bin/activate"

# Suspend
alias suspend="hyprlock && systemctl suspend"

