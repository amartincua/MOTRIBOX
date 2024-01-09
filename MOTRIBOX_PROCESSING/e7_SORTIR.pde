/*
 *    FUNCIÓ DE L'ESTAT 6: EXXIT. Mostra els crèdits i finalitza el programa.
 */

void sortir() { 

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

  imageMode(CENTER);                     // Canvi d'ubicació des d'on es dibuixen les imatges, ara des del centre.
  pushMatrix();                          // Funció que recorda l'últim sistema de coordenades.
  translate(width/2, 300);               // Translació en x i y de la imatge del logo.
  scale(0.8);                            // S'escala la imatge del logo.
  image (logo, 0, 0);                    // Es dibuixa la imatge del logo.
  popMatrix();                           // Funció que restableix el sistema de coordenades.
  imageMode(CORNER);                     // Canvi d'ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra de la imatge, per no afectar la resta d'imatges.


  textSize(50);                                                                // Mida del text
  fill(66, 33, 11);                                                            // Color de farciment 
  text("ALEIX MARTÍN", width/2, height/2+50);                                  // Dibuix d'un text
  text("- 2024 -", width/2, height/2+130);                                     // Dibuix d'un text
  textSize(40);                                                                // Mida del text
  text("TGF: Sistema tangible, interactiu i educatiu", width/2, height/2+250); // Dibuix d'un text
  textSize(30);                                                                // Mida del text
  text("Universitat Oberta de Catalunya", width/2, height/2+400);              // Dibuix d'un text

  // CONTROL DEL TEMPS TRANSCORREGUT ABANS DE TANCAR EL PROGRAMA:
  timer6segons.start(true);                        // Es posa el cronòmetre en marxa perquè pugui comptar el temps.
  timer6segons.update(clock.getDeltaMillis());     // S'actualitza el valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
  if (timer6segons.getFinish()) {                  // Si els 6 segons ja han passat, aleshores:
    exit();                                        // Se surt del programa
  }
}
