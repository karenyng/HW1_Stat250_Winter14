#!/usr/bin/python
import sys
currentLine = 0
nextLine = 0
hasHeader = 1


input = open(sys.argv[1], 'r')

if hasHeader :
   input.readline()

while 1:
    nextLine = sys.stdin.readline()
    if not nextLine:
        break
    jump = int(nextLine) - currentLine
    i = 0
    while i < jump:
        i = i + 1
        line = input.readline()
        currentLine = currentLine + 1
    print(line.strip())

