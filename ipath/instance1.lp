#const imax=20.

n(1..20).
e(X,Y) :- n(X), n(Y), |X-Y| < 3.
