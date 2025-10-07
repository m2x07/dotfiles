#!/usr/bin/env bash

# exit on any errors
set -e

# define list of packages to install
PACKAGES=(
    # system
    zsh
    man
    wezterm
    btop
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
    # development
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
    # fonts
    # also install Maple Mono from github
    ttf-jetbrains-mono-nerd
    ttf-roboto
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    adwaita-fonts
    github-cli
    yt-dlp
)
HYPRLAND_PACKAGES=(
    alacritty
    bluez
    bluez-utils
    dolphin
    hyprland
    hyprpaper
    hyprshot
    hyprpicker
    hyprlock
    hyprsunset
    hyprpolkitagent
    hyprsysteminfo
    hyprland-qtutils
    xdg-desktop-portal-hyprland
    flameshot
    waybar
    walker
    elephant
    elephant-calc
    elephant-clipboard
    elephant-desktopapplications
    elephant-providerlist
    elephant-symbols
    elephant-todo
    elephant-unicode
    elephant-runner
    dunst
    wlogout
    ly
    imv
    brightnessctl
    qt5-wayland
    qt6-wayland
    qt5ct-kde
    qt6ct-kde
    nwg-look
    breeze
    breeze-icons
    gnome-themes-extra
    ttf-hack
    inter-fonts
    archlinux-xdg-menu
    papirus-icon-theme
    zathura
    zathura-pdf-popplej
    poppler-glib
    pppler-qt6
    poppler-data
    protobuf
    cairo
    gtk4
    gtk4-layer-shell
    pipewire
    pipewire-alsa
    pipewire-audio
    pipewire-pulse
    wireplumber
)
FLATPAKS=(
    com.mattjakeman.ExtensionManager
    com.rafaelmardojai.Blanket
    com.github.tchx84.Flatseal
    io.gitlab.adhami3310.Impression
    fr.romainvigier.MetadataCleaner
    io.missioncenter.MissionCenter
    com.obsproject.Studio
    org.telegram.desktop
)

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

ERRSTR="\e[1;31m--- ERROR:\e[0m"    # define a red error label

# terminate if script is ran as root user
if [[ "$(whoami)" == "root" ]]; then
    echo -e "$ERRSTR DO NOT run this script as root"
    exit 1
fi

# terminate if script is ran on a non archlinux system
if ! command -v pacman &>/dev/null; then
    echo -e "$ERRSTR command 'pacman' not available. are you sure on arch linux?"
else
    echo -e "--- running package refresh\n"
    sudo pacman -Syy --needed --noconfirm git base-devel
fi

# install yay, and AUR helper
if ! command -v yay &>/dev/null; then
    echo -e "--- installing AUR helper 'yay'\n"
    PREVWD=$(pwd)
    TMPDIR=$(mktemp -d)
    cd "$TMPDIR"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    echo -e "--- 'yay' is cloned at $TMPDIR\n"
    cd "$PREVWD"
else
    echo -e "--- 'yay' is already available, continuing\n"
fi

# install all packages from the PACKAGES array
echo -e "--- installing packages using yay\n"
yay -S --needed --noconfirm ${PACKAGES[@]}

echo -e "\n--- installing flatpak packages\n"
for pak in "${FLATPAKS[@]}"; do
    # only install if flatpak is not already installed
    if ! flatpak info "$pak" &>/dev/null; then
        flatpak install "$pak" --assumeyes
    else
        echo "--- flatpak $pak already installed. skipping"
    fi
done

# populate dotfiles
cd "$HOME/.dotfiles"
stow --target $HOME .
cd - &>/dev/null

# update xdg user directories
xdg-user-dirs-update

# if hyprland argument is provided, setup things for hyprland
if [ "$1" == "hyprland" ]; then
    echo -e "--- configuring for hyprland\n"
    echo -e "--- installing packages for hyprland\n"
    yay -S --needed --noconfirm ${HYPRLAND_PACKAGES}

    # install maple mono font
    echo "--- installing maple mono font"
    cd $(xdg-user-dir DOWNLOAD)
    curl -L -o maplemono-nf-cn.zip "https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-NF-CN.zip"
    mkdir $HOME/.fonts
    unzip ./maplemono-nf-cn.zip -d "$HOME/.fonts"
    fc-cache -fv
    cd pwd

    echo "--- uninstalling flatpaks not needed for hyprland"
    flatpak uninstall com.mattjakeman.ExtensionManager
    flatpak uninstall com.github.finefindus.eyedropper

    # enable dark theme for flatpak apps
    mkdir -p $HOME/.themes
    # copy theme to home directory so flatpaks can access it
    cp -r /usr/share/themes/adw-gtk3-dark ~/.themes/
    flatpak override --user --env=GTK_THEME=adw-gtk3-dark

    # vscode/vscodium sets itself as default app for inode/directory mimetype
    # for some reason. correct that
    xdg-mime default org.kde.dolphin.desktop inode/directory

    # set default app for image
    xdg-mime default imv-dir.desktop image/png
    xdg-mime default imv-dir.desktop image/jpeg

    # enable a display (login) manager. 'ly' in our case
    systemctl enable ly.service
    echo -e "--- hyprland installation complete"
    echo -e "--- make sure to run 'hyprctl reload' later"

    # enable battery level notifier service
    systemctl --user daemon-reexec
    systemctl --user daemon-reload
    systemctl --user enable --now battery_notifier.timer
fi

# print out final message after finishing the script
echo -e "\e[1;32mfinished running! please recheck script output for any error(s)\e[0m\n"
