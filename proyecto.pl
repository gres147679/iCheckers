
%Predicado que inicia el tablero del juego
iniciarTablero:- 
	assert(ficha(1,2,1)),assert(ficha(1,4,1)),
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

%Predicado que comienza el juego
jugar:-
	iniciarTablero,
	assert(tocaJugador(1)),
	verModo,
	writeln('Comenzo el juego'),
	imprimir,
	writeln('Juega jugador 1').

verModo:-
	writeln('Desea jugar contra la maquina(S/N)'),
	readln([X|_]),
	maquinaONo(X).

maquinaONo('S'):-
	assert(maquina(1)),
	!.

maquinaONo('N'):-
	assert(maquina(0)),
	!.

maquinaONo(_):-
	verModo.
	



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

%Mueve una ficha indicada
moverF(X1,Y1,X2,Y2):-
	retract(ficha(X1,Y1,Z)),
	assert(ficha(X2,Y2,Z)),
	corona1(X2,Y2),
	corona2(X2,Y2).

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
	X is 8,
	retract(ficha(X,Y,1)),
	assert(ficha(X,Y,3)),
	!.

%no corono
corona1(_,_).
	

%Corona ficha de jugador 2
corona2(X,Y):-
	ficha(X,Y,2),
	X is 1,
	retract(ficha(X,Y,2)),
	assert(ficha(X,Y,4)),
	!.

%No corono
corona2(_,_).


%Nota: el predicado ejecutar estara en varias partes del archivo para hacer
%Mas facil su comprension. Lo que hace este predicado, es que dado
%Un movimiento valido, haga todo lo correspondiente 
%para que el movimiento se ejecute de una manera correcta.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movimientos jugador 1.

%Verifica si el jugador 1 tiene una jugada valida de movimiento en diagonal
mov1(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,1),
	X2 is (X1+1),
	Y2 is (Y1+1),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,1),
	!.


%Si el cuarto parametro es 0 quiere decir
%que solo se quiere verificar una jugada, mas no ejecutarla

ejecutar(_,_,_,_,0,_).

ejecutar(X1,Y1,X2,Y2,1,1):-
	moverF(X1,Y1,X2,Y2),
	corona1(X2,Y2).


mov1(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,1),
	X2 is (X1+1),
	Y2 is (Y1-1),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,1),
	!.


%Verifica para comer a izquierda
mov1(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,1),
	XF is X1+1,
	YF is Y1-1,
	(ficha(XF,YF,2);ficha(XF,YF,4)),
	X2 is X1+2,
	Y2 is Y1-2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,2),
	!.

ejecutar(X1,Y1,X2,Y2,TMP,2):-
	XF is X1+1,
	YF is Y1-1,
	moverF(X1,Y1,X2,Y2),
	corona1(X2,Y2),
	retract(ficha(XF,YF,_)),
	sigoComiendo(X2,Y2).


%Verifica para comer a derecha
mov1(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,1),
	XF is X1+1,
	YF is Y1+1,
	(ficha(XF,YF,2);ficha(XF,YF,4)),
	X2 is X1+2,
	Y2 is Y1+2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,3),
	!.

ejecutar(X1,Y1,X2,Y2,TMP,3):-
	XF is X1+1,
	YF is Y1+1,
	moverF(X1,Y1,X2,Y2),
	corona1(X2,Y2),
	retract(ficha(XF,YF,_)),
	sigoComiendo(X2,Y2).



%Movimientos para fichas reinas jugador 1

tipoPaso(X,Y):- X<0, Y is (1).
tipoPaso(X,Y):- X>0, Y is (-1).

verificarReina11(X,Y,X,Y,_,_):- !.
verificarReina11(X,Y,Z,W,P1,P2):-
	not(ficha(X,Y,_)),
	XN is X+P1,
	YN is Y+P2,
	verificarReina11(XN,YN,Z,W,P1,P2).


mov1(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,3),
	movimientoReina(X1,Y1,X2,Y2,TMP).

%Movimiento en el que una reina come
mov1(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,3),
	movimientoReina2(X1,Y1,X2,Y2,2,4,TMP).


movimientoReina(X1,Y1,X2,Y2,TMP):-
	not(ficha(X2,Y2,_)),
	XR is X1-X2,
	YR is Y1-Y2,
	abs(XR,PASO1),
	abs(YR,PASO2),
	PASO1 is PASO2,
	verif(X2,Y2),
	tipoPaso(X1-X2,P1),
	tipoPaso(Y1-Y2,P2),
	XN is X1+P1,
	YN is Y1+P2,
	verificarReina11(XN,YN,X2,Y2,P1,P2),
	ejecutar(X1,Y1,X2,Y2,TMP,4).

ejecutar(X1,Y1,X2,Y2,1,4):-
	moverF(X1,Y1,X2,Y2).


movimientoReina2(X1,Y1,X2,Y2,Z,W,TMP):-
	not(ficha(X2,Y2,_)),
	XR is X1-X2,
	YR is Y1-Y2,
	abs(XR,PASO1),
	abs(YR,PASO2),
	PASO1 is PASO2,
	PASO1 >= 2,
	verif(X2,Y2),
	tipoPaso(X1-X2,P1),
	tipoPaso(Y1-Y2,P2),
	XN is X1+P1,
	YN is Y1+P2,
	XB is X2-P1,
	YB is Y2-P2,
	verificarReina11(XN,YN,XB,YB,P1,P2),
	(ficha(XB,YB,Z);ficha(XB,YB,W)),
	ejecutar(X1,X2,Y1,Y2,TMP,5).

ejecutar(X1,Y1,X2,Y2,1,5):-
	tipoPaso(X1-X2,P1),
	tipoPaso(Y1-Y2,P2),
	XB is X2-P1,
	YB is Y2-P2,
	retract(ficha(XB,YB,_)),
	moverF(X1,Y1,X2,Y2),
	sigoComiendo(X2,Y2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movimientos jugador 2.

%Verifica si el jugador 1 tiene una jugada valida de movimiento en diagonal
mov2(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,2),
	X2 is (X1-1),
	Y2 is (Y1+1),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,6),
	!.

ejecutar(X1,Y1,X2,Y2,1,6):-
	moverF(X1,Y1,X2,Y2),
	corona2(X2,Y2),
	!.

mov2(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,2),
	X2 is (X1-1),
	Y2 is (Y1-1),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,6),
	!.




%Verifica para comer a izquierda
mov2(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,2),
	X2 is X1-2,
	Y2 is Y1-2,
	XF is X1-1,
	YF is Y1-1,
	(ficha(XF,YF,1);ficha(XF,YF,3)),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,7),
	!.

ejecutar(X1,Y1,X2,Y2,1,7):-
	XF is X1-1,
	YF is Y1-1,
	moverF(X1,Y1,X2,Y2),
	retract(ficha(XF,YF,_)),
	corona2(X2,Y2),
	esMaq(X1,Y1,X2,Y2),
	sigoComiendo(X2,Y2),
	!.



%Verifica para comer a derecha
mov2(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,2),
	XF is X1-1,
	YF is Y1+1,
	X2 is X1-2,
	Y2 is Y1+2,
	(ficha(XF,YF,1);ficha(XF,YF,3)),
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	ejecutar(X1,Y1,X2,Y2,TMP,8),
	!.

ejecutar(X1,Y1,X2,Y2,1,8):-
	XF is X1-1,
	YF is Y1+1,
	moverF(X1,Y1,X2,Y2),
	retract(ficha(XF,YF,_)),
	corona2(X2,Y2),
	esMaq(X1,Y1,X2,Y2),
	sigoComiendo(X2,Y2),
	!.


esMaq(X,Y,X2,Y2):-
	maquina(1),
	write('La maquina ha comido, se movio de la posicion ('),
	write(X),
	write(','),
	write(Y),
	write(') a la posicion ('),
	write(X2),
	write(','),
	write(Y2),
	writeln(')').

%Verifica pasos de una reina para el jugador 2

mov2(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,4),
	movimientoReina(X1,Y1,X2,Y2,TMP).


mov2(X1,Y1,X2,Y2,TMP):-
	ficha(X1,Y1,4),
	movimientoReina2(X1,Y1,X2,Y2,1,3,TMP).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%predicado que indica si una persona come, luego 
%de una ficha comida, y da los pasos validos a partir de la posicion,
%actual de esa ficha


sigoComiendo(X1,Y1):-
	(tocaJugador(1);maquina(0)),
	puedoComer(X1,Y1,_,_,_,_),
	imprimir,
	write('Actualmente se encuentra en la posicion ('),
	write(X1),
	write(','),
	write(Y1),
	writeln(')'),
	writeln('Debe seguir comiendo con la ficha que venia comiendo, inserte una jugada valida'),
	writeln('Diga a que posicion quiere ir, diga la X seguido de un punto (.)'),
	read(X2),
	writeln('ahora la Y seguida de un punto (.):'),
	read(Y2),
	puedoComer(X1,Y1,XN2,YN2,X2,Y2),
	retract(ficha(XN2,YN2,_)),
	retract(ficha(X1,Y1,Z)),
	assert(ficha(X2,Y2,Z)),
	corona1(X2,Y2),
	corona2(X2,Y2),
	sigoComiendo(X2,Y2).

sigoComiendo(X1,Y1):-
	tocaJugador(2),
	maquina(1),
	puedoComer(X1,Y1,XN2,YN2,X2,Y2),
	writeln('La maquina sigue jugando, mueve ahora la ficha de'),
	write('La posicion ('),
	write(X1),
	write(','),
	write(Y1),
	write(') a la posicion ('),
	write(X2),
	write(','),
	write(Y2),
	writeln(')'),
	retract(ficha(XN2,YN2,_)),
	retract(ficha(X1,Y1,Z)),
	assert(ficha(X2,Y2,Z)),
	corona1(X2,Y2),
	corona2(X2,Y2),
	sigoComiendo(X2,Y2).
	
sigoComiendo(X1,Y1):-
	puedoComer(X1,Y1,_,_,_,_),
	sigoComiendo(X1,Y1).


sigoComiendo(X1,Y1):- not(puedoComer(X1,Y1,_,_,_,_)).



%Predicado que indica que fichas pueden comer en cierto momento

puedoComer(X1,Y1,XN,YN,X2,Y2):-
	(ficha(X1,Y1,1);ficha(X1,Y1,3)),
	XN is (X1+1),
	YN is (Y1+1),
	(ficha(XN,YN,2);ficha(XN,YN,4)),
	X2 is X1+2,
	Y2 is Y1+2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.

puedoComer(X1,Y1,XN,YN,X2,Y2):-
	(ficha(X1,Y1,1);ficha(X1,Y1,3)),
	XN is (X1+1),
	YN is (Y1-1),
	(ficha(XN,YN,2);ficha(XN,YN,4)),
	X2 is X1+2,
	Y2 is Y1-2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.


puedoComer(X1,Y1,XN,YN,X2,Y2):-
	(ficha(X1,Y1,2);ficha(X1,Y1,4)),
	XN is (X1-1),
	YN is (Y1+1),
	(ficha(XN,YN,1);ficha(XN,YN,3)),
	X2 is X1-2,
	Y2 is Y1+2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.

puedoComer(X1,Y1,XN,YN,X2,Y2):-
	(ficha(X1,Y1,2);ficha(X1,Y1,4)),
	XN is (X1-1),
	YN is (Y1-1),
	(ficha(XN,YN,1);ficha(XN,YN,3)),
	X2 is X1-2,
	Y2 is Y1-2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.


puedoComer(X1,Y1,XN,YN,X2,Y2):-
	ficha(X1,Y1,3),
	XN is (X1-1),
	YN is (Y1+1),
	(ficha(XN,YN,2);ficha(XN,YN,4)),
	X2 is X1-2,
	Y2 is Y1+2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.

puedoComer(X1,Y1,XN,YN,X2,Y2):-
	ficha(X1,Y1,3),
	XN is (X1-1),
	YN is (Y1-1),
	(ficha(XN,YN,2);ficha(XN,YN,4)),
	X2 is X1-2,
	Y2 is Y1-2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.

puedoComer(X1,Y1,XN,YN,X2,Y2):-
	ficha(X1,Y1,4),
	XN is (X1+1),
	YN is (Y1+1),
	(ficha(XN,YN,1);ficha(XN,YN,3)),
	X2 is X1+2,
	Y2 is Y1+2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.

puedoComer(X1,Y1,XN,YN,X2,Y2):-
	ficha(X1,Y1,4),
	XN is (X1+1),
	YN is (Y1-1),
	(ficha(XN,YN,1);ficha(XN,YN,3)),
	X2 is X1+2,
	Y2 is Y1-2,
	verif(X2,Y2),
	not(ficha(X2,Y2,_)),
	!.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Imprime el mensaje de la jugada de el jugador W, ya sea que le gane a Z
%o simplemente sea un movimiento
mensaje(Z,W):-
	ficha(X,Y,Z),
	write('Movimiento del jugador '),
	write(W),
	writeln(': '),
	imprimir,
	mensaje2(Z,W).

mensaje(Z,W):-
	not(ficha(X,Y,Z)),
	write('Ha ganado el jugador '),
	write(W),
	writeln(', felicidades. Tablero final:'),
	imprimir,
	retract(ficha(_,_,_)),
	retract(tocaJugador(_)).


mensaje2(1,2):-
	not(mov1(X,Y,X2,Y2,0)),
	writeln('No puede jugar el jugador 1'),
	writeln('Debe jugar nuevamente el jugador 2'),
	retract(tocaJugador(1)),
	assert(tocaJugador(2)),
	!.

mensaje2(2,1):-
	not(mov2(X,Y,X2,Y2,0)),
	writeln('No puede jugar el jugador 2'),
	writeln('Debe jugar nuevamente el jugador 1'),
	retract(tocaJugador(1)),
	assert(tocaJugador(2)),
	!.

mensaje2(Z,W):-
	write('Juega jugador '),
	writeln(Z).


%predicado utilizado para hacer una jugada valida
jugada(X1,Y1,X2,Y2) :- 
	tocaJugador(1),
	mov1(X1,Y1,X2,Y2,1),
	retract(tocaJugador(1)),
	assert(tocaJugador(2)),
	mensaje(2,1),
	simaquina,
	!.

jugada(X1,Y1,X2,Y2):-
	tocaJugador(2),
	mov2(X1,Y1,X2,Y2,1),
	retract(tocaJugador(2)),
	assert(tocaJugador(1)),
	mensaje(1,2),
	!.
	

simaquina:- 
	maquina(1),
	jugada(X,Y,Z,W).

simaquina:-
	maquina(0).


