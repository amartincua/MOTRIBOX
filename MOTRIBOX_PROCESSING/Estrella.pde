/*
 *    Classe Estrella, usada per dibuixar el fons d'estrelles.
 */

class Estrella {
  // Declaració de variables locals:
  float x, y;                // Posició en x i y de l'estrella.
  float diametre;            // Diàmetre de l'estrella.
  float factorEscala;        // Factor d'escala de l'estrella.
  float escalaMax;           // Límit d'escala màxima.
  float escalaMin;           // Límit d'escala mínima.

  // Creació d'un constructor i inicialització de les variables anteriors.
  Estrella() {    
    x = random(width);            // Posició en x aleatòria en funció de l'ample de la finestra gràfica.
    y = random(height);           // Posició en y aleatòria en funció de l'altura de la finestra gràfica.  
    diametre = random(1, 3.5);    // Diàmetre aleatori entre 1 i 3.5.   
    factorEscala = 1.0;           // Factor d'escala inicial d'1.0.
    escalaMax = 1.2;              // Escala màxima d'1.2.
    escalaMin = 0.2;              // Escala mínima de 0.2.
  }


  // Mètode per simular el parpelleig de les estrelles.
  void parpelleig() {
    // Amb una probabilitat baixa, es canvia el factor d'escala de manera aleatòria.
    if (random(1) < 0.01) {
      // El factor d'escala tindrà un valor aleatori entre un mínim i màxim establerts, així es crea l'efecte de parpelleig a les estrelles.
      factorEscala = random(escalaMin, escalaMax);
    }
  }

  // Mètode per dibuixar les estrelles.
  void dibuix() {    
    fill(255);        // Color de farciment blanc.
    noStroke();       // Sense traç.
    // Dibuix d'una el·lipse a la posició (x, y) amb un diàmetre ajustat pel factor d'escala.
    ellipse(x, y, diametre * factorEscala, diametre * factorEscala);
  }
}
