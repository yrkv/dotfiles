typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/77bsskn86yf6h11mx96xkxm9bqv42kqg-zsh-5.5.1/share/zsh/$ZSH_VERSION/help"

path+="$HOME/.config/zsh/plugins/zsh-history-substring-search"
fpath+="$HOME/.config/zsh/plugins/zsh-history-substring-search"
path+="$HOME/.config/zsh/plugins/zsh-syntax-highlighting"
fpath+="$HOME/.config/zsh/plugins/zsh-syntax-highlighting"


autoload -U compinit && compinit
source /nix/store/l1v64hv67r788gjw5sd827vgrxc5fhyh-zsh-autosuggestions-0.4.2/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Environment variables
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"




if [ -f "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh" ]; then
  source "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"
fi
if [ -f "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" ]; then
  source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
fi


# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/rycee/home-manager/issues/177.
HISTSIZE="10000"
HISTFILE="$HOME/.config/zsh/.zsh_history"
SAVEHIST="10000"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

setopt correct extendedglob nocaseglob nobeep autocd

# Case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Automatically find new executables in path
zstyle ':completion:*' rehash true

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


# Keybinds section
bindkey 'OA' history-beginning-search-backward
bindkey 'OB' history-beginning-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word
bindkey '^_' history-incremental-search-backward
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

autoload -U promptinit && promptinit && prompt walters

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m' # this one
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

WORDCHARS=${WORDCHARS//\/[&.;]}

source zsh-history-substring-search.zsh


# Aliases
alias l='ls -alh'
alias ll='ls -l'
alias ls='ls --color=tty'
