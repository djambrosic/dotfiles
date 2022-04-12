#/bin/bash

bg_blue='\033[0;44m'
bg_green='\033[0;42m'
clear='\033[0m' 

CONFIG_DIR=config

echo -e "${bg_green}If you run this on fresh install it is recommended to update your system first. Do you want to continue? (Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
    echo -e "${bg_blue}Exited by user!${clear}"
    exit 0
fi

echo -e "${bg_green}Do you want to update your system? (Y/n)?${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    sudo apt update
    sudo apt upgrade
fi

function setupVim()
{
    echo -e "${bg_blue}Do you want to install VimPlug?(Y/n)${clear}"
    read ANSWER

    if [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
        return 0;
    fi

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function installDockerCompose()
{
    ## Docker Compose
    echo -e "${bg_blue}Install Docker Compose?(Y/n)${clear}"
    read ANSWER
    
    if [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
        return 0;
    fi

    echo -e "${bg_blue}Which version do you want to install (e.g. 2.5.0)?${clear}"
    read VERSION

    re="^[0-9]+([.][0-9]+)?([.][0-9]+)?$"
    if ! [[ "$VERSION" =~ $re ]]; then
        echo "Error: Not a number";
        exit 1;
    fi

    if [ -f "/usr/local/bin/docker-compose" ]; then
        sudo rm /usr/local/bin/docker-compose
    fi
    
    sudo curl -SL https://github.com/docker/compose/releases/download/v"$VERSION"/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

function setupDocker()
{
    echo -e "${bg_blue}Install Docker?(Y/n)${clear}"
    read ANSWER
   
    if [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
        #Prompt user to install only Docker Compose
        installDockerCompose

        return 0;
    fi

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io

    sudo usermod -aG docker $USER

    sudo systemctl enable docker.service
    sudo systemctl enable docker.service

    #Install Docker Compose
    installDockerCompose
}

function setupZsh()
{
    echo -e "${bg_blue}Do you want to install OhMyZsh?(Y/n)${clear}"
    read ANSWER

    if [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
        return 0;
    fi

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    echo -e "${bg_blue}Do you want to install PowerLevel10K theme?(Y/n)${clear}"
    read ANSWER

    if [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
        return 0;
    fi

    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    fi

    echo -e "${bg_blue}Do you want to set zsh to your defult shell(Y/n)${clear}"
    read ANSWER

    if [[ "$ANSWER" == "n" || "$ANSWER" == "N" ]]; then
        return 1;
    fi

    chsh -s $(which zsh) $USER
}

function setupUlauncher()
{
    sudo add-apt-repository ppa:agornostal/ulauncher
    sudo apt update && sudo apt install ulauncher
}

function installFlatpak()
{
    sudo apt update
    sudo apt install flatpak

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

function installFlatpakApplications()
{
    echo -e "${bg_green}Do you want to install Postman (Y/n)?${clear}"
    read ANSWER

    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        flatpak install flathub com.getpostman.Postman
    fi

    echo -e "${bg_green}Do you want to install Discord (Y/n)?${clear}"
    read ANSWER

    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        flatpak install flathub com.discordapp.Discord
    fi

    echo -e "${bg_green}Do you want to install FileZilla (Y/n)?${clear}"
    read ANSWER

    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        flatpak install flathub org.filezillaproject.Filezilla 
    fi
}

echo -e "${bg_green}Do you want to install base packages?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    sudo apt install terminator vim zsh ansible neofetch curl htop stow gnome-tweaks
fi

echo -e "${bg_green}Do you want to setup Vim?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    setupVim
fi

echo -e "${bg_green}Start Docker setup?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    setupDocker
fi

echo -e "${bg_green}Start Zsh setup?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    setupZsh
fi

echo -e "${bg_green}Start Ulauncher installer(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    setupUlauncher
fi

echo -e "${bg_green}Do you want to install flatpak and flatpak application(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    installFlatpak
fi

echo -e "${bg_green}Do you want to install flatpak application(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    installFlatpakApplications
fi

echo -e "${bg_green}Setup .dotfiles?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    if [ -f $HOME/.zshrc ]; then
        rm $HOME/.zshrc
    fi

    stow -D */
    stow */
fi

echo -e "${bg_green}Setup permissions on ssh keys?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then

    chmod 700 $HOME/.ssh
    chmod 644 $HOME/.ssh/known_hosts
    chmod 644 $HOME/.ssh/config
    chmod 600 $HOME/.ssh/id_rsa
    chmod 644 $HOME/.ssh/id_rsa.pub
    chmod 600 $HOME/.ssh/id_rsa_prod
    chmod 644 $HOME/.ssh/id_rsa_prod.pub

fi


echo -e "${bg_green}We are done champ. Do you want to reboot system?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    echo "System will reboot in 5 seconds..."
    sleep 5

    reboot
fi

