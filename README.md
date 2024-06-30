# Installation

### Create a read-only clone
```sh
git clone --bare https://github.com/inno/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

### Automation

Add the following line to the shell config of your choice
`alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'`

### Change to a writable clone
```sh
dotfiles remote set-url origin git@github.com:inno/dotfiles.git
```

Adapted from https://wiki.archlinux.org/title/Dotfiles
