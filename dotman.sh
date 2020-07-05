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

# function called by trap
catch_ctrlc() {
    goodbye
    exit
}

trap 'catch_ctrlc' SIGINT
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
	echo -e "\n\nFirst time startup 🔥, Set Up $(tput bold)d○tman$(tput sgr0)"
	echo -e "....................................\n"
	read -p "⚪ Enter dotfiles repository URL : " -r DOT_REPO
	printf "\n%s%s" "$(tput bold)Checking URL ..." "$(tput sgr0)"
	
	isValidURL=$(curl -IsS --silent -o /dev/null -w '%{http_code}' "${DOT_REPO}")
	if [[ $isValidURL == 200 ]]
	then
		printf "\r"
		read -p "⚪ Where should I clone $(tput bold)$(basename "${DOT_REPO}")$(tput sgr0) : " -r DOT_DEST
		if [[ -d $DOT_DEST ]]
		then
			# clone the repo in the directory entered
			printf "\n%s""$(tput bold)Calling 📞 Git ... $(tput sgr0)"
			#git clone "${DOT_REPO} ${DOT_DEST}"
			echo -e "\nExporting env variables..."
			echo -e "\n[✔️ ] dotman successfully configured "
			goodbye
		else
			echo -e "\n[❌] $DOT_DEST Not a Valid directory"
		fi
		exit
	else
		echo -e "\n[❌] $DOT_REPO Unavailable. Try Again"
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
	echo -e "\n[1] Show diff"
	#  diff -u --suppress-common-lines --color file1.sh file2.sh
	echo -e "[2] Push dotfiles to VCS Host"
	echo -e "[3] Pull latest changes from VCS Host"
	echo -e "[4] List all dotfiles"
	# Default choice is [1]
	read -p "What do you want me to do ? [1]: " -n 1 -r USER_INPUT
	# See Parameter Expansion
	USER_INPUT=${USER_INPUT:-1}
	case $USER_INPUT in
		[1]* ) echo -e "\ndiff"
		     return;;
		[2]* ) echo -e "\n Pushing dotfiles ..."
		     return;;
		[3]* ) echo -e "\n Pulling dotfiles ..."
		     return;;
		[4]* ) printf "\n"
			   find_dotfiles 
			 return;;
		* )     printf "\n${RB_YELLOW}${BOLD}Invalid Input 🙄, Exiting d○tman${RESET}\n";;
	esac
}

goodbye() {
	printf "\n\n%s" "$(tput bold)Thanks for using d○tman.$(tput sgr0)"
	printf "\n%s%s" "$(tput bold)Follow $(tput setab 45)$(tput setaf 0)@bhupeshimself$(tput sgr0)" "$(tput bold) on Twitter "
	printf "for more updates.$(tput sgr0)\n"
}

echo -e "\n\aHi $(tput bold)$(tput setaf 208)$BOSS_NAME$(tput sgr0) 👋"
printf "%s" "$(tput bold)$(tput setaf 122)${DOTMAN_LOGO}$(tput sgr0)"


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