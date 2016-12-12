#!/usr/bin/python

import pprint

def countCharsInString (myString):
  characterCount = {}
  for character in myString:
    characterCount.setdefault(character, 0)
    characterCount[character] = characterCount[character] + 1

  return characterCount

pprint.pprint (countCharsInString('It was a bright cold day in April, and the clocks were striking thirteen.'))
