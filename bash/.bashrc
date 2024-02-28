export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_NO_AUTO_UPDATE=1
export CLICOLOR=1
export LSCOLORS=gxfxBxDxcxegedabagaced
export PYENV_ROOT=${XDG_CONFIG_HOME}/.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

parse_git_branch(){
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ ! -z "${branch}" ]]; then
        echo "\[\e[01;38;5;132m\][\[\e[01;38;5;$(parse_git_status)m\]${branch}\[\e[01;38;5;132m\]] "
    else
        echo ""
    fi
}

parse_git_status(){
    STATUS=$(git status 2> /dev/null)

    if [[ $? -ne 0 ]]; then
        echo "000"
    elif [[ $(echo ${STATUS} | grep -c "clean") -eq 1 ]]; then
        echo "042" # 036 is another option
    else
        echo "178"
    fi
}

get_base_pwd(){
    basename $(pwd)
}

PS1="\[\e[01;38;5;074m\]$(get_base_pwd) $(parse_git_branch)\[\e[01;38;5;074m\] (bash) > "
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
