function Invoke-MirrorFolder {
  Param
  (
    [String]$Source,
    [String]$Destination
  )

  Robocopy $Source $Destination /MIR /FFT /Z /XA:H /W:5
}

function New-Symlink {
  Param (
    [String]$Link,
    [String]$Target
  )

  Write-Host "Creating Symlink: ${Link} => ${Target}"
}

function Set-UserEnvVar {
  Param
  (
    [String]$Name,
    [String]$Value
  )

  Write-Host "Setting User EnvVar: ${Name} = ${Value}"
  if ((Get-ChildItem -Path "Env:\$Name").Value -ne $Value) {
    [System.Environment]::SetEnvironmentVariable($Name, $Value, [System.EnvironmentVariableTarget]::User)
  }
}

## Setup System
# Variables
$SyncHomePath = $env:OneDrive
$AppsPath = "$SyncHomePath\Apps"

## Environment Variables
Set-UserEnvVar -Name 'SyncHome' -Value $SyncHomePath
Set-UserEnvVar -Name 'Apps' -Value $AppsPath

## Symlinks
# ! Stored in OneDrive now
# New-Symlink -Link $env:USERPROFILE\Documents\WindowsPowerShell\ -Target

## Copy Files
# Copy Shortcuts
# C:\Users\phros\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
if (Test-Path -Path "$AppsPath\Windows\Shortcuts") {
  Write-Host "Copying shortcut files to Start Menu..."
  Invoke-MirrorFolder -Source "$AppsPath\Windows\Shortcuts" -Destination "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Shortcuts"
}
