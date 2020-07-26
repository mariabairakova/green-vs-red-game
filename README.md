# GreenVsRedGame

'Green vs. Red' game implementation using Swift Package Manager.

# About the game
'Green vs. Red' is played on 2D grid containing green (represented by 1) and red (represented by 0) cells. The game receives an initial state - 'Generation Zero'. After that 4 rules are applied on each cell at the same time in order to form next generation of the grid. 

Rules that create next generation:
1. Each red cell that is surrounded by exactly 3 or exactly 6 green cells will also become green in the next generation.
2. A red cell will stay red in the next generation if it has either 0, 1, 2, 4, 5, 7 or 8 green neighbours.
3. Each green cell surrounded by 0, 1, 4, 5, 7 or 8 green neighbours will become red in the next generation.
4. A green cell will stay green in the next generation if it has either 2, 3 or 6 green neighbours.

# Game input 
First provide size of the grid in 'x, y' format. (x being width, y being height).
Next y lines should contain strings (long x charaxters) with 0s and 1s which represent 'Generation Zero' state of the grid.
Last arguments should be coordinates (x1, y1) of a cell in the grid and N - number of generations to form. The format should be 'x1, y1, N'.

Program calculates in how many generations from Generation Zero to generation N the cell with coordinates x1 and y1 was green and prints the result in the console.

Example: 3x3 grid, the second row of initial state is all 1s, how many times will the cell [1, 0] become green in 10 turns?
```
3, 3
000
111
000
1, 0, 10
# Expected result: 5
```

# Run the program

Compiles with Swift 5 in WSL (Ubuntu 18.04)

```
$ cd green-vs-red-game
$ swift run
```





