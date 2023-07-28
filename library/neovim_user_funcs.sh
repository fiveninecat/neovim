#!/bin/bash

# These functions are designed to be run without sudo.
# For the color variables to work, the script that sources this file must also source the file which defines the color variables.

# Configure Neovim.
configure_neovim () {

    # Save the destination directory to a variable.
    NEOVIM_CF_DIR="/home/$USER/.config/nvim/lua/satellite"

    # Create the destination directory if necessary.
    if [ ! -d $NEOVIM_CF_DIR ]; then
        echo "Creating directory $NEOVIM_CF_DIR."
        mkdir -p $NEOVIM_CF_DIR
        [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"
    fi

    # If $NEOVIM_CF_DIR is empty, copy the configuration files to teh destination directory, and create the primary init.lua file.
    if [ ! -f /home/$USER/.config/nvim/init.lua ]; then

        # Copy everything from the source directory, or the first argument in the function call, to the destination directory.
        echo "Copying files from directory $1 to directory $NEOVIM_CF_DIR."
        cp $1/* $NEOVIM_CF_DIR/
        [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"

        # Create primary init.lua file.
        echo "Creating primary init.lua file."
        echo "require(\"satellite\")" > /home/$USER/.config/nvim/init.lua
        [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"

    # If $NEOVIM_CF_DIR is not empty, ask the user if they would like to replace the existing files, and save the response to a variable.
    else

        local response
        read -p "It looks like Neovim has already been configured. Do you want to replace the existing configuration files? (y/N) " response

        # Convert the user's response to lowercase.
        response=$(echo $response | tr '[:upper:]' '[:lower:]')

        # If there is no response, do not replace the existing files.
        if [ -z $response ]; then
echo -e "${YELLOW}Ok, skipping this step.${ENDCOLOR}\n"

        # If the response is "y", or "yes", replace the existing files.
        elif [ $response = "y" ] || [ $response = "yes" ]; then

            # Copy everything from the source directory, or the first argument in the function call, to the destination directory.
            echo "Copying files from directory $1 to directory $NEOVIM_CF_DIR."
            cp $1/* $NEOVIM_CF_DIR/
            [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"

            # Create primary init.lua file.
            echo "Creating primary init.lua file."
            echo "require(\"satellite\")" > ~/.config/nvim/init.lua
            [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"

        # If the response is anything other than "y", "yes", or NULL, do not replace the existing files.
        else

            echo -e "${YELLOW}Ok, skipping this step.${ENDCOLOR}\n"

        fi

    fi

    return

}

# Configure Packer plugin manager for Neovim.
# See https://github.com/wbthomason/packer.nvim for more info.
configure_packer_neovim () {

    # Ask the user if they want to clone resources from the packer.nim GitHub respository, and save the response to a variable.
    local response
    read -p "Do you want to clone https://github.com/wbthomason/packer.nvim to configure Packer plugin manager for Neovim? (y/N) " response

    # Convert the user's response to lowercase.
    response=$(echo $response | tr '[:upper:]' '[:lower:]')

    # If there is no response, do not clone the resources.
    if [ -z $response ]; then
        echo -e "\n${YELLOW}Ok, skipping this step.${ENDCOLOR}"

    # If the response is "y" or "yes", clone the resources.
    elif [ $response = "y" ] || [ $response = "yes" ]; then

        # Save the "clone to" location to a variable.
        PACKER_DIR="/home/$USER/.local/share/nvim/site/pack/packer/start/packer.nvim"

        # If $PACKER_DIR doesn't exist, clone resources from the packer.nvim GitHub respository with $PACKER_DIR as the destination.
        # If $PACKER_DIR does exist, print a message.
        if [ ! -d $PACKER_DIR ]; then
            echo "Cloning resources from the packer.nvim GitHub respository..."
            git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_DIR
            [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"
        else
            echo -e "${GRAY}Directory $PACKER_DIR already exists.${ENDCOLOR}\n"
        fi

        # Set up, or update, the packer.nvim configuration and close Neovim once all operations are completed.
        echo "Updating packer.nvim configuration with PackerSync..."
        nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
        echo -e "\n"
        [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"

    # If the response is anything other than "y", "yes", or NULL, do not clone the resources.
    else

        echo -e "\n${YELLOW}Ok, skipping this step.${ENDCOLOR}"

    fi

    return

}

# Configure Neovim plugins.
configure_plugins_neovim () {

    # Ask the user if they want to copy the configuration files for Neovim plugins, and save the response to a local variable.
    local response
    read -p "Copy configuration files for Neovim plugins? This is only recommended if Packer has already been configured. (y/N) " response

    # Convert the response to lowercase.
    response=$(echo $response | tr '[:upper:]' '[:lower:]')

    # If there is no response, do not copy the files.
    if [ -z $response ]; then

        echo -e "${YELLOW}Ok, skipping this step.${ENDCOLOR}\n"

    # If the response is "y" or "yes", copy the files.
    elif [ $response = "y" ] || [ $response = "yes" ]; then

        # Save the destination directory to a variable.
        NEOVIM_PL_DIR="/home/$USER/.config/nvim/after/plugin"

        # Create the destination directory if necessary.
        if [ ! -d $NEOVIM_PL_DIR ]; then
            echo "Creating directory $NEOVIM_PL_DIR."
            mkdir -p $NEOVIM_PL_DIR
            [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"
        fi

        # Copy everything from the source directory, or the first argument in the function call, to the destination directory.
        echo -e "${MAGENTA}Ok, copying files from directory $1 to directory $NEOVIM_PL_DIR.${ENDCOLOR}"
        cp $1/* $NEOVIM_PL_DIR/
        [ "$?" -eq 0 ] && echo -e "${GREEN}Success!${ENDCOLOR}\n" || echo -e "${RED}Something went wrong.${ENDCOLOR}\n"

    # If the response is anything other than "y", "yes", or NULL, do not copy the files.
    else
        echo -e "${YELLOW}Ok, skipping this step.${ENDCOLOR}\n"
    fi

    return

}

# Print a simple message.
simple_message () {
    echo -e "\n${CYAN}${1}${ENDCOLOR}\n"
    return
}
