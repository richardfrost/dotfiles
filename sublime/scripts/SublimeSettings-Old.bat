@ECHO OFF
SET Confirm=0


:: Present the Menu and receive user input:
:menu
CLS
COLOR 02
ECHO.
ECHO.
ECHO		ษออออออออออออออออออออออออออออออออป
ECHO		บ        Sublime Settings        บ
ECHO		ฬออออออออออออออออออออออออออออออออน
ECHO		บ                                บ
ECHO		บ  1. Import Settings            บ
ECHO		บ  2. Export Settings            บ
ECHO		บ                                บ
ECHO		บ  Q. Exit                       บ
ECHO		บ                                บ
ECHO		ศออออออออออออออออออออออออออออออออผ
ECHO.
ECHO.

:: set /P parameter=prompt
SET /P Mode="Please select an action from the list: "

IF '%Mode%'=='1' GOTO Import
IF '%Mode%'=='2' GOTO Export
IF '%Mode%'=='q' GOTO end
IF '%Mode%'=='Q' GOTO end

ECHO.
ECHO Invalid Choice! Please enter a selection between 1 and 2.
ECHO.
PAUSE
GOTO menu


:Import
COLOR C0

ECHO.
SET /P Response="Are you sure you want IMPORT Sublime settings? (Y/N): "
ECHO.
ECHO.
IF '%Response%'=='y' SET Confirm=1
IF '%Response%'=='Y' SET Confirm=1
IF NOT '%Confirm%'=='1' GOTO end

SET Source="%Apps%\File\Sublime\Default (Windows).sublime-keymap"
SET Dest="%AppData%\Sublime Text 3\Packages\User"
copy %Source% %Dest%

SET Source="%Apps%\File\Sublime\Preferences.sublime-settings"
copy %Source% %Dest%


ECHO.
GOTO end


:Export
COLOR B0

ECHO.
SET /P Response="Are you sure you want EXPORT Sublime settings? (Y/N): "
ECHO.
ECHO.
IF '%Response%'=='y' SET Confirm=1
IF '%Response%'=='Y' SET Confirm=1
IF NOT '%Confirm%'=='1' GOTO end

SET Source="%AppData%\Sublime Text 3\Packages\User\*.sublime-*"
SET Dest="%Apps%\File\Sublime"

copy %Source% %Dest%
ECHO.
GOTO end


:end
SET Confirm=
SET Mode=
SET Response=
SET Source=
SET Dest=

ECHO.
ECHO.
ECHO Script Finished. Exiting.
ECHO.
PAUSE