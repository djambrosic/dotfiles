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

function setupVim()
{
    echo -e "${bg_blue}Do you want to install VimPlug?(Y/n)${clear}"
    read ANSWER

    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}


function setupDocker()
{
    echo -e "${bg_blue}Install Docker?(Y/n)${clear}"
    read ANSWER
    
    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo apt update
        sudo apt install docker-ce docker-ce-cli containerd.io

        sudo usermod -aG docker $USER

        sudo systemctl enable docker.service
        sudo systemctl enable docker.service
    fi

    ## Docker Compose
    echo -e "${bg_blue}Install Docker Compose?(Y/n)${clear}"
    read ANSWER
    
    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    fi
}

function setupZsh()
{
    echo -e "${bg_blue}Do you want to install OhMyZsh?(Y/n)${clear}"
    read ANSWER

    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    echo -e "${bg_blue}Do you want to install PowerLevel10K theme?(Y/n)${clear}"
    read ANSWER

    if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        fi
    fi
}

echo -e "${bg_green}Do you want to install base packages?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    sudo apt install terminator vim zsh ansible neofetch curl htop stow
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

echo -e "${bg_green}Setup .dotfiles?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    stow -D */
    stow */
fi

echo -e "${bg_green}Setup permissions on ssh keys?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    bash scripts/ssh-permission.sh
fi


echo -e "${bg_green}We are done champ. Do you want to reboot system?(Y/n)${clear}"
read ANSWER

if [[ "$ANSWER" == "y" || "$ANSWER" == "Y" ]]; then
    echo "System will reboot in 5 seconds..."
    sleep 5

    reboot
fi

