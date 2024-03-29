## Rushhour solver

Uses incremental mode to solve in as few steps as possible. 

Example:

```
$ clingo solver.lp instance.lp 
clingo version 5.4.1
Reading from solver.lp ...
solver.lp:22:21-30: info: atom does not occur in any rule head:
  do(#X0,#P1)

solver.lp:63:33-50: info: atom does not occur in any rule head:
  do(#X0,move(#X1,#P2))

Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Answer: 1
do(1,move(5,2)) do(2,move(17,4)) do(3,move(17,3)) do(4,move(16,2)) do(5,move(5,3)) do(6,move(16,3)) do(7,move(2,4)) do(8,move(6,2)) do(9,move(18,2)) do(10,move(24,4)) do(11,move(6,3)) do(12,move(18,1)) do(13,move(24,3)) do(14,move(5,4)) do(15,move(6,4)) do(16,move(red,4)) do(17,move(red,5))
Optimization: 17
OPTIMUM FOUND

Models       : 1
  Optimum    : yes
Optimization : 17
Calls        : 18
Time         : 0.303s (Solving: 0.22s 1st Model: 0.01s Unsat: 0.21s)
CPU Time     : 0.302s
```

### Mult-action planning

You can allow multiple moves in each step by removing the upper limit in the step program:

```
1 { do(k,move(Id,1..Lim)) :
    h(k-1,car(Id,X,Y,Dir,Len)),
    Lim=dim+1-Len
  }.
```

Example:

```
mike@lenovo-linux:~/src/clingo_examples/rushhour$ clingo solver.lp instance.lp 
clingo version 5.4.1
Reading from solver.lp ...
solver.lp:22:21-30: info: atom does not occur in any rule head:
  do(#X0,#P1)

solver.lp:63:33-50: info: atom does not occur in any rule head:
  do(#X0,move(#X1,#P2))

Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Solving...
Answer: 1
do(1,move(5,2)) do(1,move(6,2)) do(1,move(16,2)) do(1,move(17,4)) do(2,move(16,3)) do(2,move(17,3)) do(3,move(2,4)) do(3,move(1,3)) do(3,move(5,3)) do(3,move(6,3)) do(3,move(red,2)) do(4,move(5,2)) do(4,move(1,4)) do(4,move(18,2)) do(5,move(red,1)) do(5,move(24,4)) do(5,move(18,1)) do(6,move(5,3)) do(6,move(red,2)) do(6,move(24,3)) do(7,move(5,4)) do(7,move(red,3)) do(8,move(6,4)) do(8,move(red,4)) do(9,move(red,5))
Optimization: 9
OPTIMUM FOUND

Models       : 1
  Optimum    : yes
Optimization : 9
Calls        : 10
Time         : 0.036s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.036s
```

Now it can be solved in 9 steps and the solution is found much faster.
