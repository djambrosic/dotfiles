#!/bin/bash

install_base_packages () {
    echo "Installing base packages"
    
    sudo apt update
    sudo apt install terminator vim ansible neofetch curl htop stow
}