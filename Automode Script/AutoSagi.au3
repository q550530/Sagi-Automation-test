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
#include<Tylib.au3>
AutoItSetOption ("TrayIconDebug", 1);0-off
Local $Form1 = GUICreate("RFDS Automation Test", 615, 437, 192, 124)
Local $Button1 = GUICtrlCreateButton("Sagi Logain", 32, 32, 113, 49)
Local $Button2 = GUICtrlCreateButton("Leo Logain", 32, 104, 113, 49)
Local $Button3 = GUICtrlCreateButton("Auto burn in", 32, 174, 113, 49)
Local $Button5 = GUICtrlCreateButton("Eng'r Sainty test", 32, 244, 113, 49)



Local $Button4 = GUICtrlCreateButton("Test", 32, 370, 113, 49)


Local $Button8 = GUICtrlCreateButton("Coordinate maker", 490, 300, 113, 49)
Local $Button9 = GUICtrlCreateButton("Close Sagi", 490, 370, 113, 49)

;;install
Local $Label_1 = GUICtrlCreateLabel("Installer name", 232, 32, 100, 20)
Local $Input1 = GUICtrlCreateInput("Sagittarius_8.6.0.0", 312, 32, 130, 30)
Local $Button6= GUICtrlCreateButton("Lazy install", 490, 32, 113, 49)

GUISetState(@SW_SHOW)

Local $result

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		 Case $Button1  ;;Login Sagi
			ConnextSagi()

		 Case $Button2  ;Login Leo
			   Run("C:\Program Files (x86)\teCat\Leo\Components\LeoUI.exe")
			   ;Login
			   WinWaitActive("Leo Login")
			   ;Enter Account
			   ControlSetText("Leo Login", "", "[CLASS:Edit; INSTANCE:1]", "Leo")
			   ;Enter Password
			   ControlSetText("Leo Login", "", "[CLASS:Edit; INSTANCE:2]", "leo0829")

			   ControlClick ("Leo Login", "OK", "[CLASS:Button;INSTANCE:1]")


		 Case $Button3  ;Start Ebg
			Initialize()
			EnggStart()
			FocusWin("Sagittarius - Engineering Mode")
			clickOffset("Sagittarius - Engineering Mode","100","90") ;switch TestSpec tab
			Sleep(500)
			ControlClick("Sagittarius - Engineering Mode", "", "[CLASS:Button;INSTANCE:30]") ;Open Test Satus
			Sleep(500)

			;;;load testspec
			clickOffset("Sagittarius - Engineering Mode","90","694")
			Sleep(500)
			clickOffset("Sagittarius - Engineering Mode","90","750")
			FocusWin("Engineering Mode Setup")
			clickOffset("Engineering Mode Setup","50","100")
			Send("+b")
			Sleep(500)
			clickOffset("Engineering Mode Setup","50","250")
			Send("+b")
			ControlClick("Engineering Mode Setup", "OK", "[CLASS:Button;INSTANCE:1]")

			;;;;; set align and select wafer

			Sleep(1000)
			MouseClick("left", 1339, 500)
			FocusWin("Sagittarius - Prober Control")
			clickOffset("Sagittarius - Prober Control","160","90")
			Sleep(500)
			clickOffset("Sagittarius - Prober Control","160","280")
			FocusWin("Sagittarius - Assist")
			ControlClick("Sagittarius - Assist", "No", "[CLASS:Button;INSTANCE:2]")
			Sleep(500)
			clickOffset("Sagittarius - Prober Control","245","115")

			clickhold("Sagittarius - Prober Control","50","210","475","630")
			ControlClick("Sagittarius - Engineering Mode", "Test", "[CLASS:Button;INSTANCE:10]")

			For $g=0 To 1000 Step 1
			   $aPos=WinGetPos("Sagittarius - Engineering Mode")
			   $xScreen=$aPos[0]+838
			   $yScreen=$aPos[1]+93
			   $iColor = PixelGetColor($xScreen, $yScreen)
			   If Hex($iColor,6) ="FF0000" Then
				  $hwd=WinExists("Sagittarius - Engineering Mode")
				  _ScreenCapture_CaptureWnd("C:\Users\hsiao_tyrael\Desktop\RFDS_Tyrael\Devlope\Sagi-Automation test\Test.jpg", $hwd,0,0,1920,1080,False)
				  ExitLoop
			   EndIf
			   Sleep(15000)
			Next


		 Case $Button4 ;; function test button
			Local $inputValue
			$inputValue = GUICtrlRead($Input1)
			Run("C:\Users\hsiao_tyrael\Desktop\RFDS_Tyrael\exe\"& $inputValue &".exe")



		 Case $Button5 ;; Sainty test Eng'r mode
		 Run(@ComSpec & " /c " & '"C:\Users\hsiao_tyrael\Desktop\RFDS_Tyrael\Devlope\Sagi-Automation test\Enggmode.exe"', "", @SW_HIDE)


		 Case $Button6 ;; lazy install
			Local $inputValue
			$inputValue = GUICtrlRead($Input1)
			Run("C:\Users\hsiao_tyrael\Desktop\RFDS_Tyrael\exe\"& $inputValue &".exe")
			FocusWin("Sagittarius Installation")
			ControlClick("Sagittarius Installation", "Yes", "[CLASS:Button; INSTANCE:1]")
			FocusWin("Sagittarius uninstallation")
			ControlClick("Sagittarius uninstallation", "Yes", "[CLASS:Button; INSTANCE:1]")
			FocusWin("Remove shared file")
			ControlClick("Remove shared file", "Yes to all", "[CLASS:Button; INSTANCE:1]")
			Sleep(5000)
			FocusWin("Sagittarius uninstallation")
			ControlClick("Sagittarius uninstallation", "&Close", "[CLASS:Button; INSTANCE:1]")
			WinWaitActive("Sagittarius Installation")
			Send("!n")
			Sleep(2000)
			ControlClick("Sagittarius Installation","", "[CLASS:Button; INSTANCE:5]")
			Send("!n")
			Send("!i")
			Sleep(110000)
			WinWaitActive("Sagittarius Installation")
			clickOffset("Sagittarius Installation","425","460")

		 Case $Button8 ;Windows coordinate check

			$Pos=MouseGetPos()
			$var = PixelGetColor( $Pos[0] , $Pos[1])
			MsgBox(0, "Mouse x,y:", $Pos[0] & "," & $Pos[1])
			MsgBox(0,"The decimal color is", Hex($var, 6))


		 Case $Button9
			SagiKiller("SagiUI.exe")

	EndSwitch
 WEnd

