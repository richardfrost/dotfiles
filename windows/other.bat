@ECHO OFF
COLOR 02
SetLocal EnableDelayedExpansion

SET "ScriptDir=cd"
ECHO %ScriptDir%
pause

:Check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
	GOTO EnvVars
) else (
	COLOR 0C
	ECHO Admin privelages required. Please Re-run as Administrator.
	GOTO End
)

:GitConfig
ECHO.
ECHO ==============================
ECHO Setup Environmental Variables
ECHO ==============================
ECHO.
IF "%SyncHome%"=="" (SET Default="D:\Dropbox") ELSE (SET Default="%SyncHome%")
SET /P SyncHomePath=SyncHome SyncHomePath [%Default%]: || SET SyncHomePath=%Default%

ECHO.
ECHO Use %SyncHomePath% as SyncHome?
PAUSE

SET SyncHome "%SyncHomePath%"
SETX SyncHome "%SyncHomePath%"
SET Apps "%%SyncHome%%\Apps"
SETX Apps "%%SyncHome%%\Apps"
SETX Cmder "%%Apps%%\System\Cmder\Cmder.exe"
SETX Sublime "%ProgramFiles%\Sublime Text 3\Sublime_text.exe"



:Symlink
