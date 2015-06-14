# "Guess the number" mini-project
# input will come from buttons and an input field
# all output for the game will be printed in the console
# Only works in CodeSkulptor (http://www.codeskulptor.org)
# http://www.codeskulptor.org/#user40_CzwGML3bZe_4.py

import simplegui
import random

# define global variables
secret_number = 0
count = 0
last_selected = 0

# helper function to start and restart the game
def new_game():
    # initialize global variables used in your code here
    global secret_number, count, last_selected
    if last_selected == 100:
        print "Starting new game, last selected range (0-100)"
        count = 7
        secret_number = random.randrange(0,100)
    elif last_selected == 1000:
        print "Starting new game, last selected range (0-1000)"
        count = 10
        secret_number = random.randrange(0,1000)
    else:
        # Default the range is 0-100
        print "Starting new game, default range (0-100)"
        count = 7
        secret_number = random.randrange(0,100)


# define event handlers for control panel
def range100():
    # button that changes the range to [0,100] and starts a new game 
    global count, last_selected
    
    count = 7
    last_selected = 100
    
    # start a new game
    new_game()

def range1000():
    # button that changes the range to [0,1000] and starts a new game     
    global count, last_selected
    
    count = 10
    last_selected = 1000
    
    # start a new game
    new_game()
    
def input_guess(guess):
    # main game logic goes here
    global count
    
    # Reducing the max count by 1
    count -= 1
    print "Guess was",guess
    
    # convert input to integer
    iguess = int(guess)
    
    # Allow the user to continue for maximum allowed counts
    if iguess < secret_number:
        print "Lower"
    elif iguess > secret_number:
        print "Higher"
    elif iguess == secret_number:
        print "Correct"
        # start a new game
        new_game()
    else:
        print "Strange this should not come here"
        
    if count > 0:        
        print "Remaining guesses",count
    else:
        print "You ran out of max attempts. The secret number is", secret_number
        # start a new game
        new_game()
    
# create frame
frame = simplegui.create_frame('Testing', 200, 200)

# register event handlers for control elements and start frame
guess = frame.add_input('Guess', input_guess, 50)
range_100 = frame.add_button("Range: 0 - 100",range100)
range_1000 = frame.add_button("Range: 0 - 1000", range1000)

frame.start()

# call new_game 
new_game()
