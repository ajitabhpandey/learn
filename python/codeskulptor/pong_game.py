# Implementation of classic arcade game Pong
# More information about this game - 
# https://en.wikipedia.org/wiki/Pong
# http://www.ponggame.org
# Ajitabh
# Only works in CodeSkulptor (http://www.codeskulptor.org)
# http://www.codeskulptor.org/#user40_j3wEnLiWS2_3.py

import simplegui
import random

# initialize globals - pos and vel encode vertical info for paddles
WIDTH = 600
HEIGHT = 400       
BALL_RADIUS = 20
PAD_WIDTH = 8
PAD_HEIGHT = 80
HALF_PAD_WIDTH = PAD_WIDTH / 2
HALF_PAD_HEIGHT = PAD_HEIGHT / 2
LEFT = False
RIGHT = True

# current direction
direction = RIGHT

# ball position and velocity
ball_pos = [WIDTH / 2, HEIGHT / 2]
ball_vel = [40.0 / 60.0,  5.0 / 60.0]

# paddle position and velocity
paddle1_pos = HEIGHT / 2 - HALF_PAD_HEIGHT
paddle1_vel = 0

paddle2_pos = HEIGHT / 2 - HALF_PAD_HEIGHT
paddle2_vel = 0

# maintains score
score1 = 0
score2 = 0

# initialize ball_pos and ball_vel for new bal in middle of table
# if direction is RIGHT, the ball's velocity is upper right, else upper left
def spawn_ball(direction):
    global ball_pos, ball_vel # these are vectors stored as lists
    ball_pos = [WIDTH / 2, HEIGHT / 2]
    if direction == RIGHT:
        ball_vel = [ random.randrange(120, 240) / 60.0, - random.randrange(60, 180) / 60.0 ]
    
    if direction == LEFT:
        ball_vel = [- random.randrange(120, 240) / 60.0, - random.randrange(60, 180) / 60.0 ]



# define event handlers
def new_game():
    global paddle1_pos, paddle2_pos, paddle1_vel, paddle2_vel  # these are numbers
    global score1, score2  # these are ints
    global direction
    score1 = 0
    score2 = 0
    spawn_ball(direction)
    
    
def draw(canvas):
    global score1, score2, paddle1_pos, paddle2_pos, ball_pos, ball_vel
 
        
    # draw mid line and gutters
    canvas.draw_line([WIDTH / 2, 0],[WIDTH / 2, HEIGHT], 1, "White")
    canvas.draw_line([PAD_WIDTH, 0],[PAD_WIDTH, HEIGHT], 1, "White")
    canvas.draw_line([WIDTH - PAD_WIDTH, 0],[WIDTH - PAD_WIDTH, HEIGHT], 1, "White")
        
    # update ball
    ball_pos[0] += ball_vel[0]
    ball_pos[1] += ball_vel[1]
            
    # draw ball
    canvas.draw_circle(ball_pos, BALL_RADIUS, 2, "White", "White")
 
    # bounce top and bottom 
    if ball_pos[1] <= BALL_RADIUS:
        ball_vel[1] = - ball_vel[1]
        
    if ball_pos[1] >= (HEIGHT - 1) - BALL_RADIUS:
        ball_vel[1] = - ball_vel[1]

    # update paddle's vertical position, keep paddle on the screen
    if paddle1_pos + paddle1_vel >= 0 and paddle1_pos + paddle1_vel <= HEIGHT - PAD_HEIGHT:
        paddle1_pos += paddle1_vel
    
    if paddle2_pos + paddle2_vel >= 0 and paddle2_pos + paddle2_vel <= HEIGHT - PAD_HEIGHT:
        paddle2_pos += paddle2_vel

    # draw paddles
    canvas.draw_line([HALF_PAD_WIDTH,0 + paddle1_pos],[HALF_PAD_WIDTH,PAD_HEIGHT + paddle1_pos],8,"White")
    canvas.draw_line([WIDTH - HALF_PAD_WIDTH,0 + paddle2_pos],[WIDTH - HALF_PAD_WIDTH,PAD_HEIGHT + paddle2_pos],8,"White")

    # determine whether paddle and ball collide    
        if ball_pos[0] <= BALL_RADIUS + PAD_WIDTH:
        if ball_pos[1] >= paddle1_pos and ball_pos[1] <= (paddle1_pos + PAD_HEIGHT): 
            ball_vel[0] = - ball_vel[0]
            ball_vel[0] = ball_vel[0] / 10 + ball_vel[0] # increase by 10%
        else:
            spawn_ball(RIGHT)
            score2 += 1
    

    if ball_pos[0] >= (WIDTH - 1) - BALL_RADIUS - PAD_WIDTH:
        if ball_pos[1] >= paddle2_pos and ball_pos[1] <= (paddle2_pos + PAD_HEIGHT): 
            ball_vel[0] = - ball_vel[0]
            ball_vel[0] = ball_vel[0] / 10 + ball_vel[0] # increase by 10%
        else:
            spawn_ball(LEFT)
            score1 += 1

    # draw scores
    canvas.draw_text(str(score1),[200,100],50,"white")
    canvas.draw_text(str(score2),[380,100],50,"white")
        
def keydown(key):
    global paddle1_vel, paddle2_vel
    if key == simplegui.KEY_MAP["w"]:
        paddle1_vel -= 5
    elif key == simplegui.KEY_MAP["s"]:
        paddle1_vel += 5
    elif key == simplegui.KEY_MAP["up"]:
        paddle2_vel -= 5
    elif key == simplegui.KEY_MAP["down"]:
        paddle2_vel += 5
   
def keyup(key):
    global paddle1_vel, paddle2_vel
    paddle1_vel = 0
    paddle2_vel = 0

# create frame
frame = simplegui.create_frame("Pong", WIDTH, HEIGHT)
frame.set_draw_handler(draw)
frame.set_keydown_handler(keydown)
frame.set_keyup_handler(keyup)
frame.add_button("Restart", new_game)

# start frame
new_game()
frame.start()