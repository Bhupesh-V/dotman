#!/bin/env sh

# Script for updating dotman
#
# This script can be run via:
#   dotman update
# or directly:
#   sh ~/dotman/tools/update.sh
#
# Respects the following environment variables:
#   DOTMAN  - path to the dotman repository folder (default: $HOME/dotman)
#   REPO    - name of the GitHub repo (default: Bhupesh-V/dotman)
#   BRANCH  - the main branch of upstream dotman repo (default: master)

DOTMAN=${DOTMAN:-$HOME/dotman}
REPO=${REPO:-Bhupesh-V/dotman}
BRANCH=${BRANCH:-master}
REMOTE="https://github.com/${REPO}.git"

# check if tput exists
if ! command -v tput > /dev/null 2>&1; then
    BOLD=""
    RESET=""
    FG_GREEN=""
    FG_YELLOW=""
else
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
    FG_GREEN=$(tput setaf 2)
    FG_YELLOW=$(tput setaf 3)
fi

check_dotman_dir() {
    if [ ! -d "$DOTMAN" ]; then
        printf "%s\n" "${BOLD}[❌] dotman is not installed at $DOTMAN${RESET}"
        printf "%s\n" "Run the install script first."
        exit 1
    fi
}

check_git() {
    if ! command -v git > /dev/null 2>&1; then
        printf "%s\n" "${BOLD}[❌] Git is required but not installed${RESET}"
        exit 1
    fi
}

get_current_version() {
    if [ -d "$DOTMAN/.git" ]; then
        git -C "$DOTMAN" describe --tags --abbrev=0 2>/dev/null || echo "unknown"
    else
        echo "unknown"
    fi
}

get_latest_version() {
    git ls-remote --refs --tags --sort='-v:refname' "$REMOTE" 2>/dev/null | head -n 1 | sed 's/.*refs\/tags\///'
}

update_dotman() {
    current_version=$(get_current_version)
    latest_version=$(get_latest_version)

    printf "\n%s\n" "${BOLD}Checking for updates...${RESET}"
    printf "%s\n" "Current version: ${FG_YELLOW}${current_version}${RESET}"
    printf "%s\n" "Latest version:  ${FG_GREEN}${latest_version}${RESET}"

    if [ "$current_version" = "$latest_version" ]; then
        printf "\n%s\n" "${BOLD}${FG_GREEN}[✔️ ] dotman is already up to date!${RESET}"
        return 0
    fi

    if [ -z "$latest_version" ]; then
        printf "\n%s\n" "${BOLD}[❌] Could not fetch latest version${RESET}"
        return 1
    fi

    printf "\n%s\n" "${BOLD}Updating dotman...${RESET}"
    
    git -C "$DOTMAN" fetch --tags --force
    
    if git -C "$DOTMAN" checkout "$latest_version" 2>/dev/null; then
        printf "\n%s\n" "${BOLD}${FG_GREEN}[✔️ ] Successfully updated dotman to ${latest_version}${RESET}"
    else
        printf "\n%s\n" "${BOLD}[❌] Failed to update dotman${RESET}"
        return 1
    fi
}

main() {
    check_dotman_dir
    check_git
    update_dotman
}

main
