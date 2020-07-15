#!/bin/env sh

# Script for installing dotman
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-V/dotman/master/tools/install.sh)"
# or wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/Bhupesh-V/dotman/master/tools/install.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/Bhupesh-V/dotman/master/tools/install.sh
#   sh install.sh
#
# Respects the following environment variables:
#   DOTMAN  - path to the dotman repository folder (default: $HOME/dotman)
#   REPO    - name of the GitHub repo to install from (default: Bhupesh-V/dotman)
#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)
#   BRANCH  - branch to check out immediately after install (default: master)


DOTMAN=${DOTMAN:-$HOME/dotman}
REPO=${REPO:-Bhupesh-V/dotman}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}

main () {
	if [ -d "$DOTMAN" ]; then
		cat <<-EOF
			You already have dotman 🖖 installed.
			You'll need to remove '$DOTMAN' if you want to reinstall.
		EOF
		exit 1
	fi

	# Clone repository to /home/username/dotman
	# git -C "$HOME" clone "$REMOTE"

	current_shell=$(basename "$SHELL")
	if [ "$current_shell" = "zsh" ]; then
		echo "export DOTMAN=$HOME/dotman/dotman.sh" >> "$HOME"/.zshrc
	elif [ "$current_shell" = "bash" ]; then
		# assume we have a fallback to bash
		echo "export DOTMAN=$HOME/dotman/dotman.sh" >> "$HOME"/.bashrc
	else
		echo "Couldn't export DOTMAN path $HOME/dotman/dotman.sh"
		echo "Consider exporting it manually".
		exit 1
	fi


	if [ -f "$HOME"/.bash_aliases ]; then
		echo "alias dotman=$HOME/dotman/dotman.sh" >> "$HOME"/.bash_aliases
		# WIP
	fi

	echo "Configuration for SHELL: $(tput bold)$current_shell$(tput sgr0) has been updated."

	cat <<-'EOF'

	      _       _                         
	     | |     | |                        
	   __| | ___ | |_ _ __ ___   __ _ _ __  
	  / _` |/ _ \| __| '_ ` _ \ / _` | '_ \ 
	 | (_| | (_) | |_| | | | | | (_| | | | |
	  \__,_|\___/ \__|_| |_| |_|\__,_|_| |_|
	                                         .... is now installed

	Run `dotman` to configure first time setup.

	EOF
	}

main
