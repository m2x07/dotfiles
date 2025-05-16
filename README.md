my dotfiles. managed using [gnu stow](https://www.gnu.org/software/stow/)

> [!NOTE]
> overwrites the existing files. make sure to back them up

# Using the setup script

A setup script `bootstrap.sh` is located inside `./.local/bin/`. \
After installing Arch linux, run the script to install all necessary packages and apply other configurations

If you wish to install Hyprland, instead of a standard DE like GNOME, KDE then run
the script with `hyprland` argument

```bash
./.local/bin/bootstrap.sh hyprland
```

# Managing dotfiles using `stow`

**link the dotfiles:**

```bash
stow --target $HOME .
```

**unlink the dotfiles:**

```bash
stow --target $HOME --delete .
```

it is recommneded to install these fonts: \
(this step is already covered by our bootstrap script)

```bash
sudo pacmam -S ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd
```

documentation for stow: https://www.gnu.org/software/stow/manual/stow.html
