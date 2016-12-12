#!/usr/bin/python

# Write a function that takes a list value as an argument and returns
# a string with all the items separated by a comma and a space, 
# with 'and' inserted before the last item
def getCommaSeperatedListItems (myList):
    myList[-1] = "and " + myList[-1]
    return ", ".join(myList)

print getCommaSeperatedListItems(['apples', 'bananas', 'tofu', 'cats'])
