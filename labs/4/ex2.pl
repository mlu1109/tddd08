dfsPath(X, X, Visited, Visited).
dfsPath(X, Z, Visited, Path) :-
  edge(X, Y),
  nonmember(Y, Visited),
  dfsPath(Y, Z, [Y|Visited], Path).

dfs(Path) :- 
  Start = [3:3,left,0:0],
  Goal  = [0:0,right,3:3],
  dfsPath(Start, Goal, [Start], Path).