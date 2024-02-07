############## EXPORTS ##############

eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_NO_AUTO_UPDATE=1
# export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced

############## END EXPORTS ##############

############## OPTIONS ##############

setopt HIST_SAVE_NO_DUPS
autoload -U compinit
setopt PROMPT_SUBST
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

############## END OPTIONS ##############

############## ALIAS ##############

# alias ls='ls -G'

############## END ALIAS ##############

############## FUNCTIONS ##############

precmd() {
    print ""
}

parse_git_branch(){
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ ! -z "${branch}" ]]; then
        echo "%F{132}[%f%F{$(parse_git_status)}${branch}%f%F{132}]%f "
    else
        echo ""
    fi
}

parse_git_status(){
    STATUS=$(git status 2> /dev/null)

    if [[ $? -ne 0 ]]; then
        echo "000"
    elif [[ $(echo ${STATUS} | grep -c "clean") -eq 1 ]]; then
        echo "113"
    else
        echo "178"
    fi
}

get_base_pwd(){
    basename $(pwd)
}

############## END FUNCTIONS ##############

PROMPT='%B%F{074}$(get_base_pwd)%b $(parse_git_branch)%B%F{074}->%b%f %{$reset_color%}'
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=074,underline'
ZSH_HIGHLIGHT_STYLES[command]='fg=130,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=130,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=130,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=130,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=174,bold'
ZSH_HIGHLIGHT_STYLES[default]='fg=183'

source ${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh