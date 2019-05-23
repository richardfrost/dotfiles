$appData = "$env:AppData"
$dotfiles = "$home/.dotfiles"

##
# Functions
function SymlinkReady([string]$path) {
  if (Test-Path -Path $path) {
    if (Test-ReparsePoint -path $path) {
      Write-Host "Already a symlink! - $path"
    } else {
      Write-Warning "File exists but is not a symlink! - $path"
    }
    return $false
  } else {
    return $true
  }
}

function Test-ReparsePoint([string]$path) {
  $file = Get-Item $path -Force -ea SilentlyContinue
  return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

##
# Setup dotfiles

# Setup SSH
# Set-Service ssh-agent -StartupType Automatic
# Start-Service ssh-agent

# Global git
# git config --global user.name ""
# git config --global user.email ""

##
# Setup Symlinks
# Powershell Profile/Aliases
New-Item -ItemType Directory -Path "$home/Documents/WindowsPowerShell" -ErrorAction SilentlyContinue
If (symlinkReady -path "$profile") {
  New-Item -ItemType SymbolicLink -Path "$profile" -Target "$dotfiles/windows/Microsoft.PowerShell_profile.ps1"
}




# Hyper.js
If (!(Test-Path -PathType Container -Path "$appData\hyper")) {
    New-Item -ItemType Directory -Path "$appData\hyper"
}
If (symlinkReady -path "$appData/hyper/.hyper.js") {
  New-Item -ItemType SymbolicLink -Path "$appData/hyper/.hyper.js" -Target "$dotfiles/hyper/hyper.js.symlink"
}