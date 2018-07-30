##
# Variables
#
$codeDir = 'D:\code'
$dotfiles = "$home/.dotfiles"
$editor = 'code'

##
# My Aliases
#
function uptime { (get-date) - (gcim Win32_OperatingSystem).LastBootUpTime }
Set-Alias -Name 'reload' -Value 'powershell'

##
# Development Aliases
#
function e { & "$editor" $args }

function c { set-location (Join-Path -Path "$codeDir" -childPath ($args -join ' ')) }


# Git Functions
function Get-GitCurrentBranch { git symbolic-ref --short HEAD; }

# Git
Set-Alias -Name 'g' -Value git
Set-Alias -Name 'gcb' -Value Get-GitCurrentBranch
function Get-GitStatus { $ErrorView="CategoryView"; & git status; $ErrorView=$null }
Set-Alias -Name 'gs' -Value Get-GitStatus
function gb { & git branch $args }
# Set-Alias -Name 'gp' -Value 'git pull' # Get-ItemProperty
function gco { & git checkout $args }
function gcob { & git checkout -b $args }
function Get-GitCheckoutMaster { & git checkout master }
Set-Alias -Name gcom -Value Get-GitCheckoutMaster
function Get-GitPullOrigin { & git pull origin }
Set-Alias -Name 'gpo' -Value Get-GitPullOrigin
function Get-GitPullOriginMaster { & git pull origin master }
Set-Alias -Name 'gpom' -Value Get-GitPullOriginMaster
function gd { & git diff $args }
function gcommit { & git commit -v $args } # gc
function gcn { & git commit -v --no-verify $args }
function ga { & git add $args }
function gadd { & git add . }
function gr { & git reset $args }
function gcomp { & git diff master..$(Get-GitCurrentBranch) }
function gpusho { & git push origin $args }
function gpushb { & git push origin $(Get-GitCurrentBranch) }
# alias gpubb='git-publish-branch' # Not needed?
function gf { & git fetch $args }
function glog { & git log --oneline --all --graph --decorate $args }
function glogp { & git log --pretty=format:"%h %s" --graph $args }
function gcleanmerged { & git branch --merged | Where-Object {-not ($_ -like "*master")} | ForEach-Object { & git branch -d $_.trim() } }
function gcleanremote { & git remote prune origin } # Added
function gforget { & git rm --cached }

# Git - Advanced
function gabortmerge { & git reset --hard HEAD }
function git_protect_master { New-Item -Type SymbolicLink -Path '.git/hooks/pre-commit' -Target "$dotfiles/git/hooks/pre-commit" }
function gpushu { & git push -u origin $(Get-GitCurrentBranch) }
function gundo { & git reset --soft HEAD~1 }
function gredo { & git commit -c ORIG_HEAD }

# Git Stash
# Ruby
