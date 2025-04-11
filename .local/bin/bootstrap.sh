#!/usr/bin/env bash

# Exit on any errors
# set -e

print_logo() {
    cat << "EOF"
    ____              __       __                          __
   / __ )____  ____  / /______/ /__________ _____    _____/ /_
  / __  / __ \/ __ \/ __/ ___/ __/ ___/ __ `/ __ \  / ___/ __ \
 / /_/ / /_/ / /_/ / /_(__  / /_/ /  / /_/ / /_/ _ (__  / / / /
/_____/\____/\____/\__/____/\__/_/   \__,_/ .___(_/____/_/ /_/
                                         /_/
--> System setup script (Arch Linux)
--> AUR and Flatpak packages included
EOF
}
print_logo
echo -e "--> by \e[1;36mm2x07\e[0m\n"

# Define red colored ERROR label to use throught the script
ERRSTR="\e[1;31m--- ERROR:\e[0m"

if [[ "$(whoami)" == "root" ]]; then
    echo -e "$ERRSTR \e[1;31mroot\e[0m user detected! DO NOT run this script as root\n"
    exit 1
fi

# Return if the script is ran on a non archlinux system
if ! command -v pacman &>/dev/null; then
    echo -e "$ERRSTR command 'pacman' not available. Are you on Arch linux?\n"
    exit 1
else
    # Refresh package db and install most essential tools
    echo -e "--- Running package refresh\n"
    # sudo pacman -Syy
    sudo pacman -S --needed --noconfirm git base-devel
fi

# Installing yay, an AUR helper
if ! command -v yay &>/dev/null; then
    echo -e "\n--- Installing AUR helper 'yay'\n"
    cd /opt
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd - # go back to the directory you were in before
else
    echo -e "\n--- AUR helper 'yay' is already available, continuing\n"
fi

# Packages to install from archlinux repository
PACKAGES=(
# System
zsh
man
wezterm
btop
htop
zip
unzip
wget
curl
mpv
flatpak
plocate
stow
libreoffice-fresh
zen-browser-bin
firefox
# Development
vim
neovim
bat
lazygit
vscodium-bin
# Extra
weechat
tealdeer
fd
findutils
ripgrep
lsd
glow
fzf
neofetch
fastfetch
starship
adw-gtk-theme
# Fonts
ttf-cascadia-mono-nerd
ttf-dejavu-nerd
ttf-jetbrains-mono-nerd
ttf-roboto
noto-fonts
noto-fonts-emoji
noto-fonts-cjk
)

# Install all packages defined in PACKAGES array
# existing packages will be upgraded
echo -e "--- Installing packages using yay\n"
yay -S --needed --noconfirm ${PACKAGES[@]}

# declare -a ERR_STACK
ERR_STACK=()
if [[ $? -gt 0 ]]; then
    ERR_STACK+=("Error(s) occoured while running yay")
fi

# Packages to install from flatpak
FLATPAKS=(
com.mattjakeman.ExtensionManager
com.rafaelmardojai.Blanket
com.github.finefindus.eyedropper
com.github.tchx84.Flatseal
io.gitlab.adhami3310.Impression
org.gnome.World.Iotas
fr.romainvigier.MetadataCleaner
io.missioncenter.MissionCenter
com.obsproject.Studio
org.telegram.desktop
)

echo -e "\n--- Installing flatpak packages\n"

# Install each package individually cus why not
for pak in ${FLATPAKS[@]}; do
    # only install if flatpak in not already installed
    if ! flatpak list | grep -i "$pak" &>/dev/null; then
        echo "--- Installing flatpak: ${pak}"
        flatpak install $pak --assumeyes

        if [[ $? -gt 0 ]]; then
            ERR_STACK+=("Flatpak error. couldn't install $pak")
        fi
    else
        echo "--- Flatpak $pak already installed."
    fi
done

# Populate dotfiles
cd $HOME/.dotfiles
stow --target $HOME .
cd - &>/dev/null

echo -e "\n\e[1;32mFinished\e[0m running! Please recheck script output for any error(s)\n"

# Print collected errors for user
if [[ ${#ERR_STACK} -gt 0 ]]; then
    echo -e "--- ERROR STACK (${#ERR_STACK}):\n"
    for err in ${ERR_STACK[@]}; do
        echo -e "\t$err"
    done
fi
