#!/usr/bin/python 

def characterPictureGrid(grid):
    for dim1 in range(0, len(grid)):
        for dim2 in range(0, len(grid[dim1])):
            print grid[dim1][dim2],
            
        print "\n"

grid = [['.', '.', '.', '.', '.', '.'],
        ['.', 'O', 'O', '.', '.', '.'],
        ['O', 'O', 'O', 'O', '.', '.'],
        ['O', 'O', 'O', 'O', 'O', '.'],
        ['.', 'O', 'O', 'O', 'O', 'O'],
        ['O', 'O', 'O', 'O', 'O', '.'],
        ['O', 'O', 'O', 'O', '.', '.'],
        ['.', 'O', 'O', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.']]
    
characterPictureGrid(grid)
