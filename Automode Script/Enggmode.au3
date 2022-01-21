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
#include <Tylib.au3>


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

			EnggStart()


	EndSwitch
 WEnd
