############## EXPORTS ##############

eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1


############## END EXPORTS ##############

############## OPTIONS ##############

setopt HIST_SAVE_NO_DUPS
autoload -U compinit
setopt PROMPT_SUBST
compinit

zstyle ':completion:*' menu select

############## END OPTIONS ##############

############## FUNCTIONS ##############

precmd() {
    print ""
}

parse_git_branch(){
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ ! -z "${branch}" ]]; then
        echo "%K{$(parse_git_status)}%F{007}${branch}%f%k "
    else
        echo ""
    fi
}

parse_git_status(){
    STATUS=$(git status 2> /dev/null)

    if [[ $? -ne 0 ]]; then
        echo "000"
    elif [[ $(echo ${STATUS} | grep -c "clean") -eq 1 ]]; then
        echo "002"
    else
        echo "003"
    fi
}

get_base_pwd(){
    basename $(pwd)
}

############## END FUNCTIONS ##############

PROMPT='%B%F{006}$(get_base_pwd) $(parse_git_branch)%F{006}->%b%f '

source ${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'