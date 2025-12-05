# =====================================================================
# Export installed applications (Win32 + UWP) to CSV
# - Includes HKLM + HKCU (Steam and per-user apps)
# - Read-only: does NOT modify registry or installed apps
# - Best run in 64-bit, non-admin PowerShell
# Output:  $HOME\user-installed-apps.csv
# Note: Run in PowerShell 64-bit, non-admin
# =====================================================================

# --- Environment sanity checks (warnings only, no blocking) ---

if (-not [Environment]::Is64BitProcess) {
    Write-Warning "You are running 32-bit PowerShell. Results may be incomplete. Prefer 64-bit PowerShell."
}

try {
    $identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Warning "You are running in an elevated (Administrator) session. HKCU will refer to the admin profile, not your normal user. For Steam and per-user apps, run this script *without* Run as Administrator."
    }
} catch {
    # If anything goes weird here, just continue without blocking.
}

# --- Helper: parse InstallDate safely (Win32 style YYYYMMDD or DateTime) ---

function Convert-InstallDate {
    param($raw)

    if (-not $raw) { return $null }

    if ($raw -is [datetime]) {
        return $raw
    }

    $str = $raw.ToString()
    if ($str -match '^\d{8}$') {
        try {
            return [datetime]::ParseExact($str, 'yyyyMMdd', $null)
        } catch {
            return $null
        }
    }

    return $null
}

# --- Win32 Applications (Programs & Features style, including HKCU → Steam / per-user apps) ---

$win32Paths = @(
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

$rawWin32 = Get-ItemProperty -Path $win32Paths -ErrorAction SilentlyContinue

$appsWin32 = $rawWin32 |
    Where-Object {
        $_.DisplayName -and                                     # Must have a name
        $_.SystemComponent -ne 1 -and                           # Exclude system components
        $_.ReleaseType -ne "Update" -and                        # Exclude Windows updates
        $_.ParentKeyName -eq $null                              # Exclude inherited components
    } |
    Select-Object @{
                      Name       = "DisplayName"
                      Expression = { $_.DisplayName }
                  },
                  @{
                      Name       = "DisplayVersion"
                      Expression = { $_.DisplayVersion }
                  },
                  @{
                      Name       = "Publisher"
                      Expression = { $_.Publisher }
                  },
                  @{
                      Name       = "InstallDate"
                      Expression = { Convert-InstallDate $_.InstallDate }
                  },
                  @{
                      Name       = "InstallLocation"
                      Expression = {
                          if ($_.InstallLocation -and $_.InstallLocation.Trim() -ne "") {
                              $_.InstallLocation
                          } else {
                              $null
                          }
                      }
                  },
                  @{
                      Name       = "AppType"
                      Expression = { "Win32" }
                  },
                  @{
                      Name       = "Source"
                      Expression = {
                          $path = $_.PSPath
                          if ($path -like 'Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER*') {
                              'HKCU'
                          }
                          elseif ($path -like 'Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node*') {
                              'HKLM Wow6432Node'
                          }
                          elseif ($path -like 'Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE*') {
                              'HKLM'
                          }
                          else {
                              'Unknown'
                          }
                      }
                  }

# --- UWP / Microsoft Store apps ---

$rawUwp = Get-AppxPackage -ErrorAction SilentlyContinue

# Light filter: skip obvious system frameworks / core stuff
$appsUWP = $rawUwp |
    Where-Object {
        $_.IsFramework -eq $false -and
        $_.Name -notmatch '^Microsoft\.(NET|Edge|Xbox|Gaming|Store|Windows.Camera|Windows.Photos|WindowsCalculator|MSPaint|WindowsSearch)'
    } |
    Select-Object @{
                      Name       = "DisplayName"
                      Expression = { $_.Name }
                  },
                  @{
                      Name       = "DisplayVersion"
                      Expression = { $_.Version }
                  },
                  @{
                      Name       = "Publisher"
                      Expression = { $_.Publisher }
                  },
                  @{
                      Name       = "InstallDate"
                      Expression = { $null }   # UWP doesn't expose this consistently
                  },
                  @{
                      Name       = "InstallLocation"
                      Expression = { $_.InstallLocation }
                  },
                  @{
                      Name       = "AppType"
                      Expression = { "UWP" }
                  },
                  @{
                      Name       = "Source"
                      Expression = { "UWP Package" }
                  }

# --- Combine all apps ---

$allApps = $appsWin32 + $appsUWP

# --- De-duplicate by DisplayName + DisplayVersion + AppType ---

$dedupedApps = $allApps |
    Group-Object -Property DisplayName, DisplayVersion, AppType |
    ForEach-Object {
        # Prefer entries with InstallLocation and/or InstallDate when duplicates exist
        $_.Group |
            Sort-Object `
                { if ($_.InstallLocation) { 0 } else { 1 } }, `
                { if ($_.InstallDate)     { 0 } else { 1 } } |
            Select-Object -First 1
    }

# --- Sort and export ---

$outputPath = Join-Path $HOME 'user-installed-apps.csv'

$dedupedApps |
    Sort-Object DisplayName |
    Export-Csv -Path $outputPath -NoTypeInformation

Write-Host "Export complete: $outputPath"
