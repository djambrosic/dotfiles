#!/bin/bash

install_flatpak () {
    sudo apt update
    sudo apt install flatpak

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

