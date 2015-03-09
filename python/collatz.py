#!/usr/bin/python

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

print "Enter a number: "
number = input();

ret_val = collatz(number)

while True:
  if ret_val == 1:
    break;
  else:
    number = ret_val

  ret_val = collatz(number)
  
