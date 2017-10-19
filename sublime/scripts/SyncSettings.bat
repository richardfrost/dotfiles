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


:Backup
SET "SublimePackages=%Appdata%\Sublime Text 3\Packages"
SET "SublimeUser=%SublimePackages%\User"
SET "SyncedUser=%SyncHome%\Apps\File\Sublime\User"

START Explorer.exe "%SublimePackages%"
ECHO Ready to backup current user folder and create a link to synced user folder!
PAUSE

:: Backup Existing User Folder
IF EXIST "%SublimeUser%" (
	MOVE "%SublimeUser%" "%SublimeUser%-Old"
)


:Link
:: Create symbolic link to settings
MKLINK /D "%SublimeUser%" "%SyncedUser%"
ECHO Done!


:end
ECHO.
ECHO.
ECHO Script Finished. Exiting.
SET SublimePackages=
SET SublimeUser=
SET SyncedUser=
ECHO.
PAUSE