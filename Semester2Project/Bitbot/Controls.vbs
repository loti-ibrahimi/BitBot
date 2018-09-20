' the programme translates the joystick range of -1000 - 1000 to 0 - 255

' amount of y joystick determines speed 
speed = 128 - CInt(((GetVariable("joy_y") * 128) / 1000))
' amount of x joystick determines rotation
turn = CInt(((GetVariable("joy_x") * 128) / 1000))

' determine intermediate values
mleft = speed + turn
mright = speed - turn

'ensure they are within the range 40 - 165
if mleft<40 then mleft=40
if mright<40 then mright=40 
if mleft>165 then mleft=165
if mright>165 then mright=165


Lock = GetVariable("lock")
LeftLock = GetVariable("left_lock") 
RightLock = GetVariable("right_lock")

if (Lock = 1) then mleft = 126
if (Lock = 1) then mright = 132
if (LeftLock = 1) then mleft = 126
if (RightLock = 1) then mright = 132

SetVariable "lock", Lock
SetVariable "left_lock", LeftLock
SetVariable "right_lock", RightLock

' finally set the variables to be used in the joystick module
SetVariable "left_motor", mleft
SetVariable "right_motor", mright


