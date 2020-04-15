//John Jairo Riaño Martinez
/*
INSTRUCCIONES v: 
 Demora un poco en iniciar por el sonido que agregue pero no vi mas errores 
 -Click derecho lineas horizontales  |
 -Click izquierdo lineas verticales  --
 
 */
/*El tamaño del tablero se modifica cambiando los valores en la funcion size siempre y cuando se cumplan los limites establecidos*/

import ddf.minim.*;
Minim soundengine;
AudioSample sonido1;
AudioSample sonido2;
void setup() {
  size(220, 120); // LIMITES WIDTH DEBE SER MAYOR POR 100 A HEIGHT Y HEIGHT NO DEBE SER MENOR A 100 Y AMBOS DEBEN SER MULTIPLOS DE 20 PA QUE SE VEA BIEN :V
  //  stroke(0);
  //  strokeWeight(5);
  background(51, 240, 255);
  int a = width;
  int b = height;
  int[][] lineas = new int[a][b];
  int[][] cuadro = new int[a][b];
  int[][] cuadros = new int[a][b];
  for (int i=20; i<=width-120; i+=20) {
    for (int j=20; j<=height-20; j+=20) {
      point(i, j);
    }
  }
  for (int i=0; i<a; i++) {
    for (int j=0; j<b; j++) {
      lineas[i][j] = 0;
    }
  }
  soundengine = new Minim(this);
  sonido1 = soundengine.loadSample("GameOver.mp3", 1024);
  sonido2 = soundengine.loadSample("mario.mp3", 1024);
  sonido2.trigger();
}
// declarando matrices y variables globales
int[][] lineas = new int[500][500];
int[][] cuadros = new int[500][500];
int[][] cuadro = new int[500][500];
boolean turno = true;
int puntaje1, puntaje2;


//funcion aprox la cual aproxima a un multiplo de 20
int aprox(int coor) {
  int output = coor + (20 - (coor % 20));
  return output;
}

// funcion vacio que devuelve true si ya hay una linea 
boolean vacio(int a, int b) {
  if (lineas[a][b] == -1 || lineas[a][b] == 1 || lineas[a][b] == -2 || lineas[a][b] == 2 ) {
    return true;
  } else {
    return false;
  }
}
// funcion cuadro vertical que devuelve un entero si se ha creado un cuadro respecto a al condicion
int cuadrov(int a, int b) {
  if ((cuadro[a-30][b+30] == 1 && cuadro[a-10][b+30] == 1 && cuadro[a][b+20] == 1) && (cuadro[a-30][b+10] == 1 && cuadro[a-10][b+10] == 1 && cuadro[a][b-20] == 1)) {
    return 2;
  } else if ((cuadro[a-30][b+10] == 1 && cuadro[a-10][b+10] == 1) && cuadro[a][b-20] == 1) {
    return 1;
  } else if ((cuadro[a-30][b+30] == 1 && cuadro[a-10][b+30] == 1) && cuadro[a][b+20] == 1) {
    return -1;
  } else {
    return 0;
  }
} 
// funcion cuadro horizontal que devuelve un entero si se ha creado un cuadro respecto a al condicion
int cuadroh(int a, int b) {
  if ((cuadro[a+30][b-30] == 1 && cuadro[a+30][b-10] == 1 && cuadro[a+20][b] == 1) && (cuadro[a+10][b-30] == 1 && cuadro[a+10][b-10] == 1 && cuadro[a-20][b] == 1)) {
    return 2;
  } else if ((cuadro[a+10][b-30] == 1 && cuadro[a+10][b-10] == 1 && cuadro[a-20][b] == 1)) {
    return 1;
  } else if ((cuadro[a+30][b-30] == 1 && cuadro[a+30][b-10] == 1 && cuadro[a+20][b] == 1)) {
    return -1;
  } else {
    return 0;
  }
} 
// se crea la tabla de juego (en este caso los´puntos)
void tabla() {
  stroke(1);
  strokeWeight(4);
  background(51, 240, 255);
  for (int i=20; i<=height-20; i+=20) {
    for (int j=20; j<=width-120; j+=20) {
      point(i, j);
    }
  }
  strokeWeight(0);
  line(width-100, 0, width-100, height);
}
// se llena las coordenadas de las lineas hechas y cuadros creados respecto a las condiciones
void mousePressed() {
  if (turno == true) {
    if (mouseX <= width-119 && mouseY <= height-19 && mouseX >= 20 && mouseY >= 20) {
      strokeWeight(5);
      stroke(172, 255, 51);
      if (mouseButton == LEFT) {
        if (vacio(aprox(mouseX)+10, aprox(mouseY-20))== false) {
          // line(aprox(mouseX), aprox(mouseY-20), aprox(mouseX-20), aprox(mouseY-20));
          lineas[aprox(mouseX)+10][aprox(mouseY-20)] = -1;
          cuadro[aprox(mouseX)+10][aprox(mouseY-20)] = 1;
          if (cuadrov(aprox(mouseX)+10, aprox(mouseY-20)) == 1) {
            turno = true;
            puntaje1 +=1;
            cuadros[aprox(mouseX)-10][aprox(mouseY-20)-10] = 1;
          } else if (cuadrov(aprox(mouseX)+10, aprox(mouseY-20)) == -1) {
            turno = true;
            puntaje1 +=1;
            cuadros[aprox(mouseX)-10][aprox(mouseY-20)+10] = 1;
          } else if (cuadrov(aprox(mouseX)+10, aprox(mouseY-20)) == 2) {
            turno = true;
            puntaje1 +=2;
            cuadros[aprox(mouseX)-10][aprox(mouseY-20)-10] = 1;
            cuadros[aprox(mouseX)-10][aprox(mouseY-20)+10] = 1;
          } else {
            turno=false;
          }
        }
      } else if (mouseButton == RIGHT) {
        if (vacio(aprox(mouseX-20), aprox(mouseY)+10) == false ) {
          //   line(aprox(mouseX-20), aprox(mouseY), aprox(mouseX-20), aprox(mouseY-20));
          lineas[aprox(mouseX-20)][aprox(mouseY)+10] = 1;
          cuadro[aprox(mouseX-20)][aprox(mouseY)+10] = 1;
          if (cuadroh(aprox(mouseX-20), aprox(mouseY)+10)== 1) {
            turno = true;
            puntaje1 +=1;
            cuadros[aprox(mouseX-20)-10][aprox(mouseY)-10]=1;
          } else if (cuadroh(aprox(mouseX-20), aprox(mouseY)+10) == -1) {
            turno = true;
            puntaje1 +=1;
            cuadros[aprox(mouseX-20)+10][aprox(mouseY)-10]=1;
          } else if (cuadroh(aprox(mouseX-20), aprox(mouseY)+10)== 2) {
            turno = true;
            puntaje1 +=2;
            cuadros[aprox(mouseX-20)-10][aprox(mouseY)-10]=1;
            cuadros[aprox(mouseX-20)+10][aprox(mouseY)-10]=1;
          } else {
            turno=false;
          }
        }
      };
    }
  } else {
    strokeWeight(5);
    stroke(255, 51, 51);
    if (mouseButton == LEFT) {
      if (vacio(aprox(mouseX)+10, aprox(mouseY-20)) == false) {
        //line(aprox(mouseX), aprox(mouseY-20), aprox(mouseX-20), aprox(mouseY-20));
        lineas[aprox(mouseX)+10][aprox(mouseY-20)] = -2;
        cuadro[aprox(mouseX)+10][aprox(mouseY-20)] = 1;
        if (cuadrov(aprox(mouseX)+10, aprox(mouseY-20))== 1) {
          turno = false;
          puntaje2 +=1;
          cuadros[aprox(mouseX)-10][aprox(mouseY-20)-10] = 2;
        } else if (cuadrov(aprox(mouseX)+10, aprox(mouseY-20)) == -1) {
          turno = false;
          puntaje2 +=1;
          cuadros[aprox(mouseX)-10][aprox(mouseY-20)+10] = 2;
        } else if (cuadrov(aprox(mouseX)+10, aprox(mouseY-20))== 2) {
          turno = false;
          puntaje2 +=2;
          cuadros[aprox(mouseX)-10][aprox(mouseY-20)-10] = 2;
          cuadros[aprox(mouseX)-10][aprox(mouseY-20)+10] = 2;
        } else {
          turno = true;
        }
      }
    } else if (mouseButton == RIGHT) {
      if (vacio(aprox(mouseX-20), aprox(mouseY)+10)== false ) {
        // line(aprox(mouseX-20), aprox(mouseY), aprox(mouseX-20), aprox(mouseY-20));
        lineas[aprox(mouseX-20)][aprox(mouseY)+10] = 2;
        cuadro[aprox(mouseX-20)][aprox(mouseY)+10] = 1;
        if (cuadroh(aprox(mouseX-20), aprox(mouseY)+10)== 1) {
          turno = false;
          puntaje2 +=1;
          cuadros[aprox(mouseX-20)-10][aprox(mouseY)-10]=2;
        } else if (cuadroh(aprox(mouseX-20), aprox(mouseY)+10)== -1) {
          turno = false;
          puntaje2 +=1;
          cuadros[aprox(mouseX-20)+10][aprox(mouseY)-10]=2;
        } else if (cuadroh(aprox(mouseX-20), aprox(mouseY)+10)== 2) {
          turno = false;
          puntaje2 +=2;
          cuadros[aprox(mouseX-20)-10][aprox(mouseY)-10]=2;
          cuadros[aprox(mouseX-20)+10][aprox(mouseY)-10]=2;
        } else {
          turno = true;
        }
      }
    }
  }
}
// muestra en el juego los puntajes de los jugadores
void tabla_puntaje() {
  textSize(30);
  //rect(width-100,90,25,25);
  fill(230, 126, 34);
  text("Score", width-90, 30);
  textSize(20);
  fill(34, 153, 84  );
  //rect();
  text("J1", width-90, 60);
  text(puntaje1, width-50, 60);
  textSize(20);
  fill(255, 51, 51);
  text("J2", width-90, 90);
  text(puntaje2, width-50, 90);
}
//numero de cuadros en total del juego dependiente del tamaño de la pantalla
int num_cuadros() {
  int num;
  num = (((height-40)/2)/10)*(((height-40)/2)/10);
  return num;
}
// funcion end returna true si se han hecho todos los cuaros posibles en el juego por ende si finaliza
boolean end(int a, int b) {
  int cont =0;
  for (int k =0; k<=a; k++) {
    for (int j=0; j<=b; j++) {
      if (cuadros[k][j] == 1 || cuadros[k][j]==2) {
        cont++;
      }
    }
  }
  if (cont == num_cuadros()) {
    return true;
  } else {
    return false;
  }
}

void draw() {
  tabla();                      //se crea el tablero de juego(puntos), aqui se encuentra el background
  tabla_puntaje();     //crea la ventana donde se muestra el puntaje de los jugadores y la actualiza
  int a = width-99;          //variables que determinan el tamño de ños arreglos necesarias para recorrerlos 
  int b = height+1;  

  //se recorren los arreglos donde se almacena la informacion de los cuadros hechos y lineas realizadas y las traza 
  for (int i=0; i<a; i++) {
    for (int j=0; j<b; j++) {
      if (lineas[i][j] == -1 ) {
        strokeWeight(4);
        stroke(172, 255, 51);
        line(i-10, j, i-30, j);
      } else if (lineas[i][j] == 1) {
        strokeWeight(4);
        stroke(172, 255, 51);
        line(i, j-10, i, j-30);
      } else if (lineas[i][j] == -2) {
        strokeWeight(4);
        stroke(255, 51, 51);
        line(i-10, j, i-30, j);
      } else if (lineas[i][j] == 2) {
        strokeWeight(4);
        stroke(255, 51, 51);
        line(i, j-10, i, j-30);
      } else if (cuadros[i][j] == 1) {
        rectMode(RADIUS);
        stroke(0);
        fill(172, 255, 51);
        rect(i, j, 7, 7, 5);
      } else if (cuadros[i][j] == 2) {
        rectMode(RADIUS);
        stroke(0);
        fill(255, 51, 51);
        rect(i, j, 7, 7, 5);
      }
    }
  }
  //serie de condiciones tras finalizar el total de cuadros posibles en el tablero
  if (end(a, b)==true) {
    sonido2.close();
    noLoop();
    background(255);
    textSize(30);
    //rect(width-100,90,25,25);
    fill(255, 0, 0);
    text("GAME--OVER", width/2-100, 30);
    if (puntaje1 < puntaje2) {
      text("J2 Winner ", width/2-80, 60);
      text("J1 Loser ", width/2-80, 90);
      sonido1.trigger();
    } else if (puntaje2 < puntaje1) {
      text(" J1 Winner ", width/2-80, 60);
      text(" J2 Loser ", width/2-80, 90);
      sonido1.trigger();
    } else {
      text("    TIE", width/2-80, height/2);      
      sonido1.trigger();
    }
  }
}
