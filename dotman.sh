#!/usr/bin/env bash

# (.dot)file (man)ager

# Disable debug mode
set +x

IFS=$'\n'

# set these 2 as env variables
# DOT_DEST=""
# DOT_REPO="https://github.com/Bhupesh-V/.Varshney.git"

BOSS_NAME=$LOGNAME
# this is called a "here document ? heh?"
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

repo_check(){
	# check if dotfile repo is present

	DOT_REPO_NAME=$(basename "${DOT_REPO}")
	if [ -d "${HOME}/${DOT_DEST}/${DOT_REPO_NAME}" ]
	then
	    echo -e "\nFound $(tput bold)${DOT_REPO_NAME}$(tput sgr0) as a dotfile repo"
	else
	    echo -e "\n\n[❌] $(tput bold)${DOT_REPO_NAME}$(tput sgr0) not present inside path $(tput bold)${HOME}/${DOT_DEST}$(tput sgr0)."
	    echo -e "Change current working directory"
	    exit
	fi
}

find_dotfiles() {
	printf "\n"
	readarray -t dotfiles < <( find "${HOME}" -maxdepth 1 -name ".*" -type f )
	printf '%s\n' "${dotfiles[@]}"
}

initial_setup() {
	echo -e "\n\nFirst time use 🔥, Set Up $(tput bold)d○tman$(tput sgr0)"
	echo -e "....................................\n"
	read -p "⚪ Enter dotfiles repository URL : " -r DOT_REPO
	printf "\n%s%s" "$(tput bold)Checking URL ..." "$(tput sgr0)"
	
	isValidURL=$(curl -IsS --silent -o /dev/null -w '%{http_code}' "${DOT_REPO}")
	if [[ $isValidURL == 200 ]]
	then
		printf "\r"
		read -p "⚪ Where should I clone $(tput bold)$(basename "${DOT_REPO}")$(tput sgr0) (${HOME}/..): " -r DOT_DEST
		DOT_DEST=${DOT_DEST:-$HOME}
		if [[ -d "$HOME/$DOT_DEST" ]]
		then
			printf "\n%s\r\n" "$(tput bold)Calling 📞 Git ... $(tput sgr0)"
			# clone the repo in the directory entered
			git -C "${HOME}/${DOT_DEST}" clone "${DOT_REPO}"
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

init_check() {
	# Check wether its a first time use or not
	if [[ ! -z ${DOT_REPO} && ! -z ${DOT_DEST} ]]; then
	    # variables exist, show manage menu
	    repo_check
	    manage
	else
		# show First Time setup menu
		initial_setup
	fi
}

manage() {
	while :
	do
		echo -e "\n[1] Show diff"
		echo -e "[2] Push changed dotfiles to VCS Host"
		echo -e "[3] Pull latest changes from VCS Host"
		echo -e "[4] List all dotfiles"
		echo -e "[q/Q] Quit Session"
		# Default choice is [1]
		read -p "What do you want me to do ? [1]: " -n 1 -r USER_INPUT
		# See Parameter Expansion
		USER_INPUT=${USER_INPUT:-1}
		case $USER_INPUT in
			[1]* ) echo -e "\ndiff"
				   diff_check;;
			[2]* ) echo -e "\n Pushing dotfiles ..."
				   dot_push;;
			[3]* ) echo -e "\n Pulling dotfiles ...";;
			[4]* ) find_dotfiles;;
			[q/Q]* ) goodbye 
					 exit;;
			* )     printf "\n%s\n" "[❌]Invalid Input 🙄, Exiting $(tput bold)d○tman$(tput sgr0)";;
		esac
	done
}

goodbye() {
	printf "\a\n\n%s\n" "$(tput bold)Thanks for using d○tman 🖖.$(tput sgr0)"
	printf "\n%s%s" "$(tput bold)Follow $(tput setab 45)$(tput setaf 0)@bhupeshimself$(tput sgr0)" "$(tput bold) on Twitter "
	printf "%s\n" "for more updates.$(tput sgr0)"
	printf "%s\n" "$(tput bold)Report Bugs : $(tput smul)https://github.com/Bhupesh-V/dotman/issues$(tput rmul)$(tput sgr0)"
}

intro() {
	echo -e "\n\aHi $(tput bold)$(tput setaf 208)$BOSS_NAME$(tput sgr0) 👋"
	printf "%s" "$(tput bold)$(tput setaf 122)${DOTMAN_LOGO}$(tput sgr0)"	
}

# WIP
dot_push() {
	# Copy all files to the repo.
	
	# Run Git Add
	# git add -A
	
	echo -e "$(tput bold)Enter Commit Message (Ctrl + d to save): $(tput sgr0)\n"
	commit=$(</dev/stdin)
	echo -e "\n\n$commit"
	# git commit -m "${commit}"
	
	# Run Git Push
	# git push
}

# WIP
diff_check() {
	# dotfiles in repository
	mapfile -t dotfiles_repo < <( find "${HOME}/${DOT_DEST}/${DOT_REPO_NAME}" -maxdepth 1 -name ".*" -type f )
	#dotfiles present inside $HOME
	mapfile -t dotfiles_home < <( find "${HOME}" -maxdepth 1 -name ".*" -type f )

	# check length here ?
	for file in "${dotfiles_repo[@]}"
	do
		if [[ ${dotfiles_home[$file]} == "${dotfiles_repo[$file]}" ]]; then
			diff=$(diff -u --suppress-common-lines --color "${dotfiles_home[$file]}" "${dotfiles_repo[$file]}")
			if [[ $diff != "" ]]; then
				printf "%s" "Running diff between $(tput bold) ${dotfiles_home[$file]} $(tput sgr0) and "
				printf "%s\n" "$(tput bold) ${dotfiles_repo[$file]} $(tput sgr0)"
				echo -e "$diff"
			fi
		fi
	done
}

intro
init_check
# find_dotfiles
# TODO
# {1} ✅: If repo is present see if there is a difference between files inside the repo.
# {2} : Copy changed files to the repo.
# {3} : run git and ask user to push.
# {4} ✅: Find all dot files
# {5} ✅ : Set dotman as alias to the script
# {6} ✅: Pimp up prompts
# {7} : Check for updates in dotman