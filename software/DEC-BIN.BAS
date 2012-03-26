
'XXX = data
'do while XXX == 0
'	select case XXX'
'		case is > 128 then
'			bit(8) = 1
'			XXX = XXX - 128
'		case is > 64 then
'			bit(7) = 1
'			XXX = XXX - 64
'
'		case is > 32 then
'			bit(6) = 1
'			XXX = XXX - 32
'
'		case is > 16 then
'			bit(5) = 1
'			XXX = XXX - 16
'
'		case is > 8 then
'			bit(4) = 1
'			XXX = XXX - 8
'
'		case is > 4 then
'			bit(3) = 1
'			XXX = XXX - 4
'
'		case is > 2 then
'			bit(2) = 1
'			XXX = XXX - 2
'
'		case is > 1 then
'			bit(1) = 1
'			XXX = XXX - 1
'	end select
'loop
