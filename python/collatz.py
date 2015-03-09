#!/usr/bin/python

import sys

def collatz(number):
  if number % 2 == 0:
    num_floor =  number // 2
    print num_floor
    return num_floor
  elif number % 2 == 1:
    num_expr = 3 * number + 1
    print num_expr
    return num_expr
  else:
    print "Number is neither even nor odd, what is it?"

num = raw_input("Enter a number: ");

try:
  int_number = int(num)
except ValueError:
  print "You must type an integer"
  sys.exit()

ret_val = collatz(int_number)

while True:
  if ret_val == 1:
    break;
  else:
    number = ret_val

  ret_val = collatz(number)
  
