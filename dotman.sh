#!/usr/bin/env bash

# (.dot)file (man)ager

IFS=$'\n'

set +x

VERSION="v0.1.0"
DOTMAN_LOGO=$(cat << "LOGO"

      _       _                         
     | |     | |                        
   __| | ___ | |_ _ __ ___   __ _ _ __  
  / _` |/ _ \| __| '_ ` _ \ / _` | '_ \ 
 | (_| | (_) | |_| | | | | | (_| | | | |
  \__,_|\___/ \__|_| |_| |_|\__,_|_| |_|
                                        

LOGO
)

# check if tput exists
if ! command -v tput &> /dev/null
then
    # tput could not be found
    BOLD=""
	RESET=""
	FG_SKYBLUE=""
	FG_ORANGE=""
else
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
	FG_SKYBLUE=$(tput setaf 122)
	FG_ORANGE=$(tput setaf 208)
	BG_AQUA=$(tput setab 45)
	FG_BLACK=$(tput setaf 16)
	FG_ORANGE=$(tput setaf 214)
	UL=$(tput smul)
	RUL=$(tput rmul)
fi

# check if git exists
if ! command -v git &> /dev/null
then
	printf "%s\n\n" "${BOLD}${FG_SKYBLUE}${DOTMAN_LOGO}${RESET}"
	echo -e "Can't work without Git 😞"
	exit 1
fi

# function called by trap
catch_ctrl+c() {
    goodbye
    exit
}

trap 'catch_ctrl+c' SIGINT

repo_check(){
	# check if dotfile repo is present inside DOT_DEST

	DOT_REPO_NAME=$(basename "${DOT_REPO}")
	# all paths are relative to HOME
	if [[ -d ${HOME}/${DOT_DEST}/${DOT_REPO_NAME} ]]; then
	    echo -e "\nFound ${BOLD}${DOT_REPO_NAME}${RESET} as a dotfile repo in ${BOLD}${HOME}/${DOT_DEST}/${RESET}"
	else
	    echo -e "\n\n[❌] ${BOLD}${DOT_REPO_NAME}${RESET} not present inside path ${BOLD}${HOME}/${DOT_DEST}${RESET}"
		read -p "Should I clone it ? [Y/n]: " -n 1 -r USER_INPUT
		USER_INPUT=${USER_INPUT:-y}
		case $USER_INPUT in
			[y/Y]* ) clone_dotrepo "$DOT_DEST" "$DOT_REPO" ;;
			[n/N]* ) echo -e "${BOLD}${DOT_REPO_NAME}${RESET} not found";;
			* )     printf "\n%s\n" "[❌] Invalid Input 🙄, Try Again";;
		esac
	fi
}

find_dotfiles() {
	printf "\n"
	# while read -r value; do
	#     dotfiles+=($value)
	# done < <( find "${HOME}" -maxdepth 1 -name ".*" -type f )
	readarray -t dotfiles < <( find "${HOME}" -maxdepth 1 -name ".*" -type f )
	printf '%s\n' "${dotfiles[@]}"
}

add_env() {
	# export environment variables
	echo -e "\nExporting env variables DOT_DEST & DOT_REPO ..."

	current_shell=$(basename "$SHELL")
	if [[ $current_shell == "zsh" ]]; then
		echo "export DOT_REPO=$1" >> "$HOME"/.zshrc
		echo "export DOT_DEST=$2" >> "$HOME"/.zshrc
	elif [[ $current_shell == "bash" ]]; then
		# assume we have a fallback to bash
		echo "export DOT_REPO=$1" >> "$HOME"/.bashrc
		echo "export DOT_DEST=$2" >> "$HOME"/.bashrc
	else
		echo "Couldn't export ${BOLD}DOT_REPO=$1${RESET} and ${BOLD}DOT_DEST=$2${RESET}"
		echo "Consider exporting them manually".
		exit 1
	fi
	echo -e "Configuration for SHELL: ${BOLD}$current_shell${RESET} has been updated."
}

goodbye() {
	printf "\a\n\n%s\n" "${BOLD}Thanks for using d○tman 🖖.${RESET}"
	printf "\n%s%s" "${BOLD}Follow ${BG_AQUA}${FG_BLACK}@bhupeshimself${RESET}" "${BOLD} on Twitter "
	printf "%s\n" "for more updates.${RESET}"
	printf "%s\n" "${BOLD}Report Bugs : ${UL}https://github.com/Bhupesh-V/dotman/issues${RUL}${RESET}"
}

dot_pull() {
	# pull changes (if any) from the host repo
	echo -e "\n${BOLD}Pulling dotfiles ...${RESET}"
	dot_repo="${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")"
	echo -e "\nPulling changes in $dot_repo\n"
	git -C "$dot_repo" pull origin master
}

diff_check() {

	if [[ -z $1 ]]; then
		local file_arr
	fi

	# dotfiles in repository
	readarray -t dotfiles_repo < <( find "${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")" -maxdepth 1 -name ".*" -type f )

	# check length here ?
	for i in "${!dotfiles_repo[@]}"
	do
		dotfile_name=$(basename "${dotfiles_repo[$i]}")
		# compare the HOME version of dotfile to that of repo
		diff=$(diff -u --suppress-common-lines --color=always "${dotfiles_repo[$i]}" "${HOME}/${dotfile_name}")
		if [[ $diff != "" ]]; then
			if [[ $1 == "show" ]]; then
				printf "\n\n%s" "Running diff between ${BOLD} ${FG_ORANGE}${HOME}/${dotfile_name}${RESET} and "
				printf "%s\n" "${BOLD}${FG_ORANGE}${dotfiles_repo[$i]}${RESET}"
				printf "%s\n\n" "$diff"
			fi
			file_arr+=("${dotfile_name}")
		fi
	done
	if [[ ${#file_arr} == 0 ]]; then
		echo -e "\n\n${BOLD}No Changes in dotfiles.${RESET}"
		return
	fi
}

show_diff_check() {
	diff_check "show"
}

dot_push() {
	diff_check
	if [[ ${#file_arr} != 0 ]]; then
		echo -e "\n${BOLD}Following dotfiles changed${RESET}"
		for file in "${file_arr[@]}"; do
			echo "$file"
			cp "${HOME}/$file" "${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")"
		done

		dot_repo="${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")"
		git -C "$dot_repo" add -A

		echo -e "${BOLD}Enter Commit Message (Ctrl + d to save): ${RESET}"
		commit=$(</dev/stdin)
		# echo -e "\n\n$commit"
		git -C "$dot_repo" commit -m "$commit"

		# Run Git Push
		git -C "$dot_repo" push
	else
		echo -e "\n\n${BOLD}No Changes in dotfiles.${RESET}"
		return
	fi
}

clone_dotrepo (){
	# clone the repo in the destination directory
	DOT_DEST=$1
	DOT_REPO=$2
	
	if git -C "${HOME}/${DOT_DEST}" clone "${DOT_REPO}"; then
		if [[ -z ${DOT_REPO} && -z ${DOT_DEST} ]]; then
			add_env "$DOT_REPO" "$DOT_DEST"
		fi
		echo -e "\n[✔️ ] dotman successfully configured"
	else
		# invalid arguments to exit, Repository Not Found
		echo -e "\n[❌] $DOT_REPO Unavailable. Exiting"
		exit 1
	fi
}

initial_setup() {
	echo -e "\n\nFirst time use 🔥, Set Up ${BOLD}d○tman${RESET}"
	echo -e "....................................\n"
	read -p "➤ Enter dotfiles repository URL : " -r DOT_REPO

	# isValidURL=$(curl -IsS --silent -o /dev/null -w '%{http_code}' "${DOT_REPO}")
	read -p "➤ Where should I clone ${BOLD}$(basename "${DOT_REPO}")${RESET} (${HOME}/..): " -r DOT_DEST
	DOT_DEST=${DOT_DEST:-$HOME}
	if [[ -d "$HOME/$DOT_DEST" ]]; then
		printf "\n%s\r\n" "${BOLD}Calling 📞 Git ... ${RESET}"
		clone_dotrepo "$DOT_DEST" "DOT_REPO"
	else
		echo -e "\n[❌]${BOLD}$DOT_DEST${RESET} Not a Valid directory"
		exit 1
	fi
}

manage() {
	while :
	do
		echo -e "\n[1] Show diff"
		echo -e "[2] Push changed dotfiles to remote"
		echo -e "[3] Pull latest changes from remote"
		echo -e "[4] List all dotfiles"
		echo -e "[q/Q] Quit Session"
		# Default choice is [1]
		read -p "What do you want me to do ? [1]: " -n 1 -r USER_INPUT
		# See Parameter Expansion
		USER_INPUT=${USER_INPUT:-1}
		case $USER_INPUT in
			[1]* ) show_diff_check;;
			[2]* ) dot_push;;
			[3]* ) dot_pull;;
			[4]* ) find_dotfiles;;
			[q/Q]* ) goodbye 
					 exit;;
			* )     printf "\n%s\n" "[❌]Invalid Input 🙄, Try Again";;
		esac
	done
}

intro() {
	BOSS_NAME=$LOGNAME
	echo -e "\n\aHi ${BOLD}${FG_ORANGE}$BOSS_NAME${RESET} 👋"
	printf "%s" "${BOLD}${FG_SKYBLUE}${DOTMAN_LOGO}${RESET}"	
}

init_check() {
	# Check wether its a first time use or not
	if [[ -z ${DOT_REPO} && -z ${DOT_DEST} ]]; then
	    # show first time setup menu
		initial_setup
		goodbye
	else
		repo_check
	    manage
	fi
}


if [[ $1 == "version" || $1 == "--version" || $1 == "-v" ]]; then
	if [[ -d "$HOME/dotman" ]]; then
		latest_tag=$(git -C "$HOME/dotman" describe --tags --abbrev=0)
		latest_tag_push=$(git -C "$HOME/dotman" log -1 --format=%ai "${latest_tag}")
		echo -e "${BOLD}dotman ${latest_tag} ${RESET}"
		echo -e "Released on: ${BOLD}${latest_tag_push}${RESET}"
	else
		echo -e "${BOLD}dotman ${VERSION}${RESET}"
	fi
	exit
fi

intro
init_check
