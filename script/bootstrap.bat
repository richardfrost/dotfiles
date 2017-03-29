@ECHO OFF
COLOR 02
SetLocal EnableDelayedExpansion

:Check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
	GOTO EnvVars
) else (
	COLOR 0C
	ECHO Admin privelages required. Please Re-run as Administrator.
	GOTO End
)


:EnvVars
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


:Executor
ECHO.
ECHO ==============================
ECHO Setup Executor
ECHO ==============================
ECHO.
IF NOT EXIST "%AppData%\Executor" (
	mkdir "%AppData%\Executor"
)
IF NOT EXIST "%AppData%\Executor\Executor.ini" (
	copy "%Apps%\Executor\Executor-Defaults.ini" "%AppData%\Executor\Executor.ini"
)



:MyAHK
ECHO.
ECHO ==============================
ECHO Setup MyAHK
ECHO ==============================
ECHO.
IF NOT EXIST "%ProgramFiles%\MyAHK.exe" (
	copy "%Apps%\MyAHK.exe" "%ProgramFiles%\MyAHK.exe"

	:: Open Explorer to allow user to install certificate
	start Explorer.exe %ProgramFiles%

	:: Open Explorer to allow user to set MyAHK to run on startup
	start Explorer.exe Shell:Startup
)



:Registry
ECHO.
ECHO ==============================
ECHO Import Registry Keys
ECHO ==============================
ECHO.
:: Sysinternals EULA
reg import "%Apps%\Windows\Sysinternals\Info\Sysinternals-EULA.reg"

:: Custom registry keys
reg query "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Power Menu" > nul 2>&1
IF %ERRORLEVEL%==1 start Explorer.exe "%Apps%\Windows\RegistryKeys\Combined"

:: Mouse Sensitivity
:: reg import "%Apps%\Windows\RegistryKeys\Enable-Mouse_Sensitivity.reg"
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 14



:RunApps
ECHO.
ECHO ==============================
ECHO Starting applications
ECHO ==============================
ECHO.
tasklist /FI "IMAGENAME eq Executor.exe" 2>NUL | find /I /N "Executor.exe">NUL
IF NOT "%ERRORLEVEL%"=="0" start %Apps%\Executor\Executor.exe

:: tasklist /FI "IMAGENAME eq VoluMouse.exe" 2>NUL | find /I /N "VoluMouse.exe">NUL
:: IF NOT "%ERRORLEVEL%"=="0" start %Apps%\Media\Audio\VoluMouse\VoluMouse.exe



:SSH
ECHO.
ECHO ==============================
ECHO SSH Key
ECHO ==============================
ECHO.
IF NOT EXIST "%UserProfile%\.ssh" (
	mkdir "%UserProfile%\.ssh"
	copy /y NUL "%UserProfile%\.ssh\id_rsa" >NUL
	copy /y NUL "%UserProfile%\.ssh\id_rsa.pub" >NUL
	start Explorer.exe "%UserProfile%\.ssh"
)



:Libraries
ECHO.
ECHO ==============================
ECHO Other Settings
ECHO ==============================
ECHO Make sure to setup desired library locations such as Documents, Pictures, etc!
ECHO MSI stuffx
ECHO.


:End
ECHO.
PAUSE
