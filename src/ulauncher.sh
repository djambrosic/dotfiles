#!/bin/bash

install_ulauncher () {
    echo "Installing Ulauncher"

    sudo add-apt-repository ppa:agornostal/ulauncher
    sudo apt update && sudo apt install ulauncher
}
