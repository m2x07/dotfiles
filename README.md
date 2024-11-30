my dotfiles. managed using [gnu stow](https://www.gnu.org/software/stow/)

> [!NOTE]
> overwrites the existing files. make sure to back them up

**link the dotfiles:**
```bash
stow --target $HOME .
```

**unlink the dotfiles:**
```bash
stow --target $HOME --delete .
```

documentation for stow: https://www.gnu.org/software/stow/manual/stow.html
