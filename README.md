# pdep_logico_prolog

Pulp Fiction

Parte 1: Relaciones entre individuos. Recursividad. Negación. 

Tarantino, un poco cansado después de largas horas de filmación de su clásico noventoso Pulp Fiction, decidió escribir un programa Prolog para entender mejor las relaciones entre sus personajes. 

Para ello nos entregó la siguiente base de conocimientos sobre sus personajes, parejas y actividades:

%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

Todos los predicados deben ser inversibles en todos sus argumentos, a menos de que se especifique lo contrario.
Salen juntos
saleCon/2: relaciona dos personas que están saliendo porque son pareja, independientemente de cómo esté definido en el predicado pareja/2.

Ejemplo: 
?- saleCon(Quien, Cual).
Quien = marsellus,
Cual = mia ;
Quien = pumkin,
Cual = honeyBunny ;
Quien = mia, % Están al revés que antes
Cual = marsellus 
... 

La cláusula ¿es recursiva? En caso afirmativo separe caso base y caso recursivo.
Más parejas
Necesitamos agregar la siguiente Información
Bernardo es pareja de Bianca y de Charo
No se sabe si Bianca es pareja de Demóstenes
Nuevos trabajadores
Necesitamos agregar más información
Bernardo trabaja para cualquiera que trabaje para marsellus (salvo para jules) 
George trabaja para todos los que salen con Bernardo

Ejemplo: 
?- trabajaPara(Quien, bernardo).
Quien = vincent ;

?- trabajaPara(Empleador, george).
Empleador = bianca ;
Empleador = charo.
Fidelidad
Realizar el predicado esFiel/1 sabiendo que una persona es fiel cuando sale con una única persona. 

?- esFiel(Personaje).
Personaje = marsellus ;
Personaje = pumkin ;
Personaje = mia ;
Personaje = honeyBunny ;
Personaje = bianca ;
Personaje = charo.

Atención: not es un predicado de aridad 1, no se puede utilizar así
not(5 = 6, 7 = 9) porque aquí not tendría aridad 2
en cambio sí se puede utilizar 
?-  not((5 = 6, 7 = 9)).
true
Acatar órdenes
Realizar el predicado acataOrden/2 que relaciona dos personas. Alguien acata la orden de otra persona si trabaja para esa persona directa o indirectamente (porque trabaja para otro que a su vez trabaja para esa persona, y así sucesivamente).

Ejemplo:
?- acataOrden(marsellus, Empleado).
Empleado = vincent ;
Empleado = jules ;
Empleado = winston ;
Empleado = bernardo ;
Empleado = bernardo ;
false.

La cláusula ¿es recursiva? En caso afirmativo separe caso base y caso recursivo.
