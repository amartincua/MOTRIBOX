/*
 *    Classe Nuvols, usada per dibuixar els núvols i animar-los.
 */

class Nuvols { 

  // Es declaren unes variables locals  
  float posX;          // Posició x del núvol.
  float posY;          // Posició y del núvol.
  PImage imgNuvol;     // Imatge del núvol.
  float velX;          // Velocitat en la component X.

  // Es crea un constructor amb 4 arguments:
  Nuvols (float x, float y, PImage img, float v) {  
    posX = x;
    posY = y;
    imgNuvol = img;
    velX = v;
  } 

  //  Mètode per dibuixar els núvols.
  void dibuixar() {    
    // Dibuix de la imatge del núvol a una posició en x i y en funció d'unes variables.
    image (imgNuvol, posX, posY);
  }

  //  Mètode per animar els núvols i controlar els límits de la finestra gràfica.
  void animacioNuvols() {        
    // Desplaçament dels núvols cap a l'esquerra.
    posX = posX - velX;

    // Si els núvols surten completament de la finestra gràfica per l'esquerra, aleshores: (400 perquè el núvol més ample fa 400px, així tot travessaren completament)
    if (posX < -400) {
      // La nova posició en x serà a l'extrem dret de la finestra gràfica
      posX = width;

      // Si ens trobem en l'estat 1: Menú principal, aleshores:
      if (mainState == 1) {
        // La posició en y serà aleatòria entre -100 i height-100 per tal que els núvols puguin aparèixer tallats, però així la probabilitat no s'acumula tota al centre.
        posY = random(-100, height-100);

        // En cas contrari si ens trobem en l'estat 3: Activitat 1, aleshores:
      } else if (mainState == 3) {
        // La posició en y serà aleatòria entre -100 i height/2 per tal que els núvols puguin aparèixer en la zona més alta visible.
        posY = random(-100, height/2);
      }

      // La velocitat en x serà aleatòria entre 0.4 i 1.2.
      velX = random(0.4, 1.2);
    }
    // En cas que ens trobem en l'estat 3: Activitat 1, aleshores:
  }
}
