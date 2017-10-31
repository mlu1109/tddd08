:- use_module(library(clpfd)).

% Identifier, Persons, Duration
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

on(a,d).
on(b,c).
on(c,d).

% Creates a new list with time variables.
% An entry is on the form [ID, StartTime, EndTime, Persons, Duration]
getContainersList([], []).
getContainersList([[ID, P, D]|Cntrs], [[ID, _ST, _ET, P, D]|CntrList]) :-
  getContainersList(Cntrs, CntrList).

% Add constraint to start time depending on stacking.
constraintStart([ID, _ST, _ET, _P, _D], [OthID, _OthST, _OthET, _OthM, _OthD]) :-
  \+on(OthID, ID).
constraintStart([ID, ST, _ET, _P, _D], [OthID, _OthST, OthET, _OthM, _OthD]) :-
  on(OthID, ID),
  ST #>= OthET.

% Apply constraintStart to Cur w.r.t all Other.
applyConstraintStart(_Cur, []).
applyConstraintStart(Cur, [Oth|Others]) :-
  constraintStart(Cur, Oth),
  applyConstraintStart(Cur, Others).

% Applies start- and end time constraints.
% Enumerate through all ordered pairs of containers and apply constraintStart to each.
applyConstraints([], _All).
applyConstraints([Cur|Rest], All) :-
  Cur = [_ID, ST, ET, _P, D],
  ST in 0..100,
  ET in 0..100,
  ET #= ST + D,
  applyConstraintStart(Cur, All),
  applyConstraints(Rest, All).

% Assemble a list of tasks for cumulative.
getTasks([], []). 
getTasks([[_ID, ST, ET, P, D]|Rest], [T|Tasks]) :-
  % Using a non-integer as ID (5th argument) in task crashes.
  % Assigning a useless integer ID (0) instead.
  T = task(ST, D, ET, P, 0), 
  getTasks(Rest, Tasks).

% Sets constraint on Max to be at least the last container's end time.
bindEndTime([], _Max).
bindEndTime([[_ID, _ST, ET, _P, _D]|Rest], Max) :-
  Max #>= ET,
  bindEndTime(Rest, Max).

printContainers([]).
printContainers([[ID, ST, ET, _P, _D]|Rest]) :-
  write('| ID: '),  write(ID), write(' | Start: '), write(ST), write(' | End: '), write(ET), nl,
  printContainers(Rest).

printSolution(Persons, EndTime, Cost, Cntrs) :-
  write('+-----------------------------------------'), nl,
  write('| Persons: '), write(Persons), write(' | Duration: '), write(EndTime), write(' | Cost: '), write(Cost), nl,
  write('+-----------------------------------------'), nl,
  printContainers(Cntrs),
  write('+-----------------------------------------'), nl.

schedule(Cost) :-
  findall([ID,P,D], container(ID,P,D), List),
  getContainersList(List, Cntrs),
  applyConstraints(Cntrs, Cntrs),
  getTasks(Cntrs, Tasks),
  Persons in 0..100,
  EndTime in 0..100,
  bindEndTime(Cntrs, EndTime),
  Cost #= Persons * EndTime,
  % http://www.swi-prolog.org/pldoc/man?predicate=cumulative/2
  cumulative(Tasks, [limit(Persons)]),
  % https://sicstus.sics.se/sicstus/docs/3.7.1/html/sicstus_33.html#SEC262
  labeling([minimize(Cost)], [Cost]),
  printSolution(Persons, EndTime, Cost, Cntrs).