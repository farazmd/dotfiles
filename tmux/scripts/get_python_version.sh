#!/bin/zsh

source ${ZDOTDIR}/.zshrc

(python --version 2>/dev/null || python3 --version 2>/dev/null) | cut -d ' ' -f2