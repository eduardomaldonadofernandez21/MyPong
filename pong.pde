import processing.sound.*;


//Variables globales:
//Posición de la pelota
float posXball=0;
float posYball=50;

//Coordenadas de las posiciones de los jugadores
float x1=15;
float y1=0;
float x2=0;
float y2=0;

//Diametro de la bola
int D=30;
//Movimiento de la bola
float mov_x=5;
float mov_y=-5;
//Anchura y altura de las paletas de los jugadores
int ancho=20;
int alto =80;
//Goles del marcador
int golesPlayer1=0;
int golesPlayer2=0;

//Sonidos para la partida
SoundFile sonidoGol;
SoundFile sonidoPlayer;
//Booleano para cuando se sacar
boolean saqueInicial= false;
//Boolean para pausar el partido o pantalla inicial
boolean pausaGame = true;

void setup ( ) {
  size(600 ,600);
  //Posiciones de los jugadores
  x1=15;
  y1=height/2;
  x2=565;
  y2=height/2;
  //Posición de la pelota
  posXball=int(random(100,500));
  posYball=int(random(100,500));
  //Sonido gol descargado
  sonidoGol = new SoundFile ( this , "gol.wav" );
  //Sonido paleta golpeando pong
  sonidoPlayer = new SoundFile ( this , "paleta.wav" );
}

void draw ( ) {
  if(pausaGame){
    pantallaInicio();
    keyPressed();
  }else{
    if(saqueInicial){
      delay(2000);
      saqueInicial=false;
      posicionesSaquePlayers();
    }
    background (0) ;
    mitadCampo();
    controlPlayers();
    //jugador 1
    fill(3, 252, 248);
    rect(x1, y1, ancho, alto);
    //jugador 2
    fill(252, 186, 3);
    rect(x2, y2, ancho, alto);
    //Posición de la pelota
    posXball=posXball+mov_x;
    posYball =posYball+mov_y;
    keyPressed();
    //Controlamos la pelota en caso de gol o rebotes
    controlBall();
    //En caso de que algún jugador toque la pelota
    detectBallByPlayer();
    //Marcador de los goles;
    marcador();
    //Bola
    fill(255, 179, 255);
    ellipse(posXball , posYball ,D,D);
  }
}

void keyPressed(){
  if(keyPressed == true){
    //Las teclas w y s es el jugador 1
    if(key == 'w' || key == 'W'){
      y1=y1-8;
    }
    if(key == 's' || key == 'S'){
      y1=y1+8;
    }
    if(key == 'P' || key == 'p'){
        delay(150);
        pausaGame=!pausaGame;
    }
    //Las teclas UP y DOWN es el jugador 2
    if(key == CODED){
      if(keyCode == UP){
        y2=y2-8;
      }
      if(keyCode == DOWN){
        y2=y2+8;
      }
    }
  }
}

void keyReleased(){
  //Las teclas w y s es el jugador 1
  if(key == 'w' || key == 'W'){
    y1=y1;
  }
  if(key == 's' || key == 'S'){
    y1=y1;
  }
  //Las teclas UP y DOWN es el jugador 2
  if(key == CODED){
    if(keyCode == UP){
      y2=y2;
    }
    if(keyCode == DOWN){
      y2=y2;
    }
  }
}

void controlPlayers(){
  /*Comprobamos que las paletas de los jugadores
  no se salgan de la pantalla */
  if((y1+alto/2) > height){ //En el caso de que sobresalga por abajo el jugador 1
    y1 = height-(alto/2);
  }
  
  if((y1-alto/10) <0){ //En el caso de que sobresalga por arriba el jugador 1
    y1 = alto/10;
  }
  
  if((y2+alto/2) > height){ //En el caso de que sobresalga por abajo el jugador 2
    y2 = height-(alto/2);
  }
  
  if((y2-alto/10) <0){ //En el caso de que sobresalga por arriba el jugador 2
    y2 = alto/10;
  }
}

void controlBall(){
  /*Comprobamos si la pelota colisiona 
  con alguna pared*/ 
  if (posXball > width ) { //En el caso de que se salga la pelota por la derecha
    golesPlayer2 = golesPlayer2 + 1;
    sonidoGol.play();
    fill(3, 252, 248);
    text("¡¡¡GOOOL!!",225,500);
    saqueInicial = true;
    posXball = (width/2);
    posYball = (random(100,500));
  }
  if( posYball > height ) { //En el caso de que se salga la pelota por abajo
    posYball = height ;
    mov_y = -mov_y;
  }
  if ( posXball < 0 ) { //En el caso de que se salga la pelota por la izquierda
    golesPlayer1 = golesPlayer1 + 1;
    sonidoGol.play();
    saqueInicial = true;
    posXball = (width/2);
    posYball = (random(100,500));
    fill(252, 186, 3);
    text("¡¡¡GOOOL!!",375,500);
  }
  if ( posYball < 0 ) { //En el caso de que se salga la pelota por arriba
    posYball = 0;
    mov_y = -mov_y;
  }
}

void detectBallByPlayer(){
  /* Comprobamos cuando existe una colisión con las paletas en el lado derecho o izquierdo
  de la pantalla*/
  //if((posXball-D/2) < (x1+ancho/2) && posYball > (y1-alto/2) && posYball < (y1+alto/2)){
  if((y1<= posYball+D/2) && posYball-D/2 <= y1+alto  && x1 <= posXball+D/2 && posXball-D/2 <= x1+ancho){  //Cuando el jugador 1 toca la pelota tiene que rebotar
    sonidoPlayer.play();
    mov_x = -mov_x ;
  }
  
  //if((posXball+D/2) > (x2-ancho/2) && posYball > (y2-alto/2) && posYball < (y2+alto/2)){  
  if((y2<= posYball+D/2) && posYball-D/2 <= y2+alto  && x2 <= posXball+D/2 && posXball-D/2 <= x2+ancho){  //Cuando el jugador 2 toca la pelota tiene que rebotar
    sonidoPlayer.play();
    mov_x = -mov_x ;
  }
}

void mitadCampo(){
  for (int i = 0; i<height; i=i+40){
    fill(255);
    rect(width/2, i, 5,15);
  }
}

void posicionesSaquePlayers(){
  x1=15;
  y1=height/2;
  x2=565;
  y2=height/2;
}

void marcador(){
  PFont font; // Declarar la variable
  font = loadFont("Calibri-48.vlw");
  textFont(font);
  textSize(50);
  textAlign(CENTER);
  fill(252, 186, 3);
  text(golesPlayer1, width/2+40, 80);
  fill(3, 252, 248);
  text(golesPlayer2, width/2-40, 80); 
  textSize(20);
  fill(252, 186, 3);
  text("Jugador 1 ",width/2+55, 30);
  fill(3, 252, 248);
  text("Jugador 2 ",width/2-45, 30);
}

void pantallaInicio(){
  background (0) ;
  textSize(100);
  textAlign(CENTER);
  PFont font; // Declarar la variable
  font = loadFont("InkFree-48.vlw");
  textFont(font);
  fill(255);
  text("Pong: The game", 300,100);
  textSize(25);
  textAlign(CENTER);
  text("*Para empezar la partida pulse la tecla P", 300, 300);
  textAlign(CENTER);
  text("*Jugador 1: Tecla UP-DOWN", 300, 330);
  text("*Jugador 2: Tecla W-S", 300, 360);
  text("Si desea pausar la partida pulse P \ny para renaudar el juego",300, 400);
  textSize(20);
  text("By Eduardo Maldonado",100,550);

}
