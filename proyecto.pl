
jugar :- assert(tablero([[0,0,2],[0,2,2],[0,4,2],[0,6,2],
		 [1,1,2],[1,3,2],[1,5,2],[1,7,2],
		 [2,0,2],[2,2,2],[2,4,2],[2,6,2],		 
		 [7,1,1],[7,3,1],[7,5,1],[7,7,1],
		 [6,0,1],[6,2,1],[6,4,1],[6,6,1],
		 [5,1,1],[5,3,1],[5,5,1],[5,7,1]
		 ])).
	
% Verifica si existe una ficha en el tablero	
existeFicha(X,Y,Z):- 
	tablero(T), 
	member([X,Y,Z],T).



mov1(X1,Y1,X2,Y2):-
	tablero(T),
	existeFicha(X1,Y1,1),
	X2 is (X1-1),
	Y2 is (Y1-1),
	X2<8,
	X2>(-1),
	Y2<8,
	Y2>(-1),
	not(existeFicha(X2,Y2,_)),
	!.
mov1(X1,Y1,X2,Y2):-
	tablero(T),
	existeFicha(X1,Y1,1),
	X2 is (X1-1),
	Y2 is (Y1+1),
	X2<8,
	X2>(-1),
	Y2<8,
	Y2>(-1),
	not(existeFicha(X2,Y2,_)),
	!.



%jugada(X1,Y1,X2,Y2) :- teTocaJugar,validajug,mover,guardartab,!.



jugadaAux(X1,Y1,X2,Y2,Color) :- 
	nonvar(X1),
	nonvar(X2),
	nonvar(Y1),
	nonvar(Y2),
	tablero(X),
	var(X).
