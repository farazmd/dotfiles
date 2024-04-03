######################## Functions ############################

parse_git_branch(){
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ ! -z "${branch}" ]]; then
        # printf "%s" '\[\e[01;38;5;132m\][\[\e[01;38;5;'$(parse_git_status)'m\]'${branch}'\[\e[01;38;5;132m\]\] '
        echo -e "\e[01;38;5;132m[\e[01;38;5;$(parse_git_status)m${branch}\e[01;38;5;132m] "
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

######################### Functions ##########################

######################### Prompt #############################

# prompt_reset=$(tput sgr0)
# bash_highlight=$(tput setaf 058)

# PROMPT_COMMAND='PS1="\[\e[01;38;5;074m\]\$(get_base_pwd) \$(parse_git_branch)\[\e[01;38;5;074m\](bash) > "'

# PS1="\[\e[01;38;5;074m\]\$(get_base_pwd) \$(parse_git_branch)\[\e[01;38;5;074m\]\[${bash_highlight}\](bash) \[\e[01;38;5;074m\]>\[$prompt_reset\] " 

# Switching to starship (https://starship.rs)

eval "$(starship init bash)"

########################## Prompt #############################

########################## Config #############################

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

########################## Config #############################