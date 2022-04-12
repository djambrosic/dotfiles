## INTRODUCTION

This is my base setup for Ubuntu/Debian based Linux. <br>

### How to use

Clone this repository in your `$HOME` folder. Reason for doing that is that script will use `stow` to setup configuration files. <br>
If you know how to use `stow` you can skip step in installation with setuping .dotfiles and run `stow` manually<br>
Before running `install.sh` it is recommended to install [JetBrains Nerd Fonts](https://www.nerdfonts.com/font-downloads).<br>

Currently Vim and Terminal will be themed with Dracula Theme so here are links where to download:

- [Dracula Theme GTK](https://draculatheme.com/gtk)
- [Dracula Cursors](https://www.gnome-look.org/p/1669262)
- [Dracula Icons](https://www.gnome-look.org/p/1541561)

If you are using Gnome you need to install User Themes extension to be able to change shell theme.<br>

Fonts and icons are not included in repository to reduce size. Theme is included and will be updated occassionally.

### Packages

- terminator
- vim
- zsh
- ansible
- neofetch
- curl
- htop
- stow
- gnome-tweaks

### Zsh additionals (optional)

- powerlevel10k
- Oh My Zsh

### Docker (optional)

- Docker Engine
- Docker Compose

### Vim (optional)

- VimPlug
