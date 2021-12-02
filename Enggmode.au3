#include-once
#Include <File.au3>
#include <GUIListBox.au3>
#include <GuiTreeView.au3>
#include <GuiConstantsEx.au3>
#Include <GuiListView.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ScreenCapture.au3>



Local $Form2 = GUICreate("Engg", 615, 437, 192, 124)
Local $ENGGButton1 = GUICtrlCreateButton("1", 32, 32, 113, 49)


GUISetState(@SW_SHOW)

Local $result

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		 Case $ENGGButton1  ;;Login Sagi

			Run(@ComSpec & " /c " & '"D:\Start.bat"', "", @SW_HIDE)
			   ;Update note message




			   If WinExists("Sagittarius - Assist","") Then
				  WinWaitActive("Sagittarius - Assist")
				  ControlClick ("Sagittarius - Assist", "No", "[CLASS:Button;INSTANCE:2]")
			   EndIf
			;shellExecute("C:\Program Files (x86)\STAr\Sagittarius\Components\SagiUI.exe")

			   ;WinWaitActive("Sagittarius - Assist")
			   ;ControlClick ("Sagittarius - Assist", "Yes", "[CLASS:Button; TEXT:Yes; INSTANCE:1]")

			   ;Login
			   WinWaitActive("Sagittarius Login")
			   ;Enter Account
			   ControlSetText("Sagittarius Login", "", "[CLASS:Edit; INSTANCE:1]", "STAr")
			   ;Enter Password
			   ControlSetText("Sagittarius Login", "", "[CLASS:Edit; INSTANCE:2]", "star0829")

			   ControlClick ("Sagittarius Login", "OK", "[CLASS:Button;INSTANCE:1]")


	EndSwitch
 WEnd
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;副程式;;;;;;;;;;

