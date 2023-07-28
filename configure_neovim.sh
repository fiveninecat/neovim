#!/bin/bash

# this script is designed to be run without sudo
# please run system.sh and user.sh before running this script

# import color variables and local functions library
source library/colors.sh
source library/neovim_user_funcs.sh

# exit if the user running the script is superuser or root
if [ "$(id -u)" -eq 0 ]; then
    echo -e "${RED}Please run without sudo.${ENDCOLOR}" >&2
    exit 1
fi

# ask if the user has already run the system.sh and user.sh scripts and save response
read -p "Have you already installed gcc, git, and neovim? (y/N) " sys_res

# convert reponse to lowercase
sys_res=$(echo $sys_res | tr '[:upper:]' '[:lower:]')

# if there is no response, assume "no" and exit with a message that gets sent to standard output and standard error
if [ -z "$sys_res" ]; then
    echo -e "\n${YELLOW}Please install gcc, git, and neovim first.${ENDCOLOR}\n" >&2
    exit 1
fi

# if the response is anything other than "y" or "yes", assume "no" and exit with a message that gets sent to standard output and standard error
if [ "$sys_res" != "y" -a "$sys_res" != "yes" ]; then
    echo -e "\n${YELLOW}Please install gcc, git, and neovim first.${ENDCOLOR}\n" >&2
    exit 1
fi

# create a variable which stores the path to the home directory for the current user
USER_HOME="/home/$USER"

# create a variable which stores the path to the ~/.config directory for the current user
USER_CONFIG="/home/$USER/.config"

# CONFIGURE NEOVIM

simple_message "CONFIGURING NEOVIM..."

# Configure Neovim.
configure_neovim "./files/neovim/init"

# CONFIGURE PACKER PLUGIN MANAGER FOR NEOVIM

simple_message "CONFIGURING PACKER PLUGIN MANAGER FOR NEOVIM..."

# Configure packer.nvim plugin manager.
configure_packer_neovim

# CONFIGURE NEOVIM PLUGINS

simple_message "CONFIGURING NEOVIM PLUGINS..."

# Copy configuration files for Neovim plugins.
configure_plugins_neovim "./files/neovim/plugin"

simple_message "DONE."
