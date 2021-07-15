@ECHO OFF

:checkPermissions
net session >nul 2>&1
if %errorLevel% == 0 (
	GOTO atom
) else (
	COLOR 0C
	ECHO Admin privelages required. Please Re-run as Administrator.
	GOTO nonAdmin
)

:: The mklink command is used to create a symbolic link. It is natively available in Windows Vista/2008+. It has the following command line syntax:[1]
:: mklink [[/D] | [/H] | [/J]] linkName target
:: /D � Creates a directory symbolic link. Default is a file symbolic link.
:: /H � Creates a hard link instead of a symbolic link.
:: /J � Creates a Directory Junction.
:: linkName � Specifies the new symbolic link name.
:: target � Specifies the path (relative or absolute) that the new link refers to.
:: Just like ordinary files and folders, del and rmdir can be used to delete symbolic links to files and directories.
:: 'mklink /D C:\Users\Whitson\Documents\Docs C:\Users\Whitson\Dropbox\Docs'
SET DirCMD=mklink /D      :: create symbolic link for folders
SET JunctionCMD=mklink /J :: create junction link for folders
SET FileCMD=mklink        :: create symbolic link for files.
SET ScriptDir=%cd%        :: Script working directory
SET Confirm=0             :: User Confirmation Variable

:: Check Admin Rights
GOTO checkPermissions


:: Non-Admin User Detected
:nonAdmin
COLOR C0
ECHO.
ECHO.
ECHO		�������������������������������������������ͻ
ECHO		� Not an Admin! Please Run as Administrator �
ECHO		�������������������������������������������ͼ
ECHO.
ECHO.

SET /P Response="Would you like to run anyway (test)? (Y/N): "
IF '%Response%'=='y' GOTO atom
IF '%Response%'=='Y' GOTO atom
GOTO end


:atom
ECHO.
CD "%ScriptDir%\..\atom.symlink"
rem mklink /D "%USERPROFILE%\.atom" %CD%\atom.symlink
rem FOR %%G IN (DIR /b) DO %FileCMD% "%%G" "%UserProfile%\.atom"
rem FOR %%G IN (DIR /b) DO ECHO %FileCMD% "%%G"
ECHO.

PAUSE
GOTO end


:: New Custom Link (File)
:customFile
SET Mode=
SET Respone=
SET Confirm=0
SET CustomFolder=
SET CustomFile=
ECHO.
SET /P Link="Please provide the path and file name for the link (Shortcut): "
ECHO.
SET /P CustomFile="Please provide the target path for the link (Destination): "
ECHO.

ECHO Are you sure you want to run this command?
ECHO.
ECHO %FileCMD% %Link% %CustomFile%
ECHO.

SET /P Response="(Y/N): "
IF '%Response%'=='y' SET Confirm=1
IF '%Response%'=='Y' SET Confirm=1
IF NOT '%Confirm%'=='1' GOTO menu

ECHO.
%DirCMD% %Link% %CustomFile%
ECHO.

PAUSE
GOTO menu


:: New Custom Link (File)
:customDir
SET Mode=
SET Respone=
SET Confirm=0
SET CustomFile=
SET CustomFile=
SET
ECHO.
SET /P Link="Please provide the path and name for the link (Shortcut): "
ECHO.
SET /P CustomFile="Please provide the target path for the link (Destination): "
ECHO.

ECHO Are you sure you want to run this command?
ECHO.
ECHO %DirCMD% %Link% %CustomFile%
ECHO.

SET /P Response="(Y/N): "
IF '%Response%'=='y' SET Confirm=1
IF '%Response%'=='Y' SET Confirm=1
IF NOT '%Confirm%'=='1' GOTO menu

ECHO.
%DirCMD% %Link% %CustomFolder%
ECHO.

PAUSE
GOTO menu


:end
SET ScriptDir=
SET DirCMD=
SET FileCMD=
SET Confirm=
SET Mode=
SET Response=
SET Link=
SET CustomFolder=
SET CustomFile=

ECHO.
ECHO.
ECHO Script Finished. Exiting.
ECHO.
PAUSE
