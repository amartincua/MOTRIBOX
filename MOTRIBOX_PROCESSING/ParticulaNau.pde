/*
 *    Classe ParticulaNau, usada per dibuixar i animar les partícules que simulen la propulsió de la nau.
 */

class ParticulaNau {
  // Declaració de variables locals:
  float x, y;                        // Posició en x i y de la partícula.
  float velX, velY;                  // Velocitat en x i y de la partícula.
  float diam;                        // Diàmetre de la partícula.
  float alpha;                       // Valor de transparència de la partícula.

  // Creació d'un constructor i inicialització de les variables anteriors.
  ParticulaNau() {
    x = nauX ;                                 // Posició en x, de la partícula, al centre de la nau.
    y =  nauY + 90;                            // Posició en y, de la partícula, a la part inferior de la nau. (El 90 és per col·locar les partícules just a la sortida del reactor de la nau)
    velX = random(-1.5, 1.5);                  // Velocitat X, de la partícula, aleatòria entre -1.5 i 1.5 
    velY = random(2, 4);                       // Velocitat Y, de la partícula aleatòria entre 2 i 4     
    diam = random(5, 15);                      // Diàmetre de la partícula, aleatòria entre 5 i 15 px.   
    alpha = map(y, nauY, nauY + 90, 255, 80);  // Valor de transparència remapatjat en funció de l'altura en què es troba la partícula i la nau.
  }

  // Mètode per controlar els moviments de les partícules.
  void moviment() {
    x += velX;    // Moviment de la partícula en X, en funció de la velocitat X.
    y += velY;    // Moviment de la partícula en Y, en funció de la velocitat y.

    // Mida en x i y total de l'efecte de propulsió i correcció per tal que les partícules tornin a la part inferior de la nau.
    // Si la partícula arriba a recórrer entre 100 px i l'altura màxima de la finestra gràfica, aleshores:
    if (y > nauY + random(100, height)) {      
      // Reinici de la posició de la partícula a les coordenades inicials:       
      x = nauX + random(-5, 5);       // Posició en X, de la partícula, al centre de la nau, però amb una lleugera desviació aleatòria de 5 píxels per cantó.
      y = nauY + 90;                  // Posició en Y, de la partícula, a la part inferior de la nau.
    }

    // Si l'altura de la partícula és inferior a la part inferior de la nau, aleshores:
    if (y < nauY + 60) {      
      // Reinici de la posició de la partícula a unes altres coordenades:       
      x = nauX + random(-10, 10);   // Posició en X, de la partícula, al centre de la nau, però amb una lleugera desviació aleatòria de 10 píxels per cantó.
      y = nauY + 90 + 10;           // Posició en Y, de la partícula, a la part inferior de la nau més 10 px cap a baix.
    }
  }

  //  Mètode per dibuixar les partícules.
  void dibuix() {    
    fill(255, 140, 0, alpha);      // Color de farciment taronja amb una transparència en funció d'alpha.
    noStroke();                    // Sense traç.
    circle(x, y, diam);            // Dibuix d'un cercle, com la forma de cada partícula en funció del diàmetre.
  }
}
