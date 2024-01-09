/*
 *    Classe Talps, usada per dibuixar i fer aparèixer els talps
 */

class Talps { 

  // Es declaren unes variables locals  
  int posX;          // Posició x del talp.
  int posY;          // Posició y del talp.
  PImage imgTalp;    // Imatge del talp.

  // Es crea un constructor amb 2 arguments:
  Talps (int x, PImage img) {  
    posX = x;
    imgTalp = img;
  } 

  //  Mètode per dibuixar els talps
  void dibuixar() { 
  
    // En funció del valor en la posició en x s'assigna el valor corresponent en y per cada posX del talp que hagi de sortir.
    if (posX == furat1X) {
      posY= furat1Y;
    } else if (posX == furat2X) {
      posY= furat2Y;
    } else if (posX == furat3X) {
      posY= furat3Y;
    } else if (posX == furat4X) {
      posY= furat4Y;
    } else if (posX == furat5X) {
      posY= furat5Y;
    } else if (posX == furat6X) {
      posY= furat6Y;
    } else if (posX == furat7X) {
      posY= furat7Y;
    } else if (posX == furat8X) {
      posY= furat8Y;
    } else if (posX == furat9X) {
      posY= furat9Y;
    } else if (posX == furat10X) {
      posY= furat10Y;
    }   
    
    // Modificació de la ubicació des d'on es dibuixen les imatges, ara des del centre.
    imageMode(CENTER);
    
    // Dibuix del talp
    image (imgTalp, posX, posY);
    
    // Recuperem la ubicació des d'on es dibuixen les imatges, cantonada superior esquerra de la imatge, per no afectar altres imatges del codi.
    imageMode(CORNER); 
  }
}
