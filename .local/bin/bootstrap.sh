#!/usr/bin/env bash

# Exit on any errors
set -e

if [ $2 == "debug" ]; then
    set -x
    echo -e "--- RUNNING IN DEBUG MODE"
    echo -e "--- All command will be printed to console before being executed"
fi

# Define variables
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
HYPRLAND_PACKAGES=(
alacritty
dolphin
hyprland
hyprpaper
hyprshot
hyprpicker
hyprlock
hyprsunset
xdg-desktop-portal-hyprland
hyprpolkitagent
hyprsysteminfo
hyprland-qtutils
waybar
wofi
dunst
wlogout
ly
imv
brightnessctl
qt5-wayland
qt5-wayland
qt5ct
qt6ct-kde
nwg-look
kvantum
breeze
breeze-icons
gnome-themes-extra
ttf-hack
inter-fonts
archlinux-xdg-menu
papirus-icon-theme
)
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
ERRSTR="\e[1;31m--- ERROR:\e[0m"        # Define a red error label
ERR_STACK=()                            # Declare an empty error stack

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
    sudo pacman -Syy --needed --noconfirm git base-devel
fi

# Installing yay, an AUR helper
if ! command -v yay &>/dev/null; then
    PWD=$(pwd)
    echo -e "\n--- Installing AUR helper 'yay'\n"
    cd /opt
    git clone https://aur.archlinux.org/yay.git
    chown -R $USER:$USER ./yay
    cd yay
    makepkg -si --noconfirm
    cd $PWD # go back to the directory you were in before
else
    echo -e "\n--- AUR helper 'yay' is already available, continuing\n"
fi

# Install all packages defined in PACKAGES array
# existing packages will be upgraded
echo -e "--- Installing packages using yay\n"
yay -S --needed --noconfirm ${PACKAGES[@]}

if [[ $? -gt 0 ]]; then
    ERR_STACK+=("Error(s) occoured while running yay. exit code ${?}")
fi

echo -e "\n--- Installing flatpak packages\n"

# Install each package individually cus why not
for pak in ${FLATPAKS[@]}; do
    # only install if flatpak in not already installed
    if ! flatpak list | grep -i "$pak" &>/dev/null; then
        echo "--- Installing flatpak: ${pak}"
        flatpak install $pak --assumeyes

        if [[ $? -gt 0 ]]; then
            ERR_STACK+=("Flatpak error. couldn't install $pak. exit code ${?}")
        fi
    else
        echo "--- Flatpak $pak already installed."
    fi
done

# Populate dotfiles
cd $HOME/.dotfiles
stow --target $HOME .
cd - &>/dev/null

# If hyprland argument is provided to the script, install packages for hyprland
# and configure few other things
if [ "$1" == "hyprland" ]; then
    echo -e "--- Hyprland flag provided"
    echo -e "--- Installing Hyprland and other packages for it"
    yay -S --needed --noconfirm ${HYPRLAND_PACKAGES[@]}

    if [[ $? -gt 0 ]]; then
        ERR_STACK+=("Error(s) occoured while installing hyprland packages. exit code ${?}")
    fi

    echo "--- Uninstalling flatpaks unnecssary for hyprland"
    flatpak uninstall com.mattjakeman.ExtensionManager
    flatpak uninstall com.github.finefindus.eyedropper

    # Enable dark theme for flatpak apps
    cp $HOME/.themes
    cp -r /usr/share/themes/adw-gtk3-dark ~/.themes/
    flatpak override --user --env=GTK_THEME=adw-gtk3-dark

    # vscode/vscodium sets itself as default app for inode/directory mimetype 
    # for some reason
    xdg-mime default org.kde.dolphin.desktop inode/directory
    xdg-mime default imv.desktop image/png
    xdg-mime default imv.desktop image/jpeg

    # enable a display manager (login manager), LY in our case
    systemctl enable ly.service
    echo -e "\n\e[1;32mHyprland installation complete\e[0m"
    echo -e "Please run 'hyprctl reload' if display resolution or fonts are not rendered properly"
fi

echo -e "\n\e[1;32mFinished\e[0m running! Please recheck script output for any error(s)\n"

# Print collected errors for user
if [[ ${#ERR_STACK} -gt 0 ]]; then
    echo -e "--- ERROR STACK (${#ERR_STACK}):\n"
    for err in ${ERR_STACK[@]}; do
        echo -e "\t$err"
    done
fi
