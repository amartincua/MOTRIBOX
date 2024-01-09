/*
 *    FUNCIÓ DE L'ESTAT 0: BREU INTRODUCCIÓ PER PRESENTAR EL NOM DEL PROJECTE
 */

void intro() { 
  image (fonsIntro, 0, 0);                         // Es dibuixa una imatge de fons a partir de la funció image, tot indicant la posició en x i y.
  imageMode(CENTER);                               // Canvi d'ubicació des d'on es dibuixen les imatges, ara des del centre.
  pushMatrix();                                    // Funció que recorda l'últim sistema de coordenades.
  translate(width/2, height/2);                    // Translació en x i y de la imatge del logo.
  scale(escalaLogo);                               // S'esclala la imatge del logo en funció de la variable escalaLogo.
  image (logo, 0, 0);                              // Es dibuixa la imatge del logo.
  Ani.to(this, 15, "escalaLogo", 1, Ani.CIRC_OUT); // S'anima el valor de l'escalaLogo a través de la biblioteca Ani. 
  popMatrix();                                     // Funció que restableix el sistema de coordenades anterior.
  imageMode(CORNER);                               // Canvi d'ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra de la imatge, per no afectar la resta d'imatges.

  audiMotribox.play();                             // Es reprodueix un efecte de so (el nom del projecte)

  // CANVI D'ESTAT --> AL MENÚ PRINCIPAL 
  // Controlem el temps que ha passat:
  timer6segons.update(clock.getDeltaMillis());     // S'actualitza el valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
  if (timer6segons.getFinish()) {                  // Si els 6 segons ja han passat, aleshores: (Es comprova a través del valor de getFinish(), si el retorn de la funció és true, aleshores voldrà dir que han passat els 6 segons i per tant ja podem saltar al següent estat).
    mainState = MENU;                              // Es passa a l'estat MENU
    mainStateAnterior = INTRO;                     // Es guarda l'estat actual com anterior.
    timer6segons.reset();                          // Es reinicia el valor del cronòmetre
  }
}
