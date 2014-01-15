
%Comando que inicia el juego, asi como el tablero del mismo
jugar:- assert(ficha(1,2,1)),assert(ficha(1,4,1)),
	assert(ficha(1,6,1)),assert(ficha(1,8,1)),
	assert(ficha(2,1,1)),assert(ficha(2,3,1)),
	assert(ficha(2,5,1)),assert(ficha(2,7,1)),
	assert(ficha(3,2,1)),assert(ficha(3,4,1)),
	assert(ficha(3,6,1)),assert(ficha(3,8,1)),
	assert(ficha(6,1,2)),assert(ficha(6,3,2)),
	assert(ficha(6,5,2)),assert(ficha(6,7,2)),
	assert(ficha(7,2,2)),assert(ficha(7,4,2)),
	assert(ficha(7,6,2)),assert(ficha(7,8,2)),
	assert(ficha(8,1,2)),assert(ficha(8,3,2)),
	assert(ficha(8,5,2)),assert(ficha(8,7,2)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Imprimir el tablero	

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
imprimirCar(F,C):-
	ficha(F,C,Z),
	impCar(Z),
	!.
imprimirCar(F,C):-
	write('|  | ').

%imprime una fila
imprimirFila(F):-
	write(F),
	write(' '),
	imprimirCar(F,1),
	imprimirCar(F,2),
	imprimirCar(F,3),
	imprimirCar(F,4),
	imprimirCar(F,5),
	imprimirCar(F,6),
	imprimirCar(F,7),
	imprimirCar(F,8),
	writeln('').

%Manda a imprimir el tablero
imprimir:-
	writeln('    1    2    3    4    5    6    7    8'), 
	imprimirFila(1),
	imprimirFila(2),
	imprimirFila(3),
	imprimirFila(4),
	imprimirFila(5),
	imprimirFila(6),
	imprimirFila(7),
	imprimirFila(8).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Verifica que no me salga del tablero, al hacer un movimiento a
%la posicion (X,Y)
verif(X,Y):-
	X<9,
	X>0,
	Y<9,
	Y>0.


%Corona ficha de jugador 1
corona1(X,Y):-
	ficha(X,Y,1),
	Y is 8,
	retract(ficha(X,Y,1)),
	assert(ficha(X,Y,3)).

%Corona ficha de jugador 2
corona2(X,Y):-
	ficha(X,Y,2),
	Y is 1,
	retract(ficha(X,Y,2)),
	assert(ficha(X,Y,4)).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movimientos jugador 1.

%Verifica si el jugador 1 tiene una jugada valida de movimiento en diagonal
mov1(X1,Y1,X2,Y2):-
	ficha(X1,Y1,1),
	X2 is (X1+1),
	Y2 is (Y1+1),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.
mov1(X1,Y1,X2,Y2):-
	ficha(X1,Y1,1),
	X2 is (X1+1),
	Y2 is (Y1-1),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.
%Verifica para comer a izquierda
mov1(X1,Y1,X2,Y2):-
	ficha(X1,Y1,1),
	XF is X1+1,
	YF is Y1-1,
	(ficha(XF,YF,2);ficha(XF,YF,4)),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	X2 is X1+2,
	Y2 is Y1-2.

%Verifica para comer a derecha
mov1(X1,Y1,X2,Y2):-
	ficha(X1,Y1,1),
	XF is X1+1,
	YF is Y1+1,
	(ficha(XF,YF,2);ficha(XF,YF,4)),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	X2 is X1+2,
	Y2 is Y1+2.


%Movimientos para fichas reinas



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%jugada(X1,Y1,X2,Y2) :- teTocaJugar,validajug,mover,guardartab,!.



jugadaAux(X1,Y1,X2,Y2,Color) :- 
	nonvar(X1),
	nonvar(X2),
	nonvar(Y1),
	nonvar(Y2),
	tablero(X),
	var(X).
