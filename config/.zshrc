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

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux

# Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Load completion
autoload -Uz compinit && compinit

zinit cdreplay -q

# Autocd
setopt autocd

# VIM is my default editor
export VISUAL=vim
export EDITOR=vim

# Correct terminal
export TERM=xterm-256color

# Directories
export XDG_CONFIG_HOME="$HOME/.config" # Config home
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_DOWNLOADS_DIR="$HOME/Downloads"

# Configuration file locations
export dotfiles="$HOME/dotfiles"
export zshrc="$HOME/.zshrc"
export zshal="$HOME/.zsh_aliases"
export gitconf="$HOME/.gitconfig"

# Easy access/edit config files
alias zshrc="$VISUAL $zshrc"
alias zshal="$VISUAL $zshal"
alias zhist="$VISUAL ~/.zsh_history"
alias loadzsh="source $zshrc"
alias gitconf="$VISUAL $gitconf"
alias dotfiles="cd $dotfiles"

# Aliases
alias ls="ls --color"
alias ll="ls -tlh"         # Organize by date modified
alias l.="ls -d .*"         # Only hidden directory
alias ld="ls -Ud */"        # Only directories
alias la="ls -a"            # Everything including hidden files
alias p3="python3"          # Shortcut python3 bin
alias hist="history"        # Shortcut history
alias gd="git diff"         # Quick diff
alias gs="git status"       # Quick status
alias gl="git log"          # Quick log
alias tmn="tmux new -s"     # tmux new session
alias tma="tmux a -t"       # tmux attach to session

# Machine specific config
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

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

# Exports
export PATH="$HOME/.local/bin:$PATH"
export PATH="$dotfiles/scripts:$PATH"

# FZF config
export FZF_CTRL_T_OPTS="
  --style full
  --walker-skip .git,node_modules,target
  --preview 'fzf-preview.sh {}'
  --bind 'focus:transform-header:file --brief {}'"
export FZF_ALT_C_OPTS="
  --style full
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
export FZF_CTRL_R_OPTS="
  --reverse
"

export FZF_DEFAULT_OPTS="--margin 1 --padding 1 --border"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

# if [[ $- == *i* ]]; then; fastfetch; fi # Run fastfetch in interactive terminals
if [ -f ~/.config/fastfetch/random.sh ]; then ~/.config/fastfetch/random.sh; fi # Pick a random preset pokemon
# pokeget random --hide-name | fastfetch --file-raw - # Use pokeget
