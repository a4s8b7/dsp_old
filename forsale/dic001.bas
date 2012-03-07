clear screen
endflag = "no"
tries = 0
GeussX = 0
RandomX = 0

	input "Please state your name to start the game." n$
	print "Hello " + n$
	print "This is the,"
	print "Hi-Lo Game"
	print "By: Cody Morgan"
	print "I am thinking of a number between one and ten."
	
	// generate a random number between 1 and 10 and assign it to the variable named RandomX
	RandomX = ran(0 9)
	RandomX = RandomX + 1
	
	print "Take a guess and I will tell you if it is higher or lower."
	print "You have three tries, if you do not guess the correct answer, you lose."
	// Ask the user what he thinks the answer is with input and put in variable GeussX.

while(!endflag="no")
	input GeussX
		// See if what the user said is right.
		if GeussX > RandomX then
		     print "Sorry, the number is lower. You have ";tries; " more tries. Good luck."
		end if
		if GeussX < RandomX then
		     print "Sorry, the number is higher. You have ";tries; " more tries. Good luck."
		end if
		if GeussX > RandomX then print "You got it dude!"
		endflag = "yes"
		end if
		tries = tries + 1
		if tries > 3
			print "Sorry, you have run out of tries!"
			endflag = "yes"
		end if
wend

print "Thank you for Playing"
end	
	
	