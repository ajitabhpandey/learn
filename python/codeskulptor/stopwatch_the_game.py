# "Stopwatch: The Game"
# Ajitabh (http://ajitabhpandey.info/)
# Only works in CodeSkulptor (http://www.codeskulptor.org)
# http://www.codeskulptor.org/#user40_3qDdk0oitm_1.py

import simplegui

# define global variables
counter = 0
tries = 0
wins = 0
last_stop = 0

##
### helper functions
##
# format function converts time in tenths of seconds into 
# formatted string A:BC.D
def format():
    global counter
    a = counter // 600
    b = ((counter//100)%6)
    c = (counter//10)%10
    d = counter%10
    return str(a) + ":" + str(b) + str(c) + "." + str(d)

# update_score function updates the score on the canvas
def update_score():
    global tries
    global wins
    return str(wins) + " wins / " + str(tries) + " tries"
    
# define event handlers for buttons; "Start", "Stop", "Reset"
def btn_start_event():
    timer.start()
    
def btn_stop_event():
    global tries
    global wins
    global last_stop
    timer.stop()
    if counter != last_stop:
        tries += 1
        last_stop = counter
        if counter%10 == 0:
                wins += 1
    update_score() 
    
def btn_reset_event():
    global counter
    global tries
    global wins
    global last_stop
    timer.stop()
    counter = 0
    wins = 0
    tries = 0
    last_stop = 0

# define event handler for timer with 0.1 sec interval
def timer_handler():
    global counter
    counter += 1
    return counter

# define draw handler
def draw_event(canvas):
    canvas.draw_text(format(), (90, 160), 40, "Orange")
    canvas.draw_text(update_score(), (165, 30), 20, "Red")
    
# create frame
frame = simplegui.create_frame("Stopwatch: The Game", 300, 300)

# register event handlers
timer = simplegui.create_timer(100, timer_handler)
frame.set_draw_handler(draw_event)
start_button = frame.add_button("Start", btn_start_event, 40)
stop_button = frame.add_button("Stop", btn_stop_event, 40)
reset_button3 = frame.add_button("Reset", btn_reset_event, 40)

# start frame
frame.start()

