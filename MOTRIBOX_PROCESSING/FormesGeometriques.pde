/*
 *    Classe FormesGeometriques, usada per dibuixar i animar les formes geomètriques.
 */

class FormesGeometriques {
  // Declaració de variables locals:
  float x, y;                       // Posició en x i y de la forma geomètrica.
  float velX, velY;                 // Velocitat en x i y de la forma geomètrica.
  float diam;                       // Diàmetre de les formes geomètriques, tot i ser imatges, per controlar la seva animació es considera que tenen un diàmetre fixa.
  float angleInicial;               // Angle de rotació inicial.
  float velRotacio;                 // Angle de rotació.
  int aleatoriaFILA;                // Valor de l'índex per les FILES de la matriu bidimensional. Determina la FORMA geomètrica: 0: Cercle, 1: Triangle, 2: Quadrat, 3: Pentàgon. 
  int aleatoriaCOLUMNA;             // Valor de l'índex per les COLUMNES de la matriu bidimensional. Determina EL COLOR de la forma geomètrica: 0: Vermell, 1: Verd, 2: Blau, 3: Groc.
  color colorElectre;               // Color de l'efecte electre.

  // Creació d'un constructor i inicialització de les variables anteriors.
  FormesGeometriques() {

    // En funció d'una probabilitat del 50 %:
    if (random(2) > 1) {
      x = width + diam/2;      // Posició en x serà un valor a la dreta de la finestra gràfica.
    } else {
      x = -diam/2;             // Posició en x serà un valor a l'esquerra de la finestra gràfica.
    }

    y = random(height);        // Posició en y serà un valor aleatori entre 0 i el valor de l'altura de la finestra gràfica. 

    // VELOCITAT EN X i Y ALEATÒRIA, però evitant velocitats nul·les o molt baixes.
    // Eliminació de la probabilitat de què la funció random doni un nombre per la velocitat en X entre -1 i 1, a través de la condició a while. Així mai hi haurà una forma geomètrica parada o molt lenta.
    do {
      velX = random(-3, 3);        // Velocitat X, de la forma geomètrica aleatòria entre -3 i 3. 
      velY = random(-3, 3);        // Velocitat Y, de la forma geomètrica aleatòria entre -3 i 3.
    } while (velX <= 0 && velX >= -1 || velX >= 0 && velX <= 1); 

    diam = 100;   // Diametre de 100px, ja que les imatges de les formes geomètriques són de 100x100px.
    aleatoriaFILA = int(random(4));       // Valor de la FILA/FORMA aleatori.
    aleatoriaCOLUMNA = int(random(4));    // Valor de la COLUMNA/COLOR aleatori.
    angleInicial = 0;                     // Angle de rotació inicial de 0.
    velRotacio = random (0.002, 0.02);    // Velocitat de rotació aleatòria entre 0.002 i 0.02.
  }

  // Mètode per controlar el moviment de les formes geomètriques i la seva atracció a la nau, en cas de ser la forma objectiu.
  void moviment() {

    x += velX;    // Posició en x, en funció de la velocitat X.
    y += velY;    // Posició en y, en funció de la velocitat Y.

    // ATRACCIÓ DE LES FORMES GEOMÈTRIQUES OBJECTIU CAP A LA NAU
    // Si la distància entre cada forma geomètrica i la nau és menor que 400px i es tracta de la forma objectiu que hem d'agafar, aleshores:
    if (dist(x, y, nauX, nauY) < 400 && aleatoriaFILA == formaObjectiuFILA && aleatoriaCOLUMNA == formaObjectiuCOLUMNA) { 

      // Si la distància entre cada forma geomètrica i la nau és diferent de 0, aleshores:
      if (dist(x, y, nauX, nauY) != 0) {

        // CANVI DE VELOCITAT EN X, per tal d'atraure la forma geomètrica cap a la nau:
        // Si la posició en x de cada forma geomètrica és major que la posició en x de la nau, aleshores:
        if (x > nauX) {
          velX = -3;             // Velocitat de x negativa amb un valor concret.
          // En cas contrari:
        } else {            
          velX = 3;              // Velocitat de y positiva amb un valor concret.
        }

        // CANVI DE VELOCITAT EN Y, per tal d'atraure la forma geomètrica cap a la nau:
        // Si la posició en y de cada forma geomètrica és major que la posició en y de la nau, aleshores:
        if (y > nauY) {
          velY = -3;             // Velocitat de y negativa amb un valor concret.
          // En cas contrari:
        } else {
          velY = 3;              // Velocitat de y positiva amb un valor concret.
        }
      }
    }
  } 

  // Mètode per controlar el moviment de les formes geomètriques si arriben als límits de la finestra gràfica.
  void limits() {

    // Si la forma geomètrica arrabassa completament per l'esquerra de la finestra, aleshores:
    if (x < -diam/2) {
      x = width + diam/2;                  // Canvi de la posició en X, ara serà la dreta de la finestra. 
      y = random(height);                  // Canvi de la posició en Y, ara serà aleatòria, en funció de l'altura de la finestra. 
      velX = random(-1, -3);               // Velocitat X, de la forma geomètrica aleatòria entre -1 i -3, direcció cap a l'esquerra. 
      velY = random(-3, 3);                // Velocitat Y, de la forma geomètrica aleatòria entre -3 i 3, direcció cap amunt o avall.   
      aleatoriaFILA = int(random(4));      // Canvi de FILA/FORMA geomètrica.
      aleatoriaCOLUMNA = int(random(4));   // Canvi de COLUMNA/COLOR.
    }

    // Si la forma geomètrica arrabassa completament per la dreta de la finestra, aleshores:
    if (x > width + diam/2) { 
      x= -diam/2;                          // Canvi de la posició en X, ara serà l'esquerra de la finestra. 
      y = random(height);                  // Canvi de la posició en Y, ara serà aleatòria, en funció de l'altura de la finestra. 
      velX = random(1, 3);                 // Velocitat X, de la forma geomètrica aleatòria entre 1 i 3, direcció cap a la dreta. 
      velY = random(-3, 3);                // Velocitat Y, de la forma geomètrica aleatòria entre -3 i 3, direcció cap amunt o avall.  
      aleatoriaFILA = int(random(4));      // Canvi de FILA/FORMA geomètrica.
      aleatoriaCOLUMNA = int(random(4));   // Canvi de COLUMNA/COLOR.
    }

    // Si la forma geomètrica arrabassa completament per la part superior de la finestra, aleshores:
    if (y < -diam/2) {      
      y = height + diam/2;                 // Canvi de la posició en Y, ara serà la part inferior de la finestra. 
      x = random(width);                   // Canvi de la posició en X, ara serà aleatòria, en funció de l'ample de la finestra.
      velX = random(-3, 3);                // Velocitat X, de la forma geomètrica aleatòria entre -3 i 3, direcció cap a la dreta o esquerra. 
      velY = random(-1, -3);               // Velocitat Y, de la forma geomètrica aleatòria entre -1 i -3, direcció cap amunt.  
      aleatoriaFILA = int(random(4));      // Canvi de FILA/FORMA geomètrica.
      aleatoriaCOLUMNA = int(random(4));   // Canvi de COLUMNA/COLOR.
    }

    if (y > height+diam/2) { // Si l'àtom amb el seu electró arrabassa completament per sota de la finestra, aleshores:
      y = -diam/2;                         // Canvi de la posició en Y, ara serà la part superior de la finestra. 
      x = random(width);                   // Canvi de la posició en X, ara serà aleatòria, en funció de l'ample de la finestra.
      velX = random(-3, 3);                // Velocitat X, de la forma geomètrica aleatòria entre -3 i 3, direcció cap a la dreta o esquerra. 
      velY = random(1, 3);                 // Velocitat Y, de la forma geomètrica aleatòria entre 1 i 3, direcció cap a baix.  
      aleatoriaFILA = int(random(4));      // Canvi de FILA/FORMA geomètrica.
      aleatoriaCOLUMNA = int(random(4));   // Canvi de COLUMNA/COLOR.
    }
  }

  // Mètode per controlar el que passa si alguna forma geomètrica toca la nau.
  void tocar() {
    // AGAFAR OBJECTIU:
    // Si la distància entre la nau i la forma és menor de 50px i a més a més es tracta de la forma objectiu, aleshorees: 
    if (dist(x, y, nauX, nauY) < 20 && aleatoriaFILA == formaObjectiuFILA && aleatoriaCOLUMNA == formaObjectiuCOLUMNA  ) {      
      formaAgafada= true;     // S'indica que s'ha agafat la forma.
      numAgafats++;           // Comptabilització en 1 més el nombre d'objectes agafats. 
      encertsActiv2 ++;       // Comptabilització en 1 més el nombre d'encerts. 

      // En funció d'una probabilitat del 50%:
      if (random(2) > 1) {
        x = width + diam/2;      // Canvi de la posició en X, ara serà un valor a la dreta de la finestra gràfica.
      } else {
        x = -diam/2;             // Canvi de la posició en X, ara serà un valor a l'esquerra de la finestra gràfica.
      }

      y = random(height);        // Posició en y serà un valor aleatori entre 0 i el valor de l'altura de la finestra gràfica.
    } 

    // REBOT FORMES NO OBJECTIU:
    // Si la distància entre la Forma geomètrica i la Nau és menor de 115px i no és una forma objectiu, aleshores:
    if (dist(x, y, nauX, nauY) < 115 && (aleatoriaFILA != formaObjectiuFILA || aleatoriaCOLUMNA != formaObjectiuCOLUMNA)) {   

      velX *= -1;        // Inversió de la velocitat en X de la forma
      velY *= -1;        // Inversió de la velocitat en Y de la forma
      
      // Si tenim senyal en el sensor ESQUERRE, aleshores:
      if (s0>0) {
        nauX+= 50;  // Rebot a la dreta
      }
      // Si tenim senyal en el sensor DRET, aleshores:
      if (s2>0) {
        nauX+= -50;  // Rebot a l'esquerre
      }
      // Si tenim senyal en el sensor SUPERIOR, aleshores:
      if (s1>0) {
        nauY+= 50;  // Rebot cap a baix
      }
      // Si tenim senyal en el sensor INFERIOR, aleshores:
      if (s3>0) {
        nauY+= -50;  // Rebot cap a dalt
      }    

      erradesActiv2++;   // Addició d'1 errada a la variable erradesActiv2. 
      // Reproducció de l'efecte de so d'un rebot. 
      rebot.rewind();    // Rebobinar al principi l'efecte de so.           
      rebot.play();      // Reproduir l'efecte de so.
    }
  }

  // Mètode per controlar l'efecte electritzant entre la nau i la forma geomètrica.
  void electre() {  

    // Controlem la distància en què apareixen les cordes vibrants.
    // Si la distància entre una forma geomètrica i la nau és menor de 400px i a més a més es tracta de la forma objectiu, aleshores: 
    if (dist(x, y, nauX, nauY) < 400 && aleatoriaFILA == formaObjectiuFILA && aleatoriaCOLUMNA == formaObjectiuCOLUMNA) { 

      // En funció del color de la forma objectiu s'assigna un valor de color a la variable colorElectre.  
      switch (formaObjectiuCOLUMNA) {    
      case 0:
        colorElectre = color(255, 0, 0);        
        break;
      case 1:
        colorElectre = color(0, 255, 0);
        break;
      case 2:
        colorElectre = color(0, 0, 255);
        break;
      case 3:
        colorElectre = color(255, 255, 0);
        break;
      }

      // Sense farciment
      noFill();

      // Color de traç en funció de la variable colorElectre. 
      stroke(colorElectre);

      // Gruix de traç entre 1 i 2   
      strokeWeight(random(1, 2));                      

      // Dibuix de 4 corbes de Bézier entre la nau i la posició de la forma geomètrica, amb uns control points aleatoris, però restringits per donar un efecte de corda vibrant. 
      bezier(nauX, nauY-100, nauX, nauY-100, x+random(-150, 150), y+random(-100, 100), x, y);
      bezier(nauX, nauY-100, nauX, nauY-100, x+random(-150, 150), y+random(-100, 100), x, y);
      bezier(nauX, nauY-100, nauX, nauY-100, x+random(-150, 150), y+random(-100, 100), x, y);
      bezier(nauX, nauY-100, nauX, nauY-100, x+random(-150, 150), y+random(-100, 100), x, y);

      // Sense traç:
      noStroke();

      // Color de farciment en funció de la variable colorElectre. 
      fill(colorElectre);

      // Dibuix d'una el·lipse a sobre l'antena de la nau, amb uns valors oscil·lants de diàmetre.
      ellipse(nauX, nauY-100, random(10, 15), random(10, 15));
    }
  }  


  //  Mètode per dibuixar les formes geomètriques.
  void dibuix() {    

    pushMatrix();                   // Funció que recorda l'últim sistema de coordenades.
    translate(x, y);                // Es desplaça l'origen de coordenades en funció del valor de x i y.
    rotate(angleInicial);           // Es rota la forma geomètrica amb el valor de angleInicial.
    imageMode (CENTER);             // Modificació de la ubicació des d'on es dibuixen les imatges, ara des del centre. 
    image(formesGeometriques[aleatoriaFILA][aleatoriaCOLUMNA], 0, 0);  // Dibuix de la imatge en funció de l'objectiu que hagi sortit.
    imageMode (CORNER);             // Modificació de la ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra de la imatge. 
    popMatrix();                    // Funció que restableix el sistema de coordenades anterior.

    // S'augmenta l'angle de rotació inicial en funció del valor de velRotacio. 
    angleInicial += velRotacio;
  }
}
