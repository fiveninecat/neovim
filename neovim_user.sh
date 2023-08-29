#!/bin/bash

# This script is designed to be run without sudo.
# Please run all scripts in the "fedora" repository before running this script.

# Import color variables.
source library/colors.sh

# Import the local functions library.
source library/neovim_user_funcs.sh

# Check if the current user is the superuser, and if so, exit.
check_user

# Ask if the user has already installed dependencies, and save response.
read -p "Have you installed gcc, gcc-c++, git, and neovim? (y/N) " sys_res

# Convert reponse to lowercase.
sys_res=$(echo $sys_res | tr '[:upper:]' '[:lower:]')

# If there is no response, exit with a message that gets sent to standard output and standard error.
if [ -z "$sys_res" ]; then
    echo -e "\n${YELLOW}Please install gcc, git, and neovim first.${ENDCOLOR}\n" >&2
    exit 1
fi

# If the response is anything other than "y" or "yes", exit with a message that gets sent to standard output and standard error.
if [ "$sys_res" != "y" -a "$sys_res" != "yes" ]; then
    echo -e "\n${YELLOW}Please install gcc, git, and neovim first.${ENDCOLOR}\n" >&2
    exit 1
fi

# CONFIGURE NEOVIM.

simple_message "CONFIGURING NEOVIM..."

# Configure Neovim.
configure_neovim "./files/neovim/init"

# CONFIGURE PACKER PLUGIN MANAGER FOR NEOVIM.

simple_message "CONFIGURING PACKER PLUGIN MANAGER FOR NEOVIM..."

# Configure packer.nvim plugin manager.
configure_packer_neovim

# CONFIGURE NEOVIM PLUGINS.

simple_message "CONFIGURING NEOVIM PLUGINS..."

# Copy configuration files for Neovim plugins.
configure_plugins_neovim "./files/neovim/plugin"

simple_message "DONE."
