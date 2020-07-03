#!/bin/bash

# (.dot)file (man)ager

# Depedencies
	# 1. Bash >= 4
	# 2. Git
	# 3. curl

IFS=$'\n'
# set these 2 as env variables
DOT_DIR=""
DOT_REPO="https://github.com/Bhupesh-V/.Varshney.git"

DOT_REPO_NAME=$(basename ${DOT_REPO})

echo "dotfiles folder path: ${HOME}/${DOT_DIR}"

init(){
	if [ -d "${HOME}/${DOT_DIR}/${DOT_REPO_NAME}" ]
	then
	    echo -e "Found ${DOT_REPO_NAME} as a dotfile repo"
	else
	    echo -e "${DOT_REPO_NAME} not present inside path ${HOME}/${DOT_DIR}\n
	    Consider Changing current working directory"
	fi
}

find_dotfiles() {
	mapfile -t dotfiles < <( find . -maxdepth 1 -name ".*" -type f )
	printf '%s\n' "${dotfiles[@]}"
}

setup_config() {
	echo -e "\n\nSet Up d○tman"
	echo -e "............."
	read -p "⚪ Enter dotfiles repository URL : " -r DOT_REPO
	echo -e "\n Checking URL ..."
	isValidURL=$(curl -IsS --silent -o /dev/null -w '%{http_code}' ${DOT_REPO})

	if [[ $isValidURL == 200 ]]
	then
		return
	else
		echo -e "\n(❌) $DOT_REPO Unavailable"
		exit
	fi
	check if DOT_REPO is URL
	read -p "⚪ Where should I clone $(basename "${DOT_REPO}"), Enter Directory Name : " -r DOT_DIR
}

config_check() {
	# check if env variables are set
	if [[ -z "${DOT_DIR}" ]] && [[ -z "${DOT_REPO}" ]] 
	then
	    return
	else
		read -p "Want to setup dotman configs ? (y/N) " -n 1 -r REPLY
	    case $REPLY in
	     [yY]* ) setup_config
	             return;;
	     [nN]* ) return;;
	     * )     echo -e "\nInvalid Input, Exiting d○tman 🙄";;
	  esac
	fi
}

config_check
find_dotfiles
# TODO
# {1} : If repo is present see if there is a difference between files inside the repo.
# {2} : Copy changed files to the repo.
# {3} : run git and ask user to push.
# {4} : Find all dot files
# {5} : Set dotman as alias to the script