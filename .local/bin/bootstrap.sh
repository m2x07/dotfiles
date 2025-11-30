#!/usr/bin/env bash

# exit on any errors
set -e

# define list of packages to install
PACKAGES=(
    # system
    zsh
    man
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
    pwvucontrol
    keepassxc
    power-profiles-daemon
    ungoogled-chromium-bin
    gimp
    # development
    vim
    neovim
    lazygit
    vscodium-bin
    github-cli
    zed
    # Extra
    tealdeer
    fd
    ripgrep
    lsd
    bat
    duf
    glow
    fzf
    weechat
    findutils
    neofetch
    fastfetch
    starship
    adw-gtk-theme
    yt-dlp
    tree
    mesa-utils
    wev
    usbutils
    mpv-mpris
    acpi
    # fonts
    ttf-jetbrains-mono-nerd
    ttf-roboto
    terminus-font
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    adwaita-fonts
    vesktop
    cava
    systemdgenie
    dosfstools
    arch-install-scripts
    pdftk
    exfatprogs
    pfetch
)
HYPRLAND_PACKAGES=(
    alacritty
    kitty
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
    xdg-desktop-portal-gtk
    flameshot
    waybar
    walker
    elephant
    elephant-calc
    elephant-clipboard
    elephant-desktopapplications
    elephant-archlinuxpkgs
    elephant-providerlist
    elephant-symbols
    elephant-todo
    elephant-unicode
    elephant-runner
    dunst
    wlogout
    ly
    imv-git
    brightnessctl
    qt5-wayland
    qt6-wayland
    qt5ct-kde
    qt6ct-kde
    nwg-look
    breeze
    breeze5
    breeze-icons
    gnome-themes-extra
    ttf-hack
    archlinux-xdg-menu
    papirus-icon-theme
    zathura
    zathura-pdf-poppler
    poppler-glib
    poppler-qt6
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
    uwsm
    libnewt
    kate
)
FLATPAKS=(
    com.rafaelmardojai.Blanket
    com.github.tchx84.Flatseal
    fr.romainvigier.MetadataCleaner
    io.missioncenter.MissionCenter
    com.obsproject.Studio
    org.telegram.desktop
    io.github.flattool.Warehouse
    org.gnome.World.Iotas
    it.mijorus.gearlever
    me.iepure.devtoolbox
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
    sudo pacman -Syy --needed git base-devel
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
yay -S --needed "${PACKAGES[@]}"

# make dark theme available for flatpak
mkdir -p ~/.themes
cp -r /usr/share/themes/adw-gtk3-dark ~/.themes/
flatpak override --user --filesystem=xdg-config:~/.themes:ro
flatpak override --user --env=GTK_THEME=adw-gtk3-dark

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
stow --target "$HOME" .
cd - &>/dev/null

# create xdg user dirs
mkdir -p "$HOME"/documents "$HOME"/downloads "$HOME"/desktop \
    "$HOME"/pictures "$HOME"/videos "$HOME"/music \
    "$HOME"/templates "$HOME"/public

# update xdg user directories
xdg-user-dirs-update

# if hyprland argument is provided, setup things for hyprland
if [ "$1" == "hyprland" ]; then
    echo -e "--- configuring for hyprland\n"
    echo -e "--- installing packages for hyprland\n"
    yay -S --needed "${HYPRLAND_PACKAGES[@]}"

    # install maple mono font
    if [ ! -d "$HOME/.fonts/maple-mono" ]; then
        echo "--- installing maple mono font"
        cd "$(xdg-user-dir DOWNLOAD)"
        curl -L -o maplemono-nf-cn.zip "https://github.com/subframe7536/maple-font/releases/latest/download/MapleMono-NF-CN.zip"
        mkdir -p "$HOME"/.fonts/maple-mono
        unzip ./maplemono-nf-cn.zip -d "$HOME/.fonts/maple-mono"
        fc-cache -fv
        cd -
    fi

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
    systemctl --user enable --now battery_notify.timer
fi

# print out final message after finishing the script
echo -e "\e[1;32mfinished running! please recheck script output for any error(s)\e[0m\n"
echo -e "\nreboot your system to finalize changes"
