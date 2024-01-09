/*
 *    Classe Fletxa, usada per dibuixar les fletxes, l'oscil·lació i l'efecte d'electricitat que surten d'elles en el nivell 3 de l'activitat 1.
 */

class Fletxa { 

  // Es declaren unes variables locals  
  float posX1Triang, posY1Triang, posX2Triang, posY2Triang, posX3Triang, posY3Triang;
  color colorInt;
  // Variables per controlar l'ocil·lació de les fletxes de colors 
  float A;                    // Amplitud de l'oscil·lació.
  float T;                    // Període de l'oscil·lació (oscil·lació completa).
  float puntMigOscila;        // Centre de la vibració o oscil·lació.
  float temps;                // Temps que transcorre

  // Es crea un constructor amb 7 arguments:
  Fletxa (float x1, float y1, float x2, float y2, float x3, float y3, color col ) {  
    posX1Triang = x1;
    posY1Triang = y1;
    posX2Triang = x2;
    posY2Triang = y2;
    posX3Triang = x3;
    posY3Triang = y3;
    colorInt= col;
    A = 30.0;            
    T = 5.0;             
    puntMigOscila = 60;  
    temps = 0.0;
  } 

  //  Mètode per dibuixar les fletxes
  void dibuixar() {
    strokeJoin(ROUND);                           // Estil de junta amb un arc arrodonit 
    strokeWeight(6);                             // Mida de traç
    stroke(40);                                  // Color de traç         
    fill(colorInt);                              // Color de farciment
    ellipse(posX3Triang, posY3Triang, 50, 50);   // Dibuix d'una el·lipse
    triangle(posX1Triang, posY1Triang, posX2Triang, posY2Triang, posX3Triang, posY3Triang); // Dibuix d'un triangle
    noStroke();                                  // Sense traç
    ellipse(posX3Triang, posY3Triang, 44, 44);   // Dibuix d'una el·lipse
    textSize(40);                                // Mida del text
    fill(40);                                    // Color de farciment
    text(movRestants, posX3Triang, posY3Triang); // Dibuix d'un text
  }

  void oscilacio() {
    // ANIMACIÓ/MOVIMENTS DE LES FLETXES segons un MOAS en l'eix Y o X (moviments en un angle de 90º respecte a l'eix X o Y, segons les fletxes)
    // FLETXA ESQUERRA:   
    fletxaEsquerra.posX1Triang = puntMigOscila + A*sin(2*PI*temps/T) ;                // Posició per l'eix de les X d'un vèrtex de la fletxa segons un MOAS.
    fletxaEsquerra.posX2Triang = puntMigOscila + A*sin(2*PI*temps/T) ;                // Posició per l'eix de les X d'un vèrtex de la fletxa segons un MOAS.
    fletxaEsquerra.posX3Triang = 125 +puntMigOscila + A*sin(2*PI*temps/T) ;           // Posició per l'eix de les X d'un vèrtex de la fletxa segons un MOAS.
    // FLETXA SUPERIOR:   
    fletxaSuperior.posY1Triang = puntMigOscila + A*sin(2*PI*temps/T) ;                // Posició per l'eix de les Y d'un vèrtex de la fletxa segons un MOAS.
    fletxaSuperior.posY2Triang = puntMigOscila + A*sin(2*PI*temps/T) ;                // Posició per l'eix de les Y d'un vèrtex de la fletxa segons un MOAS.
    fletxaSuperior.posY3Triang = 125 +puntMigOscila + A*sin(2*PI*temps/T) ;           // Posició per l'eix de les Y d'un vèrtex de la fletxa segons un MOAS.
    // FLETXA DRETA:   
    fletxaDreta.posX1Triang = width-puntMigOscila + A*sin(2*PI*temps/T + PI) ;        // Posició per l'eix de les X d'un vèrtex de la fletxa segons un MOAS (s'ha afegit un desfase PI, per si en algun moment es desenvolupa un nivell en què han de sortir diverses fletxa alhora, així totes tindran una oscil·lació compensada).
    fletxaDreta.posX2Triang = width-puntMigOscila + A*sin(2*PI*temps/T + PI) ;        // Posició per l'eix de les X d'un vèrtex de la fletxa segons un MOAS (s'ha afegit un desfase PI).
    fletxaDreta.posX3Triang = width-125-puntMigOscila + A*sin(2*PI*temps/T + PI) ;    // Posició per l'eix de les X d'un vèrtex de la fletxa segons un MOAS (s'ha afegit un desfase PI).
    // FLETXA INFERIOR:   
    fletxaInferiro.posY1Triang = height-puntMigOscila + A*sin(2*PI*temps/T + PI) ;    // Posició per l'eix de les Y d'un vèrtex de la fletxa segons un MOAS (s'ha afegit un desfase PI).
    fletxaInferiro.posY2Triang = height-puntMigOscila + A*sin(2*PI*temps/T + PI) ;    // Posició per l'eix de les Y d'un vèrtex de la fletxa segons un MOAS (s'ha afegit un desfase PI).
    fletxaInferiro.posY3Triang = height-125-puntMigOscila + A*sin(2*PI*temps/T + PI) ;// Posició per l'eix de les Y d'un vèrtex de la fletxa segons un MOAS (s'ha afegit un desfase PI).

    // Augmentem el "temps" incrementant valors amb la variable temps. (no és temps sinó els cops que triga a tornar a executar el codi).
    temps = temps+0.1;
  }

  // Mètode per dibuixar unes cordes elèctriques entre les fletxes i els talps.
  void electre() {    

    stroke(colorInt);     // Color del Traç
    strokeWeight(4);      // Gruix de traç           
    noFill();             // Sense farciment

    // Dibuixem quatre Corbes de Bézier entre les fletxes i els talps, amb els control points aleatoris, però restringits per donar un efecte de corda vibrant 
    bezier(posX3Triang, posY3Triang, posX3Triang+random(300), posY3Triang+random(300), posX3Triang-random(300), posY3Triang-random(300), talp[0].posX, talp[0].posY);
    bezier(posX3Triang, posY3Triang, posX3Triang+random(300), posY3Triang+random(300), posX3Triang-random(300), posY3Triang-random(300), talp[0].posX, talp[0].posY);
    bezier(posX3Triang, posY3Triang, posX3Triang+random(300), posY3Triang+random(300), posX3Triang-random(300), posY3Triang-random(300), talp[0].posX, talp[0].posY);
    bezier(posX3Triang, posY3Triang, posX3Triang+random(300), posY3Triang+random(300), posX3Triang-random(300), posY3Triang-random(300), talp[0].posX, talp[0].posY);

    noStroke();                                   // Sense traç
    fill(random(255), random(255), random(255));  // Color de farciment totalment aleatori i canviant
    circle(talp[0].posX, talp[0].posY, 100);      // Dibuix d'un cercle

    // Canvi de colors aleatoris però mantenint bastant el component de color principal de cada fletxa 
    fletxaEsquerra.colorInt = color(random(200, 255), random(91), random(77));
    fletxaSuperior.colorInt = color(random(125), random(145, 200), random(80));
    fletxaDreta.colorInt = color(random(95), random(160), random(165, 220));
    fletxaInferiro.colorInt = color (random(195, 250), random(150, 250), random(77));

    // Reproducció d'un efecte de so. 
    electra.play();     
   
  }
}
