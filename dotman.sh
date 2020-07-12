#!/usr/bin/env bash

# (.dot)file (man)ager

# Disable debug mode
set +x

IFS=$'\n'

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
catch_ctrl+c() {
    goodbye
    exit
}

trap 'catch_ctrl+c' SIGINT

repo_check(){
	# check if dotfile repo is present inside DOT_DEST

	DOT_REPO_NAME=$(basename "${DOT_REPO}")
	if [[ -d ${HOME}/${DOT_DEST}/${DOT_REPO_NAME} ]]; then
	    echo -e "\nFound $(tput bold)${DOT_REPO_NAME}$(tput sgr0) as a dotfile repo in $(tput bold)${DOT_DEST}/$(tput sgr0)"
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

add_env() {
	# export environment variables
	echo -e "\nExporting env variables DOT_DEST & DOT_REPO ..."

	current_shell=$(basename "$SHELL")
	if [[ $current_shell == "zsh" ]]; then
		echo "export DOT_REPO=$1" >> "$HOME"/.zshrc
		echo "export DOT_DEST=$2" >> "$HOME"/.zshrc
	else
		# assume we have a fallback to bash
		echo "export DOT_REPO=$1" >> "$HOME"/.bashrc
		echo "export DOT_DEST=$2" >> "$HOME"/.bashrc
	fi
	echo -e "Configuration for SHELL: $(tput bold)$current_shell$(tput sgr0) has been updated."
}

goodbye() {
	printf "\a\n\n%s\n" "$(tput bold)Thanks for using d○tman 🖖.$(tput sgr0)"
	printf "\n%s%s" "$(tput bold)Follow $(tput setab 45)$(tput setaf 0)@bhupeshimself$(tput sgr0)" "$(tput bold) on Twitter "
	printf "%s\n" "for more updates.$(tput sgr0)"
	printf "%s\n" "$(tput bold)Report Bugs : $(tput smul)https://github.com/Bhupesh-V/dotman/issues$(tput rmul)$(tput sgr0)"
}

# WIP
dot_pull() {
	# pull changes (if any) from the host repo
	echo -e "\n$(tput bold)Pulling dotfiles ...$(tput sgr0)"
	dot_repo="${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")"
	echo -e "\nPulling changes in $dot_repo\n"
	git -C "$dot_repo" pull origin master
}

# WIP
diff_check() {

	if [[ -z $1 ]]; then
		echo -e "Declaring array...."
		declare -ag file_arr
	fi

	# dotfiles in repository
	readarray -t dotfiles_repo < <( find "${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")" -maxdepth 1 -name ".*" -type f )

	# check length here ?
	for (( i=0; i<"${#dotfiles_repo[@]}"; i++))
	do
		# the version of dotfile available in HOME dir
		home_version=$(basename "${dotfiles_repo[$i]}")
		diff=$(diff -u --suppress-common-lines --color=always "${HOME}/${home_version}" "${dotfiles_repo[$i]}")
		if [[ $diff != "" && $1 == "show" ]]; then
			printf "\n\n%s" "Running diff between $(tput bold) $(tput setaf 214)${dotfiles_repo[$i]}$(tput sgr0) and "
			printf "%s\n" "$(tput bold)$(tput setaf 214)${HOME}/${home_version}$(tput sgr0)"
			printf "%s\n\n" "$diff"
		fi
		file_arr+=("${home_version}")
	done
	if [[ ${#file_arr} == 0 ]]; then
		echo -e "\n\n$(tput bold)No Changes in dotfiles.$(tput sgr0)"
	fi
}

show_diff_check() {
	diff_check "show"
}

# WIP
dot_push() {
	diff_check
	echo -e "$(tput bold)Following dotfiles changed$(tput sgr0)"
	for file in "${file_arr[@]}"; do
		echo "$file"
		cp "${HOME}/$file" "${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")"
	done

	# Run Git Add
	git add -A
	
	echo -e "$(tput bold)Enter Commit Message (Ctrl + d to save): $(tput sgr0)"
	commit=$(</dev/stdin)
	# echo -e "\n\n$commit"
	git commit -m "$commit"
	
	# Run Git Push
	git push
}

initial_setup() {
	echo -e "\n\nFirst time use 🔥, Set Up $(tput bold)d○tman$(tput sgr0)"
	echo -e "....................................\n"
	read -p "⚪ Enter dotfiles repository URL : " -r DOT_REPO

	# isValidURL=$(curl -IsS --silent -o /dev/null -w '%{http_code}' "${DOT_REPO}")
	read -p "⚪ Where should I clone $(tput bold)$(basename "${DOT_REPO}")$(tput sgr0) (${HOME}/..): " -r DOT_DEST
	DOT_DEST=${DOT_DEST:-$HOME}
	if [[ -d "$HOME/$DOT_DEST" ]]; then
		printf "\n%s\r\n" "$(tput bold)Calling 📞 Git ... $(tput sgr0)"
		# clone the repo in the destination directory
		if git -C "${HOME}/${DOT_DEST}" clone "${DOT_REPO}"; then
			add_env "$DOT_REPO" "$DOT_DEST"
			echo -e "\n[✔️ ] dotman successfully configured"
			goodbye
		else
			# invalid arguments to exit, Repository Not Found
			echo -e "\n[❌] $DOT_REPO Unavailable. Exiting"
			exit 1
		fi
	else
		echo -e "\n[❌]$(tput bold)$DOT_DEST$(tput sgr0) Not a Valid directory"
		exit 1
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
			[1]* ) show_diff_check;;
			[2]* ) echo -e "\n Pushing dotfiles ..."
				   dot_push;;
			[3]* ) dot_pull;;
			[4]* ) find_dotfiles;;
			[q/Q]* ) goodbye 
					 exit;;
			* )     printf "\n%s\n" "[❌]Invalid Input 🙄, Try Again";;
		esac
	done
}

intro() {
	echo -e "\n\aHi $(tput bold)$(tput setaf 208)$BOSS_NAME$(tput sgr0) 👋"
	printf "%s" "$(tput bold)$(tput setaf 122)${DOTMAN_LOGO}$(tput sgr0)"	
}

init_check() {
	# Check wether its a first time use or not
	if [[ -z ${DOT_REPO} && -z ${DOT_DEST} ]]; then
	    # show first time setup menu
		initial_setup
	else
		repo_check
	    manage
	fi
}


intro
init_check
