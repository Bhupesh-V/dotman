#!/usr/bin/env bash

# (.dot)file (man)ager

# Disable debug mode
set +x

IFS=$'\n'

# set these 2 as env variables
DOT_DEST=""
DOT_REPO="https://github.com/Bhupesh-V/.Varshney.git"

DOT_REPO_NAME=$(basename ${DOT_REPO})
BOSS_NAME=$LOGNAME
# this is called a "here document"
DOTMAN_LOGO=$(cat << "LOGO"

      _       _                         
     | |     | |                        
   __| | ___ | |_ _ __ ___   __ _ _ __  
  / _` |/ _ \| __| '_ ` _ \ / _` | '_ \ 
 | (_| | (_) | |_| | | | | | (_| | | | |
  \__,_|\___/ \__|_| |_| |_|\__,_|_| |_|
                                        

LOGO
)

if [ -t 1 ]; then
  RB_RED=$(printf '\033[38;5;196m')
  RB_ORANGE=$(printf '\033[38;5;202m')
  RB_YELLOW=$(printf '\033[38;5;226m')
  RB_GREEN=$(printf '\033[38;5;082m')
  RB_BLUE=$(printf '\033[38;5;021m')
  RB_INDIGO=$(printf '\033[38;5;093m')
  RB_VIOLET=$(printf '\033[38;5;163m')

  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[m')
else
  RB_RED=""
  RB_ORANGE=""
  RB_YELLOW=""
  RB_GREEN=""
  RB_BLUE=""
  RB_INDIGO=""
  RB_VIOLET=""

  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  RESET=""
fi

# echo "dotfiles folder path: ${HOME}/${DOT_DEST}"

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

initial_setup() {
	echo -e "\n\nFirst time startup, Set Up d○tman"
	echo -e ".................................\n"
	read -p "⚪ Enter dotfiles repository URL : " -r DOT_REPO
	echo -e "\n Checking URL ..."
	isValidURL=$(curl -IsS --silent -o /dev/null -w '%{http_code}' "${DOT_REPO}")

	if [[ $isValidURL == 200 ]]
	then
		read -p "⚪ Where should I store $(basename "${DOT_REPO}") : " -r DOT_DEST
		# clone the repo in the directory entered
		echo -e "\n Calling 📞 Git ..."
		# git clone "${DOT_REPO} ${DOT_DEST}"
		echo -e "\nExporting env variables..."

		return
	else
		echo -e "\n(❌) $DOT_REPO Unavailable. Try Again"
		exit
	fi
}

config_check() {
	# check if env variables are set
	if [[ -z "${DOT_DEST}" ]] && [[ -z "${DOT_REPO}" ]] 
	then
	    return
	else
		initial_setup
	fi
}

manage() {
	echo -e "[1] Show diff"
	#  diff -u --suppress-common-lines --color file1.sh file2.sh
	echo -e "[2] Push dotfiles to VCS"
	echo -e "[3] Pull latest changes from VCS"
	echo -e "[4] List dotfiles"
	# Default choice is [1]
	read -p "What do you want me to do [1] : " -n 1 -r USER_INPUT
	# See Parameter Expansion
	USER_INPUT=${USER_INPUT:-1}
	case $USER_INPUT in
		[1]* ) echo -e "\ndiff"
		     return;;
		[2]* ) echo -e "\n Pushing dotfiles ..."
		     return;;
		[3]* ) echo -e "\n Pulling dotfiles ..."
		     return;;
		[4]* ) echo -e "\n Listing dotfiles ..." 
			 return;;
		* )     printf "\n${RB_YELLOW}${BOLD}Invalid Input 🙄, Exiting d○tman${RESET}\n";;
	esac
}


#printf "\aHi ${RB_YELLOW}$BOSS_NAME${RESET} 👋"
echo -e "\n\aHi $BOSS_NAME 👋"
printf "${RB_GREEN}${BOLD}${DOTMAN_LOGO}${RESET}\n"

#config_check
manage
# find_dotfiles
# TODO
# {1} : If repo is present see if there is a difference between files inside the repo.
# {2} : Copy changed files to the repo.
# {3} : run git and ask user to push.
# {4} : Find all dot files
# {5} ✅ : Set dotman as alias to the script
# {6} : Pimp up prompts
# {7} : Check for updates in dotman