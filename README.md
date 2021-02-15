# Juego: “MyPong”

Asignatura: Creando interfaces de usuario

Curso: 4º

Autor: Eduardo Maldonado Fernández

## Introducción
Se ha realizado un juego similar al Pong para dos jugadores mediante control de teclado siendo jugador 1 las teclas UP-DOWN y jugador 2 las teclas ‘w’-‘s’.

## Descripción
Para realizar este juego y sus opciones, primero implemente un menú de inicio explicando los controles necesarios para jugar y como pausar la partida mediante la tecla ‘p’ o ‘P’.

A continuación, una vez en la partida de Pong observamos las paletas de los dos jugadores de dos colores distintos (‘cyan’ y ‘ocre’). Para dichas paletas se ha llamado a la función rect() para crearlas, así como a la pelota se utiliza la función ellipse(), tanto para el saque inicial como cuándo haya un saque después de un gol será con un movimiento aleatorio mediante la función random(), con la diferencia que con el saque de gol estará en el campo del jugador que ha recibido el gol.

Se ha elegido dos colores llamativos para ambos jugadores para que haya un mayor contraste con el negro como a los marcadores de los goles de cada jugador con sus respectivos colores. Sin embargo, a la pelota se le ha dado un color más neutro en comparación de los colores de los jugadores.
También se han incluido una serie de sonidos para el choque de las paletas respecto a la bola, así como cuando se mete gol.

![Ejemplo de partida de Pong](/pong_example.gif "Ejemplo de partida de Pong")

## Organización del código

<p style=”text-align: justify;”>Primero establecemos unas variables globales: para la posición de la bola y su movimiento en el ejeX y ejeY, así como las posiciones de las paletas y su tamaño, necesitaremos obtener sus coordenadas. También, establecemos como globales los valores de los marcadores, así como dos variables booleanas que se activará cuando se pausa la partida o se marca un gol para que haya un nuevo saque inicial.</p>


En la función setup() establecemos el tamaño de la pantalla, y diversos valores de las variables globales como son coordenadas de los jugadores y la bola, como cargamos los sonidos correspondientes.

A partir de la función draw() llamaremos a una serie de funciones que explicamos su utilidad:

- **pantallaInicio():** Con este función, se mostrará el menú de pausa e inicial donde se explica los controles de teclado para jugar.

-	**posicionesSaquePlayer():** En caso de gol, las paletas de los jugadores vuelven a su posición inicial en el medio del ejeY para que no tenga ningún tipo de dificultad al procederse con el saque de partida.

-	**keyPressed():** Cuando se pulsa las teclas de los jugadores (teclas UP-DOWN o teclas ‘s’-‘w’) se cambian las coordenadas del ejeY de las paletas. Sin embargo, con la tecla ‘P’ se procede a empezar una partida cambiando la variable booleana ‘pausaGame’ o a pausar una partida. 

-	**keyReleased():** Al dejar de presionar una tecla, se queda en la posición actual las paletas correspondientes.

-	**controlPlayers():** Para que las paletas de los jugadores no se sobresalgan de la pantalla, existe una serie de controles tanto por la zona superior e inferior para que se visualice por pantalla.

-	**controlBall():** Comprobamos si la bola colisiona con algunas de las paredes. En caso de que colisione con la pared superior o inferior, simplemente cambia las coordenadas invirtiendo el símbolo de la coordenada del movimiento de la pelota. Si choca contra la pared de la derecha o izquierda, significa que se ha producido un gol, por lo que habrá que empezar un nuevo saque inicial.

-	**detectBallByPlayer():** Cuando la pelota choca contra una de las paletas de los jugadores, el movimiento de la pelota cambia su dirección dirigiéndose hacia el otro campo del rival.

-	**marcador():** Sitúa un marcador en la zona superior de la pantalla indicando cuantos goles lleva cada jugador.

-	**mitadCampo():** Dibuja la línea discontinua en la mitad de la pantalla que hacer una separación entre ambos campos de cada jugador.

## Descarga e instalación
Para poder probar MyPong es necesario descargar todos los archivos del repositorio debido a que la carpeta Data contiene las fuentes de las letras utilizadas y los archivos *.wav son los sonidos correspondientes del juego.
