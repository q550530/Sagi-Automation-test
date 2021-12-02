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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;副程式;;;;;;;;;;

;click corrdinate of window
Func clickOffset($winName,$xOffset,$yOffset)
   ;$winName:視窗名稱。
   ;$xOffset:相對於視窗原點的x軸偏移量
   ;$yOffset:相對於視窗原點的y軸偏移量
   $aPos=WinGetPos($winName)
   $xScreen=$aPos[0]+$xOffset
   $yScreen=$aPos[1]+$yOffset
   MouseClick("left", $xScreen, $yScreen)
EndFunc

Func _GetPosColor($winName,$xOffset,$yOffset)

   $aPos=WinGetPos($winName)
   $xScreen=$aPos[0]+$xOffset
   $yScreen=$aPos[1]+$yOffset
   $iColor = PixelGetColor($xScreen, $yScreen)


EndFunc
Func _GetWinOnTop($winName)
    ; Retrieve the handle of the active window.
    Local $hWnd = WinGetHandle($winName)

    ; Set the active window as being ontop using the handle returned by WinGetHandle.
    WinSetOnTop($hWnd, "", $WINDOWS_ONTOP)




EndFunc

Func clickhold($winName,$xOffset,$yOffset,$mxOffset,$myOffset)
   ;$winName:視窗名稱。
   ;$xOffset:相對於視窗原點的x軸偏移量
   ;$yOffset:相對於視窗原點的y軸偏移量
   ;$mxOffset:相對於視窗原點移動後的x軸偏移量
   ;$myOffset:相對於視窗原點移動後的y軸偏移量

   $aPos=WinGetPos($winName)
   $xScreen=$aPos[0]+$xOffset
   $yScreen=$aPos[1]+$yOffset
   $x2Screen=$aPos[0]+$mxOffset
   $y2Screen=$aPos[1]+$myOffset

   MouseMove($xScreen, $yScreen, 50)
   MouseClick("left", $xScreen, $yScreen, 2)
   ;Left click hold
   Sleep(500)
   MouseDown($MOUSE_CLICK_LEFT)
   MouseMove($x2Screen, $y2Screen, 30)
   Sleep(500)
   MouseUp($MOUSE_CLICK_LEFT)

EndFunc

;Start Sagi
Func ConnextSagi()
   ;Run("C:\Program Files (x86)\STAr\Sagittarius\Components\SagiUI.exe")
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


EndFunc

;Focus for windows and wait
Func FocusWin($winNe)

   Local $hWnd = WinWait($winNe, "", 10)
   WinWaitActive($hWnd)

EndFunc

;Star Eng'r mode with Control panel
Func EnggStart()
   FocusWin("STAr Sagittarius - Control Panel")
   clickOffset("STAr Sagittarius - Control Panel","210","105")
EndFunc

;just initialize
Func Initialize()
   clickOffset("Sagittarius - Hardware Detection and Configuration","380","580")
   Sleep(1500)
   clickOffset("Sagittarius - Hardware Detection and Configuration","595","580")
   Sleep(1000)

EndFunc
; lazy closed
Func SagiKiller($sPID)
    If IsString($sPID) Then $sPID = ProcessExists($sPID)
    If Not $sPID Then Return SetError(1, 0, 0)

    Return Run(@ComSpec & " /c taskkill /F /PID " & $sPID & " /T", @SystemDir, @SW_HIDE)
 EndFunc

 Func _SetWindowPos($hWnd, $x, $y) ;使用API将窗体保持最前
 Local $cX, $cY
 Dim $hWndInsertAfter = -1
 Dim $wFlags = 1
 DllCall("user32.dll", "long", "SetWindowPos", "long", $hWnd, "long", $hWndInsertAfter, "long", $x,"long", $y, "long", $cX, "long", $cY, "long", $wFlags)
EndFunc
