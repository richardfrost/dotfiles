@ECHO OFF
:: https://packagecontrol.io/docs/syncing

:Check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
  GOTO Backup
) else (
  COLOR 0C
  ECHO Admin privelages required. Please Re-run as Administrator.
  GOTO End
)

:Link
SET "SublimePackages=%Appdata%\Sublime Text 3\Packages"
SET "SublimeUser=%SublimePackages%\User"
SET "DotfilesSublime=%SyncHome%\Apps\File\Sublime\User"
:: Create symbolic link to settings
MKLINK /D "%SublimeUser%" "%DotfilesSublime%"
ECHO Done!

:End
SET SublimePackages=
SET SublimeUser=
SET DotfilesSublime=
