#!/bin/env sh

# Script for installing dotman
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# or wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/Bhupesh-V/master/install.sh
#   sh install.sh
#
# Respects the following environment variables:
#   DOTMAN  - path to the dotman repository folder (default: $HOME/dotman)
#   REPO    - name of the GitHub repo to install from (default: Bhupesh-V/dotman)
#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)
#   BRANCH  - branch to check out immediately after install (default: master)
#

DOTMAN_DIR=${DOTMAN_DIR:-~/dotman}
REPO=${REPO:-Bhupesh-V/dotman}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}


# Clone repository to /home/username/.dotman
installation_dir="home/${USERNAME}/.dotman"
git clone https://github.com/Bhupesh-V/dotman "${installation_dir}"

# Set Alias
alias dotman="dotman.sh"
