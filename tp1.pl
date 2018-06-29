%trabajaPara(Empleador, Empleado).
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
trabajaPara(winston, ana).


%saleCon(Quien, Cual).
saleCon(Persona1, Persona2):- pareja(Persona1, Persona2).
saleCon(Persona1, Persona2):- pareja(Persona2, Persona1).
pareja(bernardo, bianca).
pareja(bernardo, charo).
pareja(marsellus, mia).
pareja(pumkin, honeyBunny).

esFiel(Personaje):-
	findall(Pareja, saleCon(Personaje,Pareja), Parejas),
	length(Parejas,1).

acataOrden(PersonaQueDaOrden,PersonaQueAcataOrden):-
	trabajaPara(PersonaQueDaOrden,PersonaQueAcataOrden).

acataOrden(PersonaQueDaOrden,PersonaQueAcataOrden):-
	trabajaPara(PersonaQueDaOrden,PersonaQueAcataOrdenRecursiva),
	acataOrden(PersonaQueAcataOrdenRecursiva,PersonaQueAcataOrden).