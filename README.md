# shell-configs
Shell configurations / setups

## Setup

- Clone project to a specific location
- Move ```.${SHELL}env``` to ```${HOME}/```
- Link ```project/$SHELL``` to ```${HOME}/.config/${SHELL}```
    ```shell
        ln -s /path/to/project/${SHELL} ${HOME}/.config/${SHELL}
    ```
    - For bash
        ```shell
            ln -s /path/to/project/bash.bashrc ${HOME}/.bashrc
        ```
- source ${HOME}/.${SHELL}env
- source ${HOME}/.config/${SHELL}/${SHELL}rc

- Using [stow](https://www.gnu.org/software/stow/manual/stow.html)

## Dependencies

- Nerd Fonts

- ```shell
        brew tap homebrew/cask-fonts
        brew install --cask font-hack-nerd-font
    ```
