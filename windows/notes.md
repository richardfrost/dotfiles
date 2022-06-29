# Programs
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

# Other Settings
- SSH keys
- MyAHK

# Registry Settings
- Standard: **Recommended** registry settings
- Expanded: Same as standard + more in context menus
- Revert: Restore to defaults

## Naming
| Verb           | Description                     |
| -------------- | ------------------------------- |
| Enable/Disable | Modify default system behavior  |
| Default        | Restore default system behavior |
| Add            | Add context menu entries        |
| Desktop        | Adjust Desktop context menu     |
| Remove         | Remove context menu entries     |

# WSL
### Enable WSL
```shell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

### Download Arch Linux
- https://github.com/yuk7/ArchWSL/releases/latest
- And extract to `%UserProfile%\WSL\Arch`
- Run `Arch.exe`

### Setup WSL
```shell
pacman-key --init
pacman-key --populate
pacman -Syu

# Create user
useradd richard --create-home
passwd richard
visudo
# richard ALL=(ALL) ALL

# Packages
sudo pacman -S git htop openssh p7zip tig tmux zsh

# Node
sudo pacman -S nodejs npm

# SSH
su - richard
mkdir $HOME/.ssh ; chmod 700 $HOME/.ssh
cp /mnt/c/users/richard.frost/.ssh/id_rsa* $HOME/.ssh
chmod 600 $HOME/.ssh/id_rsa
chmod 644 $HOME/.ssh/id_rsa.pub

# Dotfiles
git clone git@github.com:richardfrost/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap

# Setup
ln -s /mnt/d/code ~/code

# Windows: Set default WSL user
./Arch.exe config --default-user richard

# Git config
Source: https://github.com/Microsoft/WSL/issues/2318#issuecomment-314631096
Windows: git config --global core.autocrlf true
WSL: git config --global core.autocrlf input

# NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install gitmoji-cli
npm i -g gitmoji-cli
```

### Fix WSL Permissions (Optional)
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

# GPG
### Keybase
```shell
sudo pacman -S keybase

# Export key from keybase
keybase login
keybase pgp export > keybase-public.key
keybase pgp export --secret > keybase-private.key

# Import to local gpg
gpg-agent
gpg --allow-secret-key-import --import keybase-private.key
gpg --import keybase-public.key

# Cleanup
rm keybase-p*