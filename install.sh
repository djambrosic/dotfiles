#!/bin/bash

CONFIG_DIR=config

source "./src/menu.sh"

echo "Hi, if you are running this for the first time update your system and make sure to install base packages"

menu

read -p "Setup config files?(y/n)" ANSWER
if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    if [ -f $HOME/.zshrc ]; then
        rm $HOME/.zshrc
    fi

    stow -D */
    stow terminator
    stow ulauncher
    stow vim
    stow zsh
fi

read -p "We are done. Do you want to reboot system?(y/n)" ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    echo "System will reboot in 5 seconds..."
    for i in {5..1}
    do
        echo -ne "$i "
        sleep 1
    done

    reboot
fi

