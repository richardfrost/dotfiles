# Dotfiles Notes

## Programs

- [Ninite](https://www.ninite.com) to install basic packages
  - 7-Zip
  - Chrome
  - Firefox
- [VSCode](https://code.visualstudio.com/download) (User Install)
  - Settings Sync (Shan Khan)
- [Keybase.io](https://keybase.io/)
  - GPG key
- Windows Terminal (Windows Store)
  - Import settings
- [git](https://git-scm.com/download/win)
- Quicklook (Windows Store)

## Other Settings

- SSH keys
- MyAHK

## Registry Settings

- Standard: **Recommended** registry settings
- Expanded: Same as standard + more in context menus
- Revert: Restore to defaults

### Naming

| Verb           | Description                     |
| -------------- | ------------------------------- |
| Enable/Disable | Modify default system behavior  |
| Default        | Restore default system behavior |
| Add            | Add context menu entries        |
| Desktop        | Adjust Desktop context menu     |
| Remove         | Remove context menu entries     |

## WSL

### Enable WSL

```shell
# Recommended install:
# TODO: Figure out how to not install Ubuntu
wsl --install -d Ubuntu

# Deprecated: Use "Windows Subsystem for Linux" From the Microsoft Store to get WSLg
# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

### Download Arch Linux

- [Arch WSL](https://github.com/yuk7/ArchWSL/releases/latest)
- And extract to `%UserProfile%\WSL\Arch`
- Run `Arch.exe`

### Setup WSL

```shell
pacman-key --init
pacman-key --populate
pacman-key --refresh-keys
pacman -Sy archlinux-keyring
pacman -Syuu

##
# Packages
sudo pacman -S git htop openssh p7zip tig tmux zsh

# Node
# sudo pacman -S nodejs npm

##
# Create user
useradd richard --create-home
passwd richard

# Interactively edit sudoers
# richard ALL=(ALL) ALL
EDITOR=vim visudo

# Windows: Set default WSL user
./Arch.exe config --default-user richard

# SSH
su - richard

# Interactively run commands as user
mkdir $HOME/.ssh ; chmod 700 $HOME/.ssh
# Only if you already have SSH keys in Windows
cp /mnt/c/users/richard.frost/.ssh/id_rsa* $HOME/.ssh
chmod 600 $HOME/.ssh/id_rsa
chmod 644 $HOME/.ssh/id_rsa.pub

# Dotfiles
git clone git@github.com:richardfrost/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap

## Dev
# NVM - https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
nvm install stable

# Install gitmoji-cli
npm i -g gitmoji-cli

# Windows Terminal
# Powerline Font
```~/.dotfiles/fonts/Windows/Roboto Mono for Powerline```
# Settings
```~/.dotfiles/Windows/terminal/settings.json```

##
# Git config
Source: https://github.com/Microsoft/WSL/issues/2318#issuecomment-314631096
Windows: git config --global core.autocrlf true
WSL: git config --global core.autocrlf input
```

#### Fix WSL Permissions (Optional)

```conf
# /etc/wsl.conf

[automount]
enabled = true
mountFsTab = false
root = /mnt/
options = "metadata,umask=22,fmask=11"

[network]
generateHosts = true
generateResolvConf = true
```

#### Fix for slow network (Windows 11)

```sh
# https://github.com/microsoft/WSL/issues/4901#issuecomment-909723742
sudo rm /etc/resolv.conf
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo bash -c 'echo "[network]" > /etc/wsl.conf'
sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
sudo chattr +i /etc/resolv.conf
```

## GPG

### Keybase

```sh
# Arch
sudo pacman -S keybase

# macOS
brew update
brew upgrade
brew install gnupg

# Export key from keybase
keybase login
keybase pgp export > keybase-public.key
keybase pgp export --secret > keybase-private.key
# If you get this error: ERROR Failed to get getpin greeting: EOF
# Run this: `keybase config set -b pinentry.disabled true`

# Import to local gpg
gpg-agent
gpg --allow-secret-key-import --import keybase-private.key
gpg --import keybase-public.key
# If you need to restart gpg-agent
# gpgconf --kill gpg-agent

# Cleanup
rm keybase-p*

# Setup git
git config --global user.signingkey [GPG key ID]

# Auto-sign commits on a repo:
# git config commit.gpgsign true

# Auto-sign commits on all local repos:
git config --global commit.gpgsign true
```
