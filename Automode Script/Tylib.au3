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

Func clickOffset($winName,$xOffset,$yOffset)
   ;;$winName: Windows name
   ;$xOffset: X coordinate in windows
   ;$yOffset:Y coordinate in window
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
   ;$winName: Windows name
   ;$xOffset: X coordinate in windows
   ;$yOffset:Y coordinate in window
   ;$mxOffset: After move X coordinate
   ;$myOffset:After move Y coordinate

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
			Run(@ComSpec & " /c " & '"C:\AutoTool\Start.bat"', "", @SW_HIDE)
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

 Func _SetWindowPos($hWnd, $x, $y) ;??API???????
 Local $cX, $cY
 Dim $hWndInsertAfter = -1
 Dim $wFlags = 1
 DllCall("user32.dll", "long", "SetWindowPos", "long", $hWnd, "long", $hWndInsertAfter, "long", $x,"long", $y, "long", $cX, "long", $cY, "long", $wFlags)
EndFunc