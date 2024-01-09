/*
 *    Classe Boto, usada per dibuixar els diferents botons del programa i l'efecte hover, en funció de si el botó està o no seleccionat.
 */

class Boto { 

  // Es declaren unes variables locals  
  float posX;          // Posició x del botó.
  float posY;          // Posició y del botó.
  PImage imgbotoS;     // Imatge del botó seleccionada
  PImage imgbotoNoS;   // Imatge del botó no seleccionada.
  boolean select;      // Botó seleccionat? (variable booleana per anar canviat quina imatge del botó mostrar en cada moment).
  boolean augment;     // Augmentem el botó? (variable booleana per decidir si s'ha d'augmentar o no l'efecte hover).
  int midaHover;       // Mida de la imatge hover (com que és un quadrat, serveix tant per la seva amplada com altura).
  int midaMAXhover;    // Mida màxima d'ampliació per l'efecte hover.
  int midaMINhover;    // Mida mínima de reducció per l'efecte hover.

  // Es crea un constructor amb 6 arguments:
  Boto (float x, float y, PImage botoS, PImage botoNoS, boolean s, int hover) {  
    posX = x;
    posY = y;
    imgbotoS = botoS;
    imgbotoNoS = botoNoS;
    select = s;
    augment = true;
    midaHover = hover;
  } 

  // Mètode per dibuixar els botons.
  void dibuix() {    

    // Comprovació del valor de la variable booleana select (en funció del seu valor canviarem o no la imatge a mostrar), si select és true, aleshores:
    if (select) {       
      // Es dibuixa la imatge del botó seleccionada.
      image (imgbotoS, posX, posY);     
      // En cas contrari (select es false), aleshores:
    } else {
      // Es dibuixa la imatge del botó no seleccionada.
      image (imgbotoNoS, posX, posY);
    }
  }

  // Mètode per dibuixar i actualitzar l'efecte hover dels botons
  void animacioHover() {   

    if (mainState == 1) {
      // En cas de tenir el botó que ocupa la posició 0, 1 o 2 seleccionat, aleshores:
      if (botoActiuMENU == 0 || botoActiuMENU == 1  || botoActiuMENU == 2  ) {      
        midaMAXhover = 500;  // Mida màxima en amplada i altura serà de 500px 
        midaMINhover = 460;  // Mida mínima en amplada i altura serà de 460px 

        // En cas contrari si el botó que ocupa la posició 3 o 4 està seleccionat, aleshores:
      } else if (botoActiuMENU == 3 || botoActiuMENU == 4 ) {      
        midaMAXhover = 240;  // Mida màxima en amplada i altura serà de 240px 
        midaMINhover = 210;  // Mida mínima en amplada i altura serà de 210px
      }   

      // Si la variable augment és verdadera, aleshores:
      if (augment) {
        // Augmentem progressivament la mida del hover en 2px.
        midaHover += 2;
        // Si la mida del hover és superior o igual a la mida màxima del hover, aleshores:
        if (midaHover >= midaMAXhover) {
          // La variable augment, canvia de valor a false.
          augment = false;
        }

        // En cas contrari (la variable augment és falsa), aleshores:
      } else {
        // Disminuïm progressivament la mida del hover en 2px.
        midaHover -= 2;
        // Si la mida del hover és inferior o igual a la mida mínima del hover, aleshores:
        if (midaHover <= midaMINhover) {
          // La variable augment, canvia de valor a true.
          augment = true;
        }
      }

      // Es modifica la ubicació des d'on es dibuixen les imatges, ara des del centre.
      imageMode(CENTER);

      // En cas de tenir el botó que ocupa la posició 0, 1 o 2 seleccionat, aleshores:
      if (botoActiuMENU == 0 || botoActiuMENU == 1  || botoActiuMENU == 2  ) {
        // Dibuix de la imatge del hover1, en funció de diverses variables.  
        image (hover1, posX+225, posY+225, midaHover, midaHover); 

        // En cas contrari si el botó que ocupa la posició 3 o 4 està seleccionat, aleshores:
      } else if (botoActiuMENU == 3 || botoActiuMENU == 4 ) { 
        // Dibuix de la imatge del hover2, en funció de diverses variables.
        image (hover2, posX+100, posY+100, midaHover, midaHover);
      }

      // Es modifica la ubicació des d'on es dibuixen les imatges, ara des de la cantonada esquerra superior, per no afectar a la resta d'imatges.
      imageMode(CORNER);
    } else if (mainState == 2) {

      // En cas de tenir el botó que ocupa la posició 0, 1 o 2 seleccionat, aleshores:
      if (botoActiuCONFIG == 0 || botoActiuCONFIG == 1  || botoActiuCONFIG == 2  ) {      
        midaMAXhover = 390;  // Mida màxima en amplada i altura serà de 425px 
        midaMINhover = 360;  // Mida mínima en amplada i altura serà de 400px 

        // En cas contrari si el botó que ocupa la posició 3 està seleccionat, aleshores:
      } else if (botoActiuCONFIG == 3  ) {      
        midaMAXhover = 150;  // Mida màxima en amplada i altura serà de 175px 
        midaMINhover = 125;  // Mida mínima en amplada i altura serà de 150px
      }   

      // Si la variable augment és verdadera, aleshores:
      if (augment) {
        // Augmentem progressivament la mida del hover en 2px.
        midaHover += 2;
        // Si la mida del hover és superior o igual a la mida màxima del hover, aleshores:
        if (midaHover >= midaMAXhover) {
          // La variable augment, canvia de valor a false.
          augment = false;
        }

        // En cas contrari (la variable augment és falsa), aleshores:
      } else {
        // Disminuïm progressivament la mida del hover en 2px.
        midaHover -= 2;
        // Si la mida del hover és inferior o igual a la mida mínima del hover, aleshores:
        if (midaHover <= midaMINhover) {
          // La variable augment, canvia de valor a true.
          augment = true;
        }
      }

      // Es modifica la ubicació des d'on es dibuixen les imatges, ara des del centre.
      imageMode(CENTER);

      // En cas de tenir el botó que ocupa la posició 0, 1 o 2 seleccionat, aleshores:
      if (botoActiuCONFIG == 0 || botoActiuCONFIG == 1  || botoActiuCONFIG == 2  ) {
        // Dibuix de la imatge del hover1, en funció de diverses variables.  
        image (hover3, posX+170, posY+100, midaHover, midaHover/1.7); 

        // En cas contrari si el botó que ocupa la posició 3 està seleccionat, aleshores:
      } else if (botoActiuCONFIG == 3) { 
        // Dibuix de la imatge del hover2, en funció de diverses variables.
        image (hover4, posX+50, posY+50, midaHover, midaHover);
      }

      // Es modifica la ubicació des d'on es dibuixen les imatges, ara des de la cantonada esquerra superior, per no afectar a la resta d'imatges.
      imageMode(CORNER);
    }
  }
}
