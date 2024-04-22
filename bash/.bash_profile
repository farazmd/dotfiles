################### Export ###################

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${XDG_CONFIG_HOME}/local/share"
export XDG_CACHE_HOME="${XDG_CONFIG_HOME}/cache"
export XDG_STATE_HOME="${XDG_CONFIG_HOME}/local/state"

eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_NO_AUTO_UPDATE=1
export CLICOLOR=1
export LSCOLORS=gxfxBxDxcxegedabagaced
export PYENV_ROOT=${XDG_CONFIG_HOME}/.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
export MIND_PALACE="${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents/mind-palace"
#################### Export #####################


#################### Bashrc #####################

if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi
