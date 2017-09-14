-basis(3)       :- basis(X), X != 3.
basis(3)        :- not -basis(3).
zahl(1..B*B)    :- basis(B).

1{in(X,Y,N) : zahl(X)}1 :- zahl(Y), zahl(N).
1{in(X,Y,N) : zahl(Y)}1 :- zahl(X), zahl(N).
1{in(X,Y,N) : zahl(N)}1 :- zahl(X), zahl(Y).
1{in(X,Y,N) : group_sq(X,Y,G)}1 :- group(G), zahl(N).

:- in(_,_,N), not zahl(N).

group_sq(X,Y,G) :- XI = 0..2,
		   YI = 0..2,
		   basis(B),
		   X = XI * B + (1..B),
		   Y = YI * B + (1..B),
		   G = YI * 3 + XI + 1.

group(1..9).

#show in/3.
