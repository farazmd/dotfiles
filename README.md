# shell-configs
Shell configurations / setups

## Setup

- Clone project to a specific location
- Move ```.${SHELL}env``` to ```${HOME}/```
- Link ```project/$SHELL``` to ```${HOME}/.config/${SHELL}```
    ```shell
        ln -s /path/to/project/${SHELL} ${HOME}/.config/${SHELL}
    ```
- source ${HOME}/.${SHELL}env
- source ${HOME}/.config/${SHELL}/${SHELL}rc

## Dependencies

- Nerd Fonts

- ```shell
        brew tap homebrew/cask-fonts
        brew install --cask font-hack-nerd-font
    ```
