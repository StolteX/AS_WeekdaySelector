B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
End Sub


Private Sub AS_WeekdaySelector1_WeekDayClicked(DayInWeek As Int,ClickState As Int)
	Select DayInWeek
		Case 1
			Log("Friday Clicked")
		Case 2
			Log("Thursday Clicked")
		Case 3
			Log("Wednesday Clicked")
		Case 4
			Log("Tuesday Clicked")
		Case 5
			Log("Monday Clicked")
		Case 6
			Log("Sunday Clicked")
		Case 7
			Log("Saturday Clicked")
	End Select
End Sub