﻿B4A=true
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
	Private AS_WeekdaySelector1 As AS_WeekdaySelector
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	

	
End Sub


Private Sub AS_WeekdaySelector1_WeekDayClicked(WeekDay As AS_WeekdaySelector_WeekDay,ClickState As Int)
	Log($"${WeekDay.WeekNameLong} on ${DateTime.Date(WeekDay.Date)} Clicked"$)
End Sub

Private Sub AS_WeekdaySelector2_WeekDayClicked(WeekDay As AS_WeekdaySelector_WeekDay,ClickState As Int)
	Log($"${WeekDay.WeekNameLong} on ${DateTime.Date(WeekDay.Date)} Clicked"$)
End Sub