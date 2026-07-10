# Dotfiles

## Requirements

* Git
* GNU Stow

Install:

```sh
brew install git stow
```

## Installation

Clone the repository:

```sh
git clone git@github.com:KineticTactic/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Create symlinks:

```sh
stow nvim
stow git
stow kitty
```

Or symlink everything:

```sh
stow */
```

