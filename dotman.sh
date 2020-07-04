#!/bin/bash

# (.dot)file (man)ager

IFS=$'\n'
# set these 2 as env variables
DOT_DEST=""
DOT_REPO="https://github.com/Bhupesh-V/.Varshney.git"

DOT_REPO_NAME=$(basename ${DOT_REPO})

echo "dotfiles folder path: ${HOME}/${DOT_DEST}"

init(){
	if [ -d "${HOME}/${DOT_DEST}/${DOT_REPO_NAME}" ]
	then
	    echo -e "Found ${DOT_REPO_NAME} as a dotfile repo"
	else
	    echo -e "${DOT_REPO_NAME} not present inside path ${HOME}/${DOT_DEST}.\n
	    Consider changing current working directory"
	fi
}

find_dotfiles() {
	mapfile -t dotfiles < <( find "${HOME}" -maxdepth 1 -name ".*" -type f )
	printf '%s\n' "${dotfiles[@]}"
}

setup_config() {
	cat << "LOGO"

      _       _                         
     | |     | |                        
   __| | ___ | |_ _ __ ___   __ _ _ __  
  / _` |/ _ \| __| '_ ` _ \ / _` | '_ \ 
 | (_| | (_) | |_| | | | | | (_| | | | |
  \__,_|\___/ \__|_| |_| |_|\__,_|_| |_|
                                        

LOGO

	echo -e "\n\nFirst time startup, Set Up d○tman"
	echo -e ".................................\n"
	read -p "⚪ Enter dotfiles repository URL : " -r DOT_REPO
	echo -e "\n Checking URL ..."
	isValidURL=$(curl -IsS --silent -o /dev/null -w '%{http_code}' "${DOT_REPO}")

	if [[ $isValidURL == 200 ]]
	then
		read -p "⚪ Where should I store $(basename "${DOT_REPO}") : " -r DOT_DEST
		# clone the repo in the directory entered
		echo -e "\nCalling 📞 Git ..."
		# git clone "${DOT_REPO} ${DOT_DEST}"
		echo -e "\nExporting env variables..."

		return
	else
		echo -e "\n(❌) $DOT_REPO Unavailable"
		exit
	fi
}

config_check() {
	# check if env variables are set
	if [[ -z "${DOT_DEST}" ]] && [[ -z "${DOT_REPO}" ]] 
	then
	    return
	else
		setup_config
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
# {6} : Pimp up prompts
# {7} : Check for updates in dotman