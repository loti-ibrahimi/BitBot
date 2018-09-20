' define some constants to use for speed. Note that the boe-bot
' moves forward with left and right being opposite numbers (due
' to the flipping of the servos as part of the robot construction
'-----------------------------------------------------------------------------------------------
left_speed = 160
right_speed = 160
rev_left_speed = 90
rev_right_speed = 90
left_stopped = 128
right_stopped = 130
'-----------------------------------------------------------------------------------------------

'''' Get Box (x,y) and Person (x,y) values '''''''
		boxX = GetFloatVariable("box_x")
		boxY = GetFloatVariable("box_y")
		
		personX = GetFloatVariable("person_x")
		personY = GetFloatVariable("person_y")
		
		robotX = GetFloatVariable("robot_x")
		robotY = GetFloatVariable("robot_y")
		
		'------------------------------------------------'
		
		'''' Using the midpoint formula ''''
		'' Step:1 ''
		'(followpoint_x + personX)/2 = boxX
		'(followpoint_y + personY)/2 = boxY
		
		'' Step:2 - Simplified'' 
		'followpoint_x + personX = 2*boxX 
		'followpoint_y + personY = 2*boxY

		'' Step:3 - final form, simplified:''
		followpoint_x = (2*boxX) - (personX)
		followpoint_y = (2*boxY) - (personY)
		
		SetVariable "followpointX", followpoint_x
		SetVariable "followpointY", followpoint_y
		
		
		''' Length of white line vector, i.e between person & box '''
		WL_length = Sqr((Abs(boxX - personX) ^ 2) + (Abs(boxY - personY) ^ 2))
		setVariable "Whiteline_Length", WL_length
		
		followpointx = GetFloatVariable("followpointX")
		followpointy = GetFloatVariable("followpointY")
		
		''' Length of orange line vector, i.e between bot & followpoint '''
		WLT_length = Sqr((Abs(robotX - followpointx) ^ 2) + (Abs(robotY - followpointy) ^ 2))	
		setVariable "WhiteLineThin_Length", WLT_length
		
		
'----------------------------------------------------------------------------------------
' check to see if we are running.
' <> means NOT
'----------------------------------------------------------------------------------------

			' this is the orientation produced by the path_planning and the
			' orientation we want the robot to be at
			desiredOrientation = GetVariable("plan_orientation")

if GetVariable("interface_run") <> "1" or desiredOrientation = "-1" then

   SetVariable "left_motor", left_stopped
   SetVariable "right_motor", right_stopped
									
else
		'get the current robot orientation
			robotOrientation = GetVariable("robot_orientation")
			
		' 40 degree line-up
		robotOrientation = CInt((robotOrientation / 40) ) * 40
		desiredOrientation = CInt((desiredOrientation / 40) ) * 40
		
		' calculate the different between the two angles
		diff = abs(desiredOrientation - robotOrientation )
		
		' if they are the same (within 40 degrees) just move forward
if desiredOrientation = robotOrientation then

  SetVariable "left_motor", left_speed
  SetVariable "right_motor", right_speed

	' otherwise turn in the appropriate direction. Note the use of 180 testing to determine which turn direction would be fastest.
	' This allows the robot to turn in the most efficient direction
elseif desiredOrientation > robotOrientation and diff < 180 or _
  desiredOrientation < robotOrientation and diff >= 180 then

  SetVariable "left_motor", rev_left_speed
  SetVariable "right_motor", right_speed

else

  ' if we don't turn one way then default to the other
  SetVariable "left_motor", left_speed
  SetVariable "right_motor", rev_right_speed

end if

end if ' interface_pause

'-----------------------------------------------------------------------------------------		

' variables left_motor and right_motor now contain the motor
' movements.
'-------------------------------------------------------------------------------------------

