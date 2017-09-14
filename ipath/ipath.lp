#include <incmode>.

#program base.

{step(X,Y) : e(X,Y)}.
    
goal :- connected(1,20).

connected(X,Y) :- step(X,Y).
connected(X,Y) :- connected(X,Z), step(Z,Y).

%#program step(k).

%#const max=k.
%{step(k,X,Y) : e(X,Y)}.

#program check(k).
:- not goal, query(k).
:- query(Q), #count { (X,Y) : step(X,Y) } > Q.

#show step/2.
#show query/1.
