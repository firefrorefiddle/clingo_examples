#script (python)
import clingo

from sys import stdin, stdout

def main(prg):
     basis = int(stdin.readline().strip())
     i = 0
     parts = [("base",[]), ("basis",[basis])]
     
     while (i < basis*basis):
         i += 1
         inp = stdin.readline().strip().split(" ")
         for num,j in zip(inp, range(basis*basis)):
             try:
                 parts.append(("hint", [i,j+1,int(num)]))
             except ValueError:
                 pass
     prg.ground(parts)

     def on_model(model):
         resmap = []
         for _ in range(basis * basis):
             resmap += [[0] * basis * basis]
         for atom in model.symbols(atoms=True):
             if(atom.name != "in"):
                 continue
             args = atom.arguments
             resmap[args[0].number-1][args[1].number-1] = args[2].number
         for line in resmap:
             for num in line:
                 stdout.write("%d "%num)             
             print("")
         
     prg.solve(on_model=on_model)
         
#end.

#program basis(b).
basis(b).

#program hint(x,y,v).
in(x,y,v).
