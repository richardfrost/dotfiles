:: use this file to run your own startup commands
:: use @ in front of the command to prevent printing the command

:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd
:: set PATH=%CMDER_ROOT%\vendor\whatever;%PATH%

:: Add folders to PATH
@set PATH=%PATH%;%Apps%\Windows\Sysinternals

:: Run SSH Agent if system has an SSH key
@IF EXIST "%UserProfile%\.ssh\id_rsa" @call "%CMDER_ROOT%/vendor/git-for-windows/cmd/start-ssh-agent.cmd"
