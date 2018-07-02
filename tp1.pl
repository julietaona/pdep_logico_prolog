%Trabajo Práctico paradigma lógico -- Pulp Fiction
%Parte 1: Relaciones entre individuos. Recursividad. Negación.

%Punto 1
%saleCon(Quien, Cual).

saleCon(Persona1, Persona2):- pareja(Persona1, Persona2).
saleCon(Persona1, Persona2):- pareja(Persona2, Persona1).

%Punto 2

pareja(bernardo, bianca).
pareja(bernardo, charo).
pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

%Punto 3
%trabajaPara(Empleador, Empleado).

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

trabajaPara(Quien, bernardo):-
    trabajaPara(marsellus, Quien),
    Quien \= jules.
trabajaPara(Empleador, george):-
    saleCon(bernardo, Empleador).

%Punto 4

esFiel(Personaje):-
	findall(Pareja, saleCon(Personaje,Pareja), Parejas),
	length(Parejas,1).

%Punto 5

acataOrden(PersonaQueDaOrden,PersonaQueAcataOrden):-
	trabajaPara(PersonaQueDaOrden,PersonaQueAcataOrden).

acataOrden(PersonaQueDaOrden,PersonaQueAcataOrden):-
	trabajaPara(PersonaQueDaOrden,PersonaQueAcataOrdenRecursiva),
	acataOrden(PersonaQueAcataOrdenRecursiva,PersonaQueAcataOrden).

% -------- %

%Parte 2: Polimorfismo. Functores. Aritmética. Predicados de orden superior.

% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).

% encargo(Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%Punto 1

esPeligroso(Personaje):-
	personaje(Personaje, Ocupacion),
	haceActividadPeligrosa(Ocupacion).

haceActividadPeligrosa(mafioso(maton)).
haceActividadPeligrosa(ladron(Lugares)):-
	member(licorerias,Lugares).

%Punto 2

sanCayetano(Personaje1):-
	estanCerca(Personaje1,_),
	forall(estanCerca(Personaje1,Personaje2),encargo(Personaje1,Personaje2,_)).

estanCerca(Personaje1,Personaje2):-
	amigo(Personaje1,Personaje2).

estanCerca(Personaje1,Personaje2):-
	amigo(Personaje2,Personaje1).

estanCerca(Personaje1,Personaje2):-
	trabajaPara(Personaje1,Personaje2).

estanCerca(Personaje1,Personaje2):-
	trabajaPara(Personaje2,Personaje1).

%Punto 3
nivelRespeto(Nombre, Nivel):-
    personaje(Nombre, Ocupacion),
    suNivel(Ocupacion, Nivel).
nivelRespeto(vincent, 15).
nivelRespeto(Nombre, 0):-
    personaje(Nombre, Ocupacion),
    not(suNivel(Ocupacion,_)).

suNivel((actriz(Lista)), Nivel):-
    length(Lista, Cantidad),
    Nivel is (Cantidad/10).
        
suNivel((mafioso(cerebro)), 10).
suNivel((mafioso(capo)), 20).

%Punto 4

cantRespetables(Nombre):-
    nivelRespeto(Nombre, Nivel),
    Nivel > 9.
cantNoRespetables(Nombre):-
    nivelRespeto(Nombre, Nivel),
    Nivel =< 9.

respetabilidad(Respetables,NoRespetables):-
	findall(_,cantRespetables(_),ListaRespetables),
	findall(_,cantNoRespetables(_),ListaNoRespetables),
	length(ListaRespetables,Respetables),
	length(ListaNoRespetables,NoRespetables).

%Punto 5

masAtareado(Personaje):-
	encargo(_,Personaje,_),
	forall((encargo(_,OtroPersonaje,_),OtroPersonaje \= Personaje) , tieneMenorCantidadDeEncargos(OtroPersonaje,Personaje)).
	

tieneMenorCantidadDeEncargos(OtroPersonaje,Personaje):-
	OtroPersonaje \= Personaje,
	cantidadEncargos(OtroPersonaje,CantidadOtroPersonaje),
	cantidadEncargos(Personaje,CantidadPersonaje),
	CantidadOtroPersonaje < CantidadPersonaje.

cantidadEncargos(Personaje,Cantidad):-
	encargo(_,Personaje,_),
	findall(Personaje,encargo(_,Personaje,_),Encargos),
	length(Encargos,Cantidad).
