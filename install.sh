#!/usr/bin/env bash

# Install script for dotfiles

# Make required directories
if [ -z "${XDG_CONFIG_HOME}" ]; then
	export XDG_CONFIG_HOME="${HOME}/.config"
	export XDG_DATA_HOME="${XDG_CONFIG_HOME}/local/share"
	export XDG_CACHE_HOME="${XDG_CONFIG_HOME}/cache"
	export XDG_STATE_HOME="${XDG_CONFIG_HOME}/local/state"
fi

if [ ! -d "${XDG_CONFIG_HOME}" ]; then
	mkdir -p "${XDG_CONFIG_HOME}" "${XDG_CACHE_HOME}" "${XDG_DATA_HOME}" "${XDG_STATE_HOME}"
fi

# Flags for dependencies install checks
r_flag=false
f_flag=false

# Install Dependencies
OS_NAME=""
RIPGREP_VERSION=14.1.0
RIPGREP_BIN_TYPE=""
case "${OSTYPE}" in
darwin*)
	OS_NAME="osx"
	if [[ $(uname -m) =~ "arm64" ]] || [[ $(uname -m) =~ "aarch64" ]]; then
		export RIPGREP_BIN_TYPE="aarch64-apple-darwin"
	else
		export RIPGREP_BIN_TYPE="x86_64-apple-darwin"
	fi
	;;
linux-gnu)
	OS_NAME="linux"
	if [[ $(uname -m) =~ "arm64" ]] || [[ $(uname -m) =~ "aarch64" ]]; then
		export RIPGREP_BIN_TYPE="aarch64-unknown-linux-gnu"
	elif [[ $(uname -m) =~ "x86_64" ]]; then
		export RIPGREP_BIN_TYPE="x86_64-unknown-linux-gnu"
	elif [[ $(uname -m) =~ "i386" ]] || [[ $(uname -m) =~ "i686" ]]; then
		export RIPGREP_BIN_TYPE="i686-unknown-linux-gnu"
	fi
	;;
esac

echo "RG bin: ${RIPGREP_BIN_TYPE}"

if [ "${OS_NAME}" == "osx" ]; then
	# Nerd fonts
	brew tap homebrew/cask-fonts &&
		brew install --cask font-hack-nerd-font &&
		brew install --cask font-fira-code-nerd-font

elif [ "${OS_NAME}" == "linux" ]; then
	if [ ! -d ${XDG_DATA_HOME}/fonts ]; then
		mkdir ${XDG_DATA_HOME}/fonts
	fi
	mkdir /tmp/FiraCode &&
		curl -o /tmp/FiraCode/FiraCode.zip -JL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip &&
		unzip /tmp/FiraCode/FiraCode.zip -d /tmp/FiraCode &&
		mv /tmp/FiraCode/*.ttf ${XDG_DATA_HOME}/fonts/ &&
		fc-cache -fv &&
		rm -rf /tmp/FiraCode
fi

# ripgrep
curl -o /tmp/ripgrep-${RIPGREP_VERSION}-${RIPGREP_BIN_TYPE}.tar.gz -JL https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-${RIPGREP_VERSION}-${RIPGREP_BIN_TYPE}.tar.gz &&
	tar xvf /tmp/ripgrep-${RIPGREP_VERSION}-${RIPGREP_BIN_TYPE}.tar.gz -C /tmp/ &&
	sudo mv /tmp/ripgrep-${RIPGREP_VERSION}-${RIPGREP_BIN_TYPE}/rg /usr/local/bin/rg &&
	rm -rf /tmp/ripgrep-${RIPGREP_VERSION}-${RIPGREP_BIN_TYPE} /tmp/ripgrep-${RIPGREP_VERSION}-${RIPGREP_BIN_TYPE}.tar.gz

# Backup all current configs
if [ -f "${HOME}/.bashrc" ]; then
	mv -f "${HOME}/.bashrc" "${HOME}/.bashrc.bak"
fi
if [ -f "${HOME}/.bash_profile" ]; then
	mv -f "${HOME}/.bash_profile" "${HOME}/.bash_profile.bak"
fi
if [ -d "${XDG_CONFIG_HOME}/nvim" ]; then
	mv -f "${XDG_CONFIG_HOME}/nvim" "${XDG_CONFIG_HOME}/nvim.bak"
fi
if [ -d "${XDG_CONFIG_HOME}/starship" ]; then
	mv -f "${XDG_CONFIG_HOME}/starship" "${XDG_CONFIG_HOME}/starship.bak"
fi
if [ -d "${XDG_CONFIG_HOME}/tmux" ]; then
	mv -f "${XDG_CONFIG_HOME}/tmux" "${XDG_CONFIG_HOME}/tmux.bak"
fi

DOTFILES_INSTALLED=1

DOWNLOAD_PATH="${XDG_CONFIG_HOME}/.dotfiles" &&

	# git clone
	git clone -b master https://github.com/farazmd/dotfiles.git "${DOWNLOAD_PATH}" &&
	# Install paths
	DOTFILES_INSTALL_BASE_PATH="${XDG_CONFIG_HOME}" &&
	NVIM_INSTALL_PATH="${DOTFILES_INSTALL_BASE_PATH}/nvim" &&
	TMUX_INSTALL_PATH="${DOTFILES_INSTALL_BASE_PATH}/tmux" &&
	STARSHIP_INSTALL_PATH="${DOTFILES_INSTALL_BASE_PATH}/starship" &&

	# symlink all files to respective folders

	# bash
	ln -sf "${DOWNLOAD_PATH}/bash/.bash_profile" "${HOME}/.bash_profile" &&
	ln -sf "${DOWNLOAD_PATH}/bash/.bashrc" "${HOME}/.bashrc" &&

	# nvim
	ln -sf "${DOWNLOAD_PATH}/nvim" "${NVIM_INSTALL_PATH}" &&

	# startship
	ln -sf "${DOWNLOAD_PATH}/startship" "${STARSHIP_INSTALL_PATH}" &&

	# tmux
	ln -sf "${DOWNLOAD_PATH}/tmux" "${TMUX_INSTALL_PATH}" &&
	echo "Install successfull" &&
	DOTFILES_INSTALLED=0

if [ ${DOTFILES_INSTALLED} -eq 0 ]; then
	echo -e "\nDotfiles has been downloaded to ${DOWNLOAD_PATH}\n"
	echo -e "All files have been symlinked to the below locations:"
	echo -e "NVIM: ${NVIM_INSTALL_PATH}"
	echo -e "TMUX: ${TMUX_INSTALL_PATH}"
	echo -e "STARSHIP: ${STARSHIP_INSTALL_PATH}"
fi
