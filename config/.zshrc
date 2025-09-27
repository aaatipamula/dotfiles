# zinit home directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Bootstrap zinit
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load in powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab # Use fzf for tab completions

# Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Keybindings
bindkey -e  # Emacs keybinds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completion
autoload -Uz compinit && compinit

# Replay cached completions
zinit cdreplay -q

# Autocd
setopt autocd

# VIM is my default editor
export VISUAL=vim
export EDITOR=vim

# Correct terminal
export TERM=xterm-256color

# Configuration file locations
export dotfiles="$HOME/dotfiles"
export zshrc="$HOME/.zshrc"
export zshal="$HOME/.zsh_aliases"

# Easy access/edit config files
alias zshrc="$VISUAL $zshrc"
alias zshal="$VISUAL $zshal"
alias zhist="$VISUAL ~/.zsh_history"
alias loadzsh="source $zshrc"
alias dotfiles="cd $dotfiles"

# Aliases
alias ls="ls --color"
alias ll="ls -tlh"      # Organize by date modified
alias l.="ls -d .*"     # Only hidden directory
alias lD="ls -Ud */"    # Only directories
alias la="ls -a"        # Everything including hidden files
alias p3="python3"      # Shortcut python3 bin
alias hist="history"    # Shortcut history
# alias gd="git diff"   # Quick diff
alias gs="git status"   # Quick status
# alias gl="git log"    # Quick log
alias tmn="tmux new -s" # tmux new session
alias tma="tmux a -t"   # tmux attach to session

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Machine specific config
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

# if [[ $- == *i* ]]; then; fastfetch; fi # Run fastfetch in interactive terminals
if [ -f ~/.config/fastfetch/random.sh ]; then ~/.config/fastfetch/random.sh; fi # Pick a random preset pokemon
# pokeget random --hide-name | fastfetch --file-raw - # Use pokeget
