#!/bin/bash

source "./src/base_packages.sh"
source "./src/vimplug.sh"
source "./src/docker.sh"
source "./src/nala.sh"
source "./src/ulauncher.sh"
source "./src/zsh.sh"
source "./src/flatpak.sh"
source "./src/flatpak_applications.sh"
source "./src/ssh_permissions.sh"

COLUMNS=15

choices=(
    "Install base packages"
    "Install VimPlug"
    "Install Docker" 
    "Install Zsh" 
    "Install Nala packger manager" 
    "Install Ulauncher" 
    "Install Flatpak"
    "Install Flatpak applications"
    "Setup SSH permissions"
)

flatpak_applications=(
    "Install Discord"
    "Install Filezilla"
    "Install Postman"
)

flatpak_applications_menu () {
    while true; do
        select app in "${flatpak_applications[@]}" "Return"; do
            case "$REPLY" in
                1) install_discord; break;;
                2) install_filezilla; break;;
                3) install_postman; break;;
                $((${#flatpak_applications[@]}+1))) echo "Return to main menu"; break 2;;
                *) echo "Wrong option, try again";;
            esac
        done
    done
}

menu () {
    while true; do
        select choice in "${choices[@]}" "Exit"; do
            case "$REPLY" in
                1) install_base_packages; break;;
                2) install_vim_plug; break;;
                3) install_docker; break;;
                4) install_zsh; break;;
                5) install_nala; break;;
                6) install_ulauncher; break;;
                7) install_flatpak; break;;
                8) flatpak_applications_menu; break;;
                9) setup_permissions; break;;
                $((${#choices[@]}+1))) echo "Exiting menu..."; break 2;;
                *) echo "Wrong option, try again";;
            esac
        done
    done
}
