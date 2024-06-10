############## XDG ##############

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"


############## ZSH ##############
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=12000
export SAVEHIST=10000