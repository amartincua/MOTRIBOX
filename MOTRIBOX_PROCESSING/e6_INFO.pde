/*
 *    FUNCIÓ DE L'ESTAT 6: INFO. Mostra els informes de les activitats practicades.
 */

void info() {  

  // Es dibuixa una imatge de fons d'un cel. 
  image (fonsCel, 0, 0);                

  // DIBUIX DELS NÚVOLS (Es crida el mètode per dibuixar els núvols).
  nuvol1.dibuixar(); 
  nuvol2.dibuixar(); 
  nuvol3.dibuixar(); 
  nuvol4.dibuixar(); 
  nuvol5.dibuixar(); 

  // ANIMACIÓ DELS NÚVOLS (Es crida el mètode per animar els núvols).
  nuvol1.animacioNuvols(); 
  nuvol2.animacioNuvols(); 
  nuvol3.animacioNuvols(); 
  nuvol4.animacioNuvols(); 
  nuvol5.animacioNuvols(); 

  // Es dibuixa la imatge del panell de configuració. 
  image (panellInfo, 0, 0);   

  // TÍTOL
  fill(255, 230, 160);                              // Color de farciment 
  textSize(50);                                     // Mida del text
  text("Informe d'última sessió", width/2, 170);    // Dibuix d'un text

  // SUBTÍTOLS 1
  pushMatrix();                        // Funció que recorda l'últim sistema de coordenades.
  translate(width/4, 325);             // Translació en x i y del text.
  textSize(40);                        // Mida del text
  text("ACTIVITAT 1", 130, 0);         // Dibuix d'un text
  textSize(30);                        // Mida del text
  text("Errades", -45, 90);            // Dibuix d'un text
  text("TEMPS", 0, 240);               // Dibuix d'un text
  text("PUNTUACIÓ", 260, 240);         // Dibuix d'un text
  textSize(20);                        // Mida del text
  text("MILLOR TEMPS"+"“", 0, 390);    // Dibuix d'un text
  text("PUNTUACIÓ MÀX", 260, 390);     // Dibuix d'un text
  popMatrix();                         // Funció que restableix el sistema de coordenades.

  // DADES ACTIVITAT 1
  rectMode(CORNER);                                                   // Modificació de la ubicació des d'on es dibuixen els rectangles, ara des de la cantonada superior esquerra. 
  fill(255, 105, 60);                                                 // Color de farciment
  rect(385, 451, map(erradesActiv1temp, 0, 100, 0, 457), 40, 2);      // Dibuix d'una barra que representa el % d'errors.
  fill(255, 230, 160);                                                // Color de farciment
  textSize(30);                                                       // Mida del text
  textAlign(LEFT, CENTER);                                            // Alineació del text a l'esquerra i al centre.
  text(int(erradesActiv1temp) + "%", 391, 470);                       // Dibuix del valor d'una variable    
  textAlign(CENTER, CENTER);                                          // Alineació horitzontal i vertical del text al centre.
  pushMatrix();                        // Funció que recorda l'últim sistema de coordenades.
  translate(width/4, 325);             // Translació en x i y del text.
  textSize(40);                        // Mida del text
  text(tempsACTIV1+"“", 0, 295);       // Dibuix del valor d'una variable
  text(puntuacioACTIV1temp, 260, 295); // Dibuix del valor d'una variable
  textSize(30);                        // Mida del text
  text(toptempsACTIV1+"“", 0, 430);    // Dibuix del valor d'una variable
  text(maxPuntuacioACTIV1, 260, 430);  // Dibuix del valor d'una variable
  popMatrix();                         // Funció que restableix el sistema de coordenades.

  // SUBTÍTOLS 2  
  pushMatrix();                        // Funció que recorda l'últim sistema de coordenades.
  translate(width/2+215, 325);         // Translació en x i y del text.
  textSize(40);                        // Mida del text
  text("ACTIVITAT 2", 130, 0);         // Dibuix d'un text
  textSize(30);                        // Mida del text
  text("Errades", -45, 90);            // Dibuix d'un text
  text("TEMPS", 0, 240);               // Dibuix d'un text
  text("PUNTUACIÓ", 260, 240);         // Dibuix d'un text
  textSize(20);                        // Mida del text
  text("MILLOR TEMPS"+"“", 0, 390);    // Dibuix d'un text
  text("PUNTUACIÓ MÀX", 260, 390);     // Dibuix d'un text
  popMatrix();                         // Funció que restableix el sistema de coordenades.

  // DADES ACTIVITATS 2
  rectMode(CORNER);                                                   // Modificació de la ubicació des d'on es dibuixen els rectangles, ara des de la cantonada superior esquerra. 
  fill(255, 105, 60);                                                 // Color de farciment
  rect(1079, 451, map(erradesActiv2temp, 0, 100, 0, 457), 40, 2);     // Dibuix d'una barra que representa el % d'errors.
  fill(255, 230, 160);                                                // Color de farciment
  textSize(30);                                                       // Mida del text
  textAlign(LEFT, CENTER);                                            // Alineació del text a l'esquerra i al centre.
  text(int(erradesActiv2temp) + "%", 1085, 470);                      // Dibuix del valor d'una variable    
  textAlign(CENTER, CENTER);                                          // Alineació horitzontal i vertical del text al centre.
  pushMatrix();                                                       // Funció que recorda l'últim sistema de coordenades.
  translate(width/2+215, 325);                                        // Translació en x i y del text.
  textSize(40);                                                       // Mida del text  
  text(tempsACTIV2+"“", 0, 295);                                      // Dibuix del valor d'una variable
  text(puntuacioACTIV2temp, 260, 295);                                // Dibuix del valor d'una variable
  textSize(30);                                                       // Mida del text 
  text(toptempsACTIV2+"“", 0, 430);                                   // Dibuix del valor d'una variable
  text(maxPuntuacioACTIV2, 260, 430);                                 // Dibuix del valor d'una variable
  popMatrix();                                                        // Funció que restableix el sistema de coordenades.


  // RETORN AL MENÚ TOT ACTIVANT AL MATEIX TEMPS EL SENSOR D'ULTRASONS SUPERIOR I INFERIOR:
  // En cas de tenir senyal en el sensor ultrasons superior i inferior, aleshores:
  if (s1 > 0 && s3 > 0) {
    // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
    timer0_7segons.start (true);
    // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
    timer0_7segons.update(clock.getDeltaMillis());

    // Si els 0,7 segons ja han passat, aleshores:
    if (timer0_7segons.getFinish()) {     
      retorn.rewind();             // Es rebobina l'efecte de so perquè torni al principi.
      retorn.play();               // Reproducció de l'efecte de so.
      timer0_7segons.reset();      // Reinici del cronòmetre.
      mainStateAnterior = INFO;    // Es guarda l'estat actual com anterior.
      mainState =  MENU;           // Anem a l'estat del Menú
    }
  }
}
