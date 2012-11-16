#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.8.1
	Author:         2quader <2quader@myopera.com>

	Script Function:
	Disable/Enable W8-Lockscreen

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

AutoItSetOption("TrayIconHide", 1)

If @OSVersion <> "WIN_8" Then
	MsgBox(0, "Disable8Lock", "WIN_8 is required!")
	Exit
EndIf

if MsgBox(65, "Disable8Lock", "Disable8Lock is provided as is." & @CRLF & "Use at your own risk.") <> 1 Then
	Exit
EndIf


#region ### START Koda GUI section ### Form=C:\Temp\disable8lock\frmMain.kxf
$frmMain = GUICreate("Disable8Lock", 238, 118, 192, 154)
$lblInfo = GUICtrlCreateLabel("Disable8Lock by 2quader", 8, 8, 183, 24)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
$lblStatus = GUICtrlCreateLabel("Lockscreen is enabled.", 8, 32, 114, 17)
$btnAction = GUICtrlCreateButton("Disable", 8, 56, 219, 25)
$btnInfo = GUICtrlCreateButton("http://github.com/2quader/Disable8Lock", 8, 80, 219, 25)
GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###

Func updateLabels()
	$info = RegRead("HKLM\Software\Policies\Microsoft\Windows\Personalization", "NoLockScreen")
	Switch $info
		Case 1
			GUICtrlSetData($lblStatus, "Lockscreen is disabled.")
			GUICtrlSetData($btnAction, "Enable")
		Case Else
			GUICtrlSetData($lblStatus, "Lockscreen is enabled.")
			GUICtrlSetData($btnAction, "Disable")
	EndSwitch
	Return $info
EndFunc   ;==>updateLabels

$info = updateLabels()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnAction
			Switch $info
				Case 1
					RegWrite("HKLM\Software\Policies\Microsoft\Windows\Personalization", "NoLockScreen", "REG_DWORD", 0)
				Case Else
					RegWrite("HKLM\Software\Policies\Microsoft\Windows\Personalization", "NoLockScreen", "REG_DWORD", 1)
			EndSwitch
			$info = updateLabels()
		Case $btnInfo
			ShellExecute("http://github.com/2quader/Disable8Lock")
	EndSwitch
WEnd