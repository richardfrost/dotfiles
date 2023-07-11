# I'm only using standard right now
#
# Old regs
# "Disable-Shortcut_Text",
# "Enable-Context_Menu_Actions-Additional",
# "Disable-Internet_Open_With",
# "Add-Open_With_Notepad-Icon",
# "Add-VBS_as_Administrator",
# "Add-Open_Command_Window_Here-Admin-Expanded",
# "Add-Open_Command_Window_Here-Icon-Expanded",
# "Add-Open_PowerShell_Here-Icon-Expanded",
# "Add-Copy_TXT_To_Clipboard",
# "Add-Desktop_Power_Sub_Menu",
# "Add-Desktop_Run",

$standard = @(
    "Add-Take_Ownership-Expanded",
    "Disable-Aero_Shake",
    "Disable-Hide_File_Extensions",
    "Disable-Quick_Access_Show_Frequent_Folders",
    "Disable-Quick_Access_Show_Recent_Files",
    "Disable-Start_Menu_Recommended",
    "Enable-Explorer_This_PC",
    "Run"
)

$expanded = @(
    "Add-Copy_TXT_To_Clipboard",
    "Add-Desktop_Power_Sub_Menu",
    "Add-Desktop_Run",
    "Add-Open_Command_Window_Here-Admin",
    "Add-Open_Command_Window_Here-Icon",
    "Add-Open_PowerShell_Here-Icon",
    "Add-Open_With_Notepad-Icon",
    "Add-Take_Ownership",
    "Add-VBS_as_Administrator",
    "Disable-Aero_Shake",
    "Disable-Hide_File_Extensions",
    "Disable-Internet_Open_With",
    "Disable-Quick_Access_Show_Frequent_Folders",
    "Disable-Quick_Access_Show_Recent_Files",
    "Disable-Shortcut_Text",
    "Disable-Show_snap_groups_in_taskbar_Alt-Tab_Task-View"
    "Disable-Start_Menu_Recommended",
    "Enable-Context_Menu_Actions-Additional",
    "Enable-Explorer_This_PC",
    "Enable-Show_Seconds_On_System_Tray_Clock",
    "Run"
)

$revert = @(
    "Clear-Run",
    "Default-Aero_Shake",
    "Default-Context_Menu_Actions",
    "Default-Explorer_Quick_Access",
    "Default-Hide_File_Extensions",
    "Default-Internet_Open_With",
    "Default-No_Seconds_On_System_Tray_Clock",
    "Default-Quick_Access_Show_Frequent_Folders",
    "Default-Quick_Access_Show_Recent_Files",
    "Default-Shortcut_Text",
    "Default-Show_snap_groups_in_taskbar_Alt-Tab_Task-View",
    "Default-Start_Menu_Recommended",
    "Remove-Copy_TXT_To_Clipboard",
    "Remove-Desktop_Power_Sub_Menu",
    "Remove-Desktop_Run",
    "Remove-Open_Command_Window_Here-Admin",
    "Remove-Open_Command_Window_Here",
    "Remove-Open_With_Notepad",
    "Remove-Take_Ownership",
    "Remove-VBS_as_Administrator"
)

# https://stackoverflow.com/questions/28076128/powershell-export-multiple-keys-to-one-reg-file
function Compile-RegistryKeys
{
    Param
    (
        [Parameter(Mandatory=$true)][array] $regs,
        [Parameter(Mandatory=$true)][array] $name
    )

    $outputFile = "$PSScriptRoot\$name.reg"

    'Windows Registry Editor Version 5.00' | Set-Content $outputFile

    foreach ($reg in $regs) {
      Get-Content "$PSScriptRoot\library\$reg.reg" | ? {
        $_ -ne 'Windows Registry Editor Version 5.00'
      } | Add-Content $outputFile
    }
}

Compile-RegistryKeys -regs $standard -name "standard"
Compile-RegistryKeys -regs $expanded -name "expanded"
Compile-RegistryKeys -regs $revert -name "revert"
