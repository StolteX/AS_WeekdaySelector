B4i=true
Group=Views
ModulesStructureVersion=1
Type=Class
Version=8.3
@EndOfDesignText@

#DesignerProperty: Key: FirstDayOfWeek, DisplayName: First Day of Week, FieldType: String, DefaultValue: Monday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
#DesignerProperty: Key: HeaderText, DisplayName: HeaderText, FieldType: String, DefaultValue: WeekDay, List: WeekDay|DayOfMonth|None
#DesignerProperty: Key: BodyText, DisplayName: BodyText, FieldType: String, DefaultValue: DayOfMonth, List: WeekDay|DayOfMonth|None
#DesignerProperty: Key: ClickAmount, DisplayName: ClickAmount, FieldType: Int, DefaultValue: 2, MinRange: 1, MaxRange: 2, Description: Note that MinRange and MaxRange are optional.
#DesignerProperty: Key: NormalColor, DisplayName: NormalColor, FieldType: Color, DefaultValue: 0xFF343434, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: FirstClickColor, DisplayName: FirstClickColor, FieldType: Color, DefaultValue: 0x642D8879, Description: You can use the built-in color picker to find the color values.
#DesignerProperty: Key: SecondClickColor, DisplayName: SecondClickColor, FieldType: Color, DefaultValue: 0xFF2D8879, Description: You can use the built-in color picker to find the color values.

#DesignerProperty: Key: HeaderTextColor, DisplayName: HeaderTextColor, FieldType: Color, DefaultValue: 0x87FFFFFF
#DesignerProperty: Key: BodyTextColor, DisplayName: BodyTextColor, FieldType: Color, DefaultValue: 0xFFFFFFFF

#Event: WeekDayClicked(DayInWeek As Int,ClickState As Int)

Sub Class_Globals
	
	Type AS_WeekdaySelector_WeekNameShort(Monday As String,Tuesday As String,Wednesday As String,Thursday As String,Friday As String,Saturday As String,Sunday As String)
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Private g_WeekNameShort As AS_WeekdaySelector_WeekNameShort
	Private m_WeekNameShortList As List
	
	Private xpnl_Background As B4XView
	
	Private m_HeaderText As String
	Private m_BodyText As String
	Private m_FirstDayOfWeek As Int
	Private m_NormalColor As Int
	Private m_FirstClickColor As Int
	Private m_SecondClickColor As Int
	Private m_HeaderTextColor As Int
	Private m_BodyTextColor As Int
	Private m_Week As Long
	Private m_ClickAmount As Int
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	m_WeekNameShortList.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
  
	IniProps(Props)
  
	xpnl_Background = xui.CreatePanel("")
	mBase.AddView(xpnl_Background,0,0,mBase.Width,mBase.Height)
  
	Dim tmpList As List = GenerateWeekDayList
  
	Dim HeaderHeight As Float = IIf(m_HeaderText = "None",0,20dip)
	Dim WeekDayHeight As Float = 40dip
	Dim GapBetween As Float = 5dip
  
	For i = 0 To tmpList.Size -1
		
		Dim xpnl_WeekDayBackground As B4XView = xui.CreatePanel("")
		xpnl_Background.AddView(xpnl_WeekDayBackground,(mBase.Width/7)*i,0,mBase.Width/7,mBase.Height)
		xpnl_WeekDayBackground.Tag = tmpList.Get(i)
		Dim xlbl_HeaderText As B4XView = CreateLabel("")
		xpnl_WeekDayBackground.AddView(xlbl_HeaderText,0,0,xpnl_WeekDayBackground.Width,HeaderHeight)
		
		xlbl_HeaderText.TextColor = m_HeaderTextColor
		xlbl_HeaderText.SetTextAlignment("CENTER","CENTER")
		xlbl_HeaderText.Font = xui.CreateDefaultFont(14)
		
		Dim xlbl_WeekDay As B4XView = CreateLabel("xlbl_WeekDay")
		xpnl_WeekDayBackground.AddView(xlbl_WeekDay,xpnl_WeekDayBackground.Width/2 - WeekDayHeight/2,IIf(m_HeaderText = "None",xpnl_WeekDayBackground.Height/2-WeekDayHeight/2,HeaderHeight + GapBetween),WeekDayHeight,WeekDayHeight)
		xlbl_WeekDay.Text = m_WeekNameShortList.Get(tmpList.Get(i)-1)
		xlbl_WeekDay.TextColor = m_BodyTextColor
		xlbl_WeekDay.SetTextAlignment("CENTER","CENTER")
		xlbl_WeekDay.Font = xui.CreateDefaultBoldFont(15)
		xlbl_WeekDay.SetColorAndBorder(m_NormalColor,0,0,xlbl_WeekDay.Height/2)
		xlbl_WeekDay.Tag = 0
		
		Select m_HeaderText
			Case "None"
				xlbl_HeaderText.Text = ""
			Case "WeekDay"
				xlbl_HeaderText.Text = m_WeekNameShortList.Get(tmpList.Get(i)-1)
			Case "DayOfMonth"
				xlbl_HeaderText.Text = DateTime.GetDayOfMonth(GetFirstDayOfWeek(m_Week,m_FirstDayOfWeek)+DateTime.TicksPerDay*i)
		End Select
		
		Select m_BodyText
			Case "None"
				xlbl_WeekDay.Text = ""
			Case "WeekDay"
				xlbl_WeekDay.Text = m_WeekNameShortList.Get(tmpList.Get(i)-1)
			Case "DayOfMonth"
				xlbl_WeekDay.Text = DateTime.GetDayOfMonth(GetFirstDayOfWeek(m_Week,m_FirstDayOfWeek)+DateTime.TicksPerDay*i)
		End Select
		
	Next
  
End Sub

#IF B4J
Private Sub xlbl_WeekDay_MouseClicked (EventData As MouseEvent)
#Else
Private Sub xlbl_WeekDay_Click
#End If
	Dim xlbl_WeekDay As B4XView = Sender
	If xlbl_WeekDay.Tag.As(Int) = 0 Then
		xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_FirstClickColor)
		xlbl_WeekDay.Tag = 1
	else If xlbl_WeekDay.Tag.As(Int) = 1 And m_ClickAmount = 2 Then
		xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_SecondClickColor)
		xlbl_WeekDay.Tag = 2
	Else
		xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_NormalColor)
		xlbl_WeekDay.Tag = 0
	End If
End Sub

Public Sub Clear
	For i = 0 To xpnl_Background.NumberOfViews -1
		Dim xlbl_WeekDay As B4XView = xpnl_Background.GetView(i).GetView(1)
		xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_NormalColor)
		xlbl_WeekDay.Tag = 0
	Next
End Sub

Public Sub SelectWeekDay(WeekDay As Int)
	For i = 0 To xpnl_Background.NumberOfViews -1
		If WeekDay = xpnl_Background.GetView(i).Tag Then
			Dim xlbl_WeekDay As B4XView = xpnl_Background.GetView(i).GetView(1)
			xlbl_WeekDay.SetColorAnimated(250,xlbl_WeekDay.Color,m_FirstClickColor)
			xlbl_WeekDay.Tag = 1
			Exit
		End If
	Next
End Sub

Public Sub getSelectedWeekDays As List
	Dim lst_WeekDays As List
	lst_WeekDays.Initialize
	For i = 0 To xpnl_Background.NumberOfViews -1
		If 1 = xpnl_Background.GetView(i).GetView(1).tag Or 2 = xpnl_Background.GetView(i).GetView(1).tag Then
			lst_WeekDays.Add(xpnl_Background.GetView(i).Tag)
		End If
	Next
	Return lst_WeekDays
End Sub

Private Sub GenerateWeekDayList As List

'	m_FirstDayOfWeek = 5
'
	Dim tmpList As List
	tmpList.Initialize

	For i = m_FirstDayOfWeek To 1 Step -1
		tmpList.Add(i)
	Next

	If m_FirstDayOfWeek < 7 Then
		For i  = 7 To (m_FirstDayOfWeek+1) Step -1
			tmpList.Add(i)
		Next
	End If

	Return tmpList

End Sub

Private Sub IniProps(Props As Map)
	
	m_Week = DateTime.Now
	m_HeaderText = Props.Get("HeaderText")
	m_BodyText = Props.Get("BodyText")
	m_ClickAmount = Props.Get("ClickAmount")

	m_NormalColor = xui.PaintOrColorToColor(Props.Get("NormalColor"))
	m_FirstClickColor = xui.PaintOrColorToColor(Props.Get("FirstClickColor"))
	m_SecondClickColor = xui.PaintOrColorToColor(Props.Get("SecondClickColor"))
	m_HeaderTextColor = xui.PaintOrColorToColor(Props.Get("HeaderTextColor"))
	m_BodyTextColor = xui.PaintOrColorToColor(Props.Get("BodyTextColor"))

	If "Friday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 1
	else If "Thursday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 2
	else If "Wednesday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 3
	else If "Tuesday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 4
	else If "Monday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 5
	else If "Sunday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 6
	else If "Saturday" = Props.Get("FirstDayOfWeek") Then
		m_FirstDayOfWeek = 7
	End If
	
	g_WeekNameShort = CreateAS_WeekdaySelector_WeekNameShort("Mon","Tue","Wed","Thu","Fri","Sat","Sun")
	RefreshWeekNameShort
End Sub

Private Sub RefreshWeekNameShort
	m_WeekNameShortList.Clear
	m_WeekNameShortList.Add(g_WeekNameShort.Friday)
	m_WeekNameShortList.Add(g_WeekNameShort.Thursday)
	m_WeekNameShortList.Add(g_WeekNameShort.Wednesday)
	m_WeekNameShortList.Add(g_WeekNameShort.Tuesday)
	m_WeekNameShortList.Add(g_WeekNameShort.Monday)
	m_WeekNameShortList.Add(g_WeekNameShort.Sunday)
	m_WeekNameShortList.Add(g_WeekNameShort.Saturday)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
  
End Sub

#Region Events

Private Sub WeekDayClicked(DayInWeek As Int,ClickState As Int)'Ignore
	If xui.SubExists(mCallBack, mEventName & "_WeekDayClicked", 2) Then
		CallSub3(mCallBack, mEventName & "_WeekDayClicked",DayInWeek,ClickState)
	End If
End Sub

#End Region

#Region Functions

'FirstDayOfWeek:
'Friday = 1
'Thursday = 2
'Wednesday = 3
'Tuesday = 4
'Monday = 5
'Sunday = 6
'Saturday = 7
Public Sub GetFirstDayOfWeek(Ticks As Long,FirstDayOfWeek As Int) As Long
	Dim p As Period
	p.Days = -((DateTime.GetDayOfWeek(Ticks)+FirstDayOfWeek) Mod 7) 'change to 5 to start the week from Monday
	Return DateUtils.AddPeriod(Ticks, p)
End Sub

#End Region

Private Sub CreateLabel(EventName As String) As B4XView
	Dim lbl As Label
	lbl.Initialize(EventName)
	Return lbl
End Sub

Public Sub CreateAS_WeekdaySelector_WeekNameShort (Monday As String, Tuesday As String, Wednesday As String, Thursday As String, Friday As String, Saturday As String, Sunday As String) As AS_WeekdaySelector_WeekNameShort
	Dim t1 As AS_WeekdaySelector_WeekNameShort
	t1.Initialize
	t1.Monday = Monday
	t1.Tuesday = Tuesday
	t1.Wednesday = Wednesday
	t1.Thursday = Thursday
	t1.Friday = Friday
	t1.Saturday = Saturday
	t1.Sunday = Sunday
	Return t1
End Sub