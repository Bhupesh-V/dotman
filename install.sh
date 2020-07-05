#!/bin/bash

# Script for installing dotman

# Clone repository to /home/username/.dotman
installation_dir="home/${USERNAME}/.dotman"
git clone https://github.com/Bhupesh-V/dotman "${installation_dir}"

# Set Alias
alias dotman="dotman.sh"
