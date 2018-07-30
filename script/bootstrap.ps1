$dotfiles = "$home/.dotfiles"

# Powershell Profile/Aliases
New-Item -ItemType Directory -Path "$home/Documents/WindowsPowerShell" -ErrorAction SilentlyContinue
New-Item -ItemType SymbolicLink -Path "$profile" -Target "$dotfiles/windows/Microsoft.PowerShell_profile.ps1"

# Setup SSH
Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent

# Global git
# git config --global user.name ""
# git config --global user.email ""