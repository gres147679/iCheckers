
%Comando que inicia el juego, asi como el tablero del mismo
jugar :- assert(tablero(
		 [
		 [1,2,1],[1,4,1],[1,6,1],[1,8,1],
		 [2,1,1],[2,3,1],[2,5,1],[2,7,1],
		 [3,2,1],[3,4,1],[3,6,1],[3,8,1],		 
		 [8,1,2],[8,3,2],[8,5,2],[8,7,2],
		 [7,2,2],[7,4,2],[7,6,2],[7,8,2],
		 [6,1,2],[6,3,2],[6,5,2],[6,7,2]
		 ])).
	
% Verifica si existe una ficha en el tablero	
existeFicha(X,Y,Z):- 
	tablero(T), 
	member([X,Y,Z],T).

impCar(X):-
	X is 1,
	write('|< | ').
impCar(X):-
	X is 2,
	write('|> | ').
impCar(X):-
	X is 3,
	write('|<<| ').
impCar(X):-
	X is 4,
	write('|>>| ').


%verifica para imprimir un caracter del tablero
imprimirCar(F,C,X):-
	member([F,C,Z],X),
	impCar(Z),
	!.
imprimirCar(F,C,X):-
	write('|  | ').

%imprime una fila
imprimirFila(F,X):-
	write(F),
	write(' '),
	imprimirCar(F,1,X),
	imprimirCar(F,2,X),
	imprimirCar(F,3,X),
	imprimirCar(F,4,X),
	imprimirCar(F,5,X),
	imprimirCar(F,6,X),
	imprimirCar(F,7,X),
	imprimirCar(F,8,X),
	writeln('').

%Manda a imprimir el tablero
imprimir(X):-
	writeln('    1    2    3    4    5    6    7    8'), 
	imprimirFila(1,X),
	imprimirFila(2,X),
	imprimirFila(3,X),
	imprimirFila(4,X),
	imprimirFila(5,X),
	imprimirFila(6,X),
	imprimirFila(7,X),
	imprimirFila(8,X).


%Verifica si el jugador uno tiene una jugada valida de movimiento en diagonal
mov1(X1,Y1,X2,Y2):-
	tablero(T),
	existeFicha(X1,Y1,1),
	X2 is (X1+1),
	Y2 is (Y1+1),
	X2<9,
	X2>0,
	Y2<9,
	Y2>0,
	not(existeFicha(X2,Y2,_)),
	!.
mov1(X1,Y1,X2,Y2):-
	tablero(T),
	existeFicha(X1,Y1,1),
	X2 is (X1+1),
	Y2 is (Y1-1),
	X2<9,
	X2>0,
	Y2<9,
	Y2>0,
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
