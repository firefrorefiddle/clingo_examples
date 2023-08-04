# Sudoku Solver

sudoku.lp is a sudoku solver, sudoku_slv.lp runs it with I/O.

Example call:


```
clingo -q2 -V0 sudoku.lp sudoku_slv.lp < instance1.txt

 -->
 
1 2 3 4 5 7 6 9 8 
8 4 5 9 3 6 7 2 1 
9 6 7 8 1 2 3 5 4 
2 3 8 5 6 1 4 7 9 
4 1 6 7 2 9 5 8 3 
5 7 9 3 4 8 1 6 2 
3 8 2 6 7 4 9 1 5 
6 5 1 2 9 3 8 4 7 
7 9 4 1 8 5 2 3 6 
SATISFIABLE
```

instance2.txt is size 81*81 and takes about 20 seconds on my machine.
