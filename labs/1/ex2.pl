edge(a, b).
edge(a, c).
edge(b, c).
edge(c, d).
edge(c, e).
edge(d, h).
edge(d, f).
edge(e, f).
edge(e, g).
edge(f, g).

path(X, Y) :- 
    edge(X, Y).
path(X, Y) :-
    edge(X, Z),
    path(Z, Y).
path(X, Y, [[X,Y]]) :-
    edge(X, Y).
path(X, Y, [[X,Z]|T]) :-
    edge(X, Z),
    path(Z, Y, T).
    
npath(X, Y, N) :-
    path(X, Y, L),
    length(L, N).
