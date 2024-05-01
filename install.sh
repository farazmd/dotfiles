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

DOWNLOAD_PATH="${XDG_CONFIG_HOME}/.dotfiles" &&

	# git clone
	git clone git@github.com:farazmd/dotfiles.git "${DOWNLOAD_PATH}" &&
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
	echo "Install successfull"

echo -e "\nDotfiles has been downloaded to ${DOWNLOAD_PATH}\n"
echo -e "All files have been symlinked to the below locations:"
echo -e "NVIM: ${NVIM_INSTALL_PATH}"
echo -e "TMUX: ${TMUX_INSTALL_PATH}"
echo -e "STARSHIP: ${STARSHIP_INSTALL_APTH}"
