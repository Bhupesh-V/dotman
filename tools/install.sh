#!/bin/env sh

# Script for installing dotman
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bhupesh-V/dotman/master/tools/install.sh)"
# or wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/Bhupesh-V/dotman/master/tools/install.sh)"
# or httpie:
#   sh -c "$(http --download https://raw.githubusercontent.com/Bhupesh-v/dotman/master/tools/install.sh)"
# 
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/Bhupesh-V/dotman/master/tools/install.sh
#   sh install.sh
#
# Respects the following environment variables:
#   DOTMAN  - path to the dotman repository folder (default: $HOME/dotman)
#   REPO    - name of the GitHub repo to install from (default: Bhupesh-V/dotman)
#   BRANCH  - the branch of upstream dotman repo.
#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)


DOTMAN=${DOTMAN:-$HOME/dotman}
REPO=${REPO:-Bhupesh-V/dotman}
BRANCH=${BRANCH:-master}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}


status_checks() {
	if [ -d "$DOTMAN" ]; then
		printf "\n\t%s\n" "You already have ${BOLD}d○tman${RESET} 🖖 installed."
		printf "\n\t%s\n\n" "You'll need to remove '$DOTMAN' if you want to reinstall."
		exit 0
	fi

	if ! command -v git 2>&1 /dev/null; then
		printf "\n%s\n" "${BOLD}Can't work without Git 😞${RESET}"
		exit 1
	else
		# Clone repository to /home/username/dotman
		# git clone $REMOTE --branch $BRANCH --single-branch $HOME
		all_releases=$(git ls-remote --ref -t --sort='-v:refname' "$REMOTE" | head -n 1)
		# ##*/ retains the part after last /
		git -C "$HOME" clone -b "${all_releases##*/}" --branch "$BRANCH" --single-branch --depth 1 "$REMOTE"
		if [ -d "$DOTMAN" ]; then
			echo "${BOLD}[✔️ ] Successfully cloned d○tman${RESET}"
		fi
	fi
}

set_alias(){
	if [ -f "$HOME"/.bash_aliases ]; then
		echo "alias dotman='$HOME/dotman/dotman.sh'" >> "$HOME"/.bash_aliases
	elif [ "$(basename "SHELL")" = "zsh" ]; then
		echo "alias dotman='$HOME/dotman/dotman.sh'" >> "$HOME"/.zshrc
	elif [ "$(basename "SHELL")" = "bash" ]; then
		echo "alias dotman='$HOME/dotman/dotman.sh'" >> "$HOME"/.bashrc
	else
		echo "Couldn't set alias to dotman: ${BOLD}$HOME/dotman/dotman.sh${RESET}"
		echo "Consider adding it manually".
		exit 1
	fi
	echo "${BOLD}[✔️ ] Set alias for d○tman${RESET}"
}

main () {

	status_checks
	set_alias

	cat <<-'EOF'

	      _       _                         
	     | |     | |                        
	   __| | ___ | |_ _ __ ___   __ _ _ __  
	  / _` |/ _ \| __| '_ ` _ \ / _` | '_ \ 
	 | (_| | (_) | |_| | | | | | (_| | | | |
	  \__,_|\___/ \__|_| |_| |_|\__,_|_| |_|
	                                         .... is now installed


	Run `dotman version` to check latest version.
	Run `dotman` to configure first time setup.

	EOF
}

# check if tput exists
if ! command -v tput /dev/null 2>&1
then
    # tput could not be found :(
    BOLD=""
	RESET=""
else
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
fi

main