beautiful(ulrika).
beautiful(nisse).
beautiful(peter).

kind(bosse).

strong(bosse).
strong(bettan).

rich(nisse).
rich(bettan).

male(nisse).
male(peter).
male(bosse).

female(ulrika).
female(bettan).

likes(X, Y) :-
    male(X),
    female(Y),
    beautiful(Y).
likes(ulrika, X) :-
    male(X),
    rich(X),
    kind(X),
    likes(X, ulrika).
likes(ulrika, X) :-
    male(X),
    beautiful(X),
    strong(X),
    likes(X, ulrika).
likes(nisse, X) :-
    female(X),
    likes(X, nisse).

happy(X) :-
    rich(X).
happy(X) :- 
    male(X),
    female(Y),
    likes(X, Y),
    likes(Y, X).
happy(X) :-
    female(X),
    male(Y),
    likes(X, Y),
    likes(Y, X).