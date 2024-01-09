/*
 *    FUNCIÓ DE L'ESTAT 4: ACTIVITAT 2 
 */

void activ2() { 

  // Cronòmetre de temps que començarà a comptar el temps fins a la finalització de l'activitat 2.       
  timerACTIV2.start (true); 
  // Actualització del valor del cronòmetre anterior amb la funció update, utilitzant com a paràmetre el temps que ha passat.
  timerACTIV2.update(clock.getDeltaMillis());  

  // Reproducció d'instruccions.
  activ2_0.play(); 

  // DIBUIX FONS BÀSIC
  background(5);        // Fons de color quasi negre pur

  // DIBUIX i PARPELLEIG ESTRELLES
  // Es criden els 2 mètodes de la classe Estrella amb un bucle que recorri cadascuna de les estrelles.
  for (int i = 0; i < numEstrelles; i++) {         
    estrelles[i].parpelleig();
    estrelles[i].dibuix();
  }
  // CONTROL DE SI S'HAN TOCAT EL SENSOR TÀCTILS QUE TOCA 
  // Condició per verificar que només tenim un sensor tàctil que s'està activant, només pasarà si la suma dels sensors és 1, aleshores:
  if (pad0 + pad1 +pad2 + pad3 +pad4 + pad5 +pad6 + pad7 +pad8 + pad9 == 1 ) {    
    // Si tenim senyal al sensor tàctil corresponent al furatObjectiu i la variable sensorTactilPolsat es false, aleshores:
    if (valors[furatObjectiu+4] == 1  && sensorTactilPolsat == false) {        
      barra += 10;                      // S'augmenta en 10px el valor de la barra (amplada).
      sensorTactilPolsat = true;        // Es guarda l'acció d'haver polsat el sensor correcte amb el valor true a la variable sensorTactilPolsat.

      // CANVI DE FURAT OBJECTIU
      // Guardem el valor de l'objectiu actual, per tal de recordar-lo i que no torni aparegui més endavant.  
      furatObjectiuAnterior = furatObjectiu;
      // Canvi aleatori de sensor objectiu
      do {
        // El furat objectiu serà alguna de les 10 posicions de l'arrray furatX, per tant, es genera un nombre aleatori entre 0 i 9, ambdós inclosos.
        furatObjectiu = int(random(furatX.length));  
        // En cas que el furat objectiu anterior sigui el mateix que el que ha sortit ara, aleshores es repeteix el bucle i es torna a elegir un altre furat objectiu fins que sigui diferent.
      } while (furatObjectiuAnterior == furatObjectiu);  

      // Reproducció d'un efecte de so, si la barra encara no està del tot plena, per donar una retroacció sobre el sensor tàctil ben tocat. 
      if (barra < 100) {
        tocOk.rewind();    // Es rebobina al principi de l'efecte de so.           
        tocOk.play();      // Es reprodueix l'efecte de so.
      }
    }
  }
  // Si no estem tocant el sensor tàctil, aleshores:
  if (valors[furatObjectiu+4] == 0) { 
    //if (keyPressed == false) {
    sensorTactilPolsat = false;      // Es guarda l'acció amb el valor false a la variable sensorTactilPolsat.
  }

  // CANVI DE SENSOR TÀCTIL OBJECTIU CADA 5 SEGONS SI NO S'HA ACONSEGUT
  timer5segons.start (true);
  // S'ctualitza el valor del cronòmetre de 5 segons amb la funció update, utilitzant com a paràmetre el temps que ha passat..
  timer5segons.update(clock.getDeltaMillis());   

  // Si els 5 segons ja han passat, aleshores:
  if (timer5segons.getFinish()) {  
    // Guardem el valor de l'objectiu actual, per tal de recordar-lo i que no torni aparegui més endavant.  
    furatObjectiuAnterior = furatObjectiu;

    // Canvi aleatori de sensor objectiu
    do {
      // El furat objectiu serà alguna de les 10 posicions de l'arrray furatX, per tant, es genera un nombre aleatori entre 0 i 9, ambdós inclosos.
      furatObjectiu = int(random(furatX.length));  
      // En cas que el furat objectiu anterior sigui el mateix que el que ha sortit ara, aleshores es repeteix el bucle i es torna a elegir un altre furat objectiu fins que sigui diferent.
    } while (furatObjectiuAnterior == furatObjectiu);   

    // Reinici del cronòmetre.
    timer5segons.reset();
    // Cronòmetre de 5 segons en marxa perquè comenci a comptar.
    timer5segons.start(true);
  }

  // CONTROL DEL BORRAT DE LES FORMES GEOMÈTRIQUES NO OBJECTIU
  // Es declaren unes variables locals per guardar unes posicions noves en x i y.
  float aleatoriX;
  float aleatoriY; 

  // Si la barra té un valor de 100, aleshores:  
  if (barra == 100) {    
    barra = 0;            // Es reinicia la barra a 0.
    barraFull = true;     // S'indica amb un true a barraFull que la barra està plena. 

    // Reproducció d'un efecte de so: 
    explosio.rewind();                // Es rebobina al principi de l'efecte de so. 
    explosio.play();                  // Es reprodueix l'efecte de so. 

    // Recorrem amb un bucle cadascuna de les formes geomètriques.
    for (int i = 0; i < numFormes; i++) {   
      // Si les formes geomètriques que hi ha per pantalla són diferents de la forma objectiu, aleshores:
      if (formes[i].aleatoriaFILA != formaObjectiuFILA || formes[i].aleatoriaCOLUMNA != formaObjectiuCOLUMNA ) {

        // S'elegeigen unes formes noves
        formes[i].aleatoriaFILA = int(random(4));
        formes[i].aleatoriaCOLUMNA = int(random(4)); 

        // Es generen unes noves posicions en x i y de forma aleatòria, en un espai més gran que l'observable, per tal d'encabir completament les formes fora la finestra gràfica.
        aleatoriX = random(-200, width+200) ;
        aleatoriY = random(-200, height+200);

        // Per tal que la nova posició no sigui a dins la finestra gràfica que s'observa, es controla perquè apareguin a la part superior, inferior, dreta o esquerra de la finestra no observable amb una probabilitat del 50% per cada cantó.
        // Si la nova posició en X es troba a la finestra observable, aleshores:
        if (aleatoriX > 0 && aleatoriX < width ) {
          // Amb una probabilitat del 50%:
          if (random(2) > 1) {
            aleatoriY = -100;              // La variable provisional de la posició en y serà la part superior de la finestra gràfica no observable.
            // Amb l'altre 50%:
          } else {
            aleatoriY = height+100;        // La variable provisional de la posició en y serà la part inferior de la finestra gràfica no observable.
          }
        }

        // Si la nova posició en Y es troba a la finestra observable, aleshores:
        if (aleatoriY > 0 && aleatoriY < height ) {
          // Amb una probabilitat del 50%:
          if (random(2) > 1) {
            aleatoriX = -100;            // La variable provisional de la posició en X serà la part esquerra de la finestra gràfica no observable.
          } else {
            aleatoriX = width+100;       // La variable provisional de la posició en X serà la part dreta de la finestra gràfica no observable.
          }
        } 

        // Un cop fets tots els càlculs es guarda el valor obtingut per x i y per a cada forma geomètrica, per tant, es dona la nova ubicació a les formes.
        formes[i].x = aleatoriX;
        formes[i].y = aleatoriY;
      }
    }
  }

  // DIBUIX EXPLOSIÓ UN COP LA BARRA D'AJUDA ESTÀ PLENA
  // Si la barra està plena, aleshores: 
  if (barraFull) {
    diamExplo += 100;                                  // S'incrementa el valor de diamExplo de 100 en 100, per tal de fer créixer el diamètre d'un cercle 
    fill(0, random(50, 200), 0, random (255));         // Color de farciment verd, amb uns valors aleatoris quant al component verd RGB i amb una transparència aleatòria. 
    circle(nauX, nauY, diamExplo);                     // Dibuix del cercle de l'explosió en funció de la posició de la nau i del valor de diamExplo. 

    timer0_7segons.start (true);                       // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
    timer0_7segons.update(clock.getDeltaMillis());     // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.

    strokeWeight(random(1, 4));                        // Gruix de traç aleatori. 
    stroke(0, 255, 0, random(200, 255));               // Color del traç verd amb transparència aleatòria.
    noFill();                                          // Sense farciment.
    // Es dibuixen diverses Corbes de Bézier entre la posició de la nau i els extrems de la finestra gràfica, amb els control points aleatoris.
    bezier(nauX, nauY, random(width), random(height), random(width), random(height), random(width), 0);
    bezier(nauX, nauY, random(width), random(height), random(width), random(height), 0, random(height));
    bezier(nauX, nauY, random(width), random(height), random(width), random(height), width, random(height));
    bezier(nauX, nauY, random(width), random(height), random(width), random(height), random(width), height);
    bezier(nauX, nauY, random(width), random(height), random(width), random(height), random(width), random(height));
  }

  // Si els 0.7 segons ja han passat, aleshores:
  if (timer0_7segons.getFinish()) {
    // S'indica la barraFull amb un false, que ja no està plena. 
    barraFull = false;
    // Reinici del cronòmetre.
    timer0_7segons.reset();
    // Reinici de la variable diamExplo. 
    diamExplo = 0;
  }

  // FORMES GEOMÈTRIQUES
  // Es criden els 5 mètodes de la classe FormesGeometriques amb un bucle que recorre cadascuna de les formes.
  for (int i = 0; i < numFormes; i++) {     
    formes[i].moviment();
    formes[i].limits();
    formes[i].tocar();
    formes[i].electre();
    formes[i].dibuix();
  }

  // PARTÍCULES NAU
  // Es criden els 2 mètodes de la classe ParticulaNau amb un bucle que recorre cadascuna de les particules.
  for (int i = 0; i < numParticles; i++) {     
    particules[i].moviment();
    particules[i].dibuix();
  }

  // CONTROL DEL MOVIMENT DE LA NAU --> 1 SENSOR ACTIVAT
  // Si tenim un senyal individual de s0, s1, s2 o s3, aleshores:
  if ((s0>0 && s1==0 && s2==0 && s3==0) || (s0==0 && s1>0 && s2==0 && s3==0) || (s0==0 && s1==0 && s2>0 && s3==0) || (s0==0 && s1==0 && s2==0 && s3>0)) {

    // SENSOR ESQUERRA - Si tenim un senyal del sensor 0, aleshores:
    if (s0>0 && s1==0 && s2==0 && s3==0) {           
      // Posició de la nau en X en funció de la velocitat de la nau en X i del valor del sensor 0.
      nauX = nauX - (s0*velXnau);
    }
    // SENSOR DRET - Si tenim un senyal del sensor 2, aleshores:     
    if (s0==0 && s1==0 && s2>0 && s3==0) {    
      // Posició de la nau en X en funció de la velocitat de la nau en X i del valor del sensor 2.
      nauX = nauX +(s2*velXnau);
    }
    // SENSOR SUPERIOR - Si tenim un senyal del sensor 1, aleshores:       
    if (s0==0 && s1>0 && s2==0 && s3==0) {
      // Posició de la nau en Y en funció de la velocitat de la nau en Y i del valor del sensor 1.
      nauY = nauY - (s1*velYnau);
    }
    // SENSOR INFERIOR - Si tenim un senyal del sensor 3, aleshores:  
    if (s0==0 && s1==0 && s2==0 && s3>0) { 
      // Posició de la nau en Y en funció de la velocitat de la nau en Y i del valor del sensor 3.
      nauY = nauY + (s3*velYnau);
    }
  }

  // CONTROL DEL MOVIMENT DE LA NAU --> 2 SENSORS ACTIVATS
  if ((s0>0 && s1>0 && s2==0 && s3==0) || (s0==0 && s1>0 && s2>0 && s3==0) || (s0==0 && s1==0 && s2>0 && s3>0) || (s0>0 && s1==0 && s2==0 && s3>0)) {
    // SENSOR ESQUERRE + SENSOR SUPERIOR
    if (s0>0 && s1>0 && s2==0 && s3==0) {    
      nauX = nauX - (s0*velXnau/2);       
      nauY = nauY - (s1*velXnau/2);
    }
    // SENSOR SUPERIOR + SENSOR DRET 
    if (s0==0 && s1>0 && s2>0 && s3==0) {          
      nauX = nauX +(s2*velXnau);   
      nauY = nauY - (s1*velXnau/2);
    }
    // SENSOR DRET + SENSOR INFERIOR    
    if (s0==0 && s1==0 && s2>0 && s3>0) {      
      nauX = nauX +(s2*velXnau);
      nauY = nauY + (s3*velYnau);
    }
    // SENSOR ESQUERRE + SENSOR INFERIOR 
    if (s0>0 && s1==0 && s2==0 && s3>0) {       
      nauX = nauX -(s0*velXnau);
      nauY = nauY + (s3*velYnau);
    }
  }

  // DIBUIX RETROACCIÓ DEL MOVIMENT    
  // SENSOR 0 / ESQUERRE - Si tenim un senyal del sensor 0, aleshores:
  if (s0>0) {            
    // Dibuix d'una corba de Bézier dinàmica (en funció del valor del sensor 0) per mostrar la interacció. 
    fill (255, 0, 0, 70);
    bezier(0, 0, 0, 0, valors[0]/4, height/2, 0, height-40);
  }
  // SENSOR 2 / DRET - Si tenim un senyal del sensor 2, aleshores:     
  if (s2>0) {          
    // Dibuix d'una corba de Bézier dinàmica (en funció del valor del sensor 2) per mostrar la interacció. 
    fill (0, 0, 255, 50);
    bezier(width, 0, width, 0, width-valors[2]/4, height/2, width, height-40);
  }
  // SENSOR 1 / SUPERIOR - Si tenim un senyal del sensor 1, aleshores:       
  if (s1>0) {     
    // Dibuix d'una corba de Bézier dinàmica (en funció del valor del sensor 1) per mostrar la interacció. 
    fill (0, 255, 0, 50);
    bezier(0, 0, 0, 0, width/2, valors[1]/4, width, 0);
  }
  // SENSOR 3 / INFERIOR - Si tenim un senyal del sensor 3, aleshores:  
  if (s3>0) {       
    // Dibuix d'una corba de Bézier dinàmica (en funció del valor del sensor 3) per mostrar la interacció.
    fill (255, 255, 0, 110);
    bezier(0, height, 0, height, width/2, height-valors[3]/4, width, height);
  }

  // RETORN DE LA NAU AL CENTRE DE LA PANTALLA
  // Si no hi ha senyal en cap dels sensors d'ultrasons, aleshores:
  if (s0==0 && s1==0 && s2==0 && s3==0) {
    // A través de la funció lerp() que s'utilitza per calcular un valor entre dos valors amb un increment específic. Es torna la nau al centre.
    nauX = lerp(nauX, width/2, 0.01);
    nauY = lerp(nauY, (height-170)/2, 0.01);
  }

  // CONTROL DELS LÍMITS DE LA NAU
  // En cas d'arribar a la dreta de la finestra gràfica, aleshores:
  if (nauX > width-105) {
    nauX = width-105;        // Es queda a la dreta
  }  
  // En cas d'arribar a l'esquerra de la finestra gràfica, aleshores:
  if (nauX < 105) {
    nauX = 105;              // Es queda a l'esquerra
  }  
  // En cas d'arribar a la part inferior, a prop del panell informatiu, aleshores:
  if (nauY > height-275) {
    nauY = height-275;       // Es queda a la part inferior
  }  
  // En cas d'arribar a la part superior de la finestra gràfica, aleshores:
  if (nauY < 105) {
    nauY = 105;             // Es queda a la part superior
  }

  // DIBUIX NAU
  imageMode (CENTER);            // Modificació de la ubicació des d'on es dibuixen les imatges, ara des del centre.  
  image (nau, nauX, nauY);       // Dibuix de la imatge de la nau en funció de les variables nauX i nauY

  // DIBUIXOS INFORMACIÓ
  image (panellActiv2, width/2, height-90);      // Dibuix de la imatge del panell d'informació inferior centrat i a la part inferior. 
  imageMode (CORNER);                            // Modificació de la ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra. 
  image (tornarMenu, 30, 30);                    // Dibuix de la imatge de la icona de tornar al menú principal.
  // Dibuix de les imatges de les estrelles buides de forma ordenada i equidistant, a través d'un bucle.
  for (int i = 0; i < 4; i++) {  
    image (estrellaBuida, 1450+ i*120, 30 );
  }

  // DIBUIX FORMA OBJECTIU
  imageMode (CENTER);                                                         // Modificació de la ubicació des d'on es dibuixen les imatges, ara des del centre. 
  pushMatrix();                                                               // Funció que recorda l'últim sistema de coordenades.
  translate (width/2, height-90);                                             // Es desplaça l'origen de coordenades al centre i part inferior.
  scale(0.65);                                                                // S'escala la forma objectiu.            
  image(formesGeometriques[formaObjectiuFILA][formaObjectiuCOLUMNA], 0, 0);   // Dibuix de la imatge de la forma geomètrica objectiu en funció de la forma i el color que toquin. 
  popMatrix();                                                                // Funció que restableix el sistema de coordenades anterior.
  imageMode (CORNER);                                                         // Modificació de la ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra. 

  // CONTROL DE SI S'HA AGAFAT UN FORMA OBJECTIU
  // Si la variable formaAgafada és true, aleshores: 
  if (formaAgafada) {     
    // Es guarda a la posició que toca la FILA/FORMA que ha sortit
    objectiusHistoricFILA[indexFILA] = formaObjectiuFILA;
    // Es guarda a la posició que toca la COLUMNA/COLOR que ha sortit
    objectiusHistoricCOLUMNA[indexCOLUMNA] = formaObjectiuCOLUMNA; 
    // S'incrementa en un l'índex de la FILA
    indexFILA++;
    // S'incrementa en un l'índex de la COLUMNA
    indexCOLUMNA++;    
    // Reproducció d'un efecte de so:     
    formaOk.rewind();                    // Es rebobina al principi de l'efecte de so. 
    formaOk.play();                      // Es reprodueix l'efecte de so.  
    // Es crea una nova instància per poder guardar un nou objecte a la matriu.
    formes[numFormes] = new FormesGeometriques(); 
    // Incrementem en un el nombre de formes (un objecte més).
    numFormes++;

    // Es guarda a l'array objectius l'objectiu aconseguit. (Multiplicant per 4 les FILES s'ha pogut passar les dades d'una matriu bidimensional en una d'una sola dimensió, així més tard es podran dibuixar els objectius aconseguits) 
    if (indexObjectiu < objectius.length) {
      objectius[indexObjectiu] = (formaObjectiuFILA * 4) + formaObjectiuCOLUMNA;
      // S'incrementa l'índex, per tal que el següent cop la forma agafada quedi registrada en la següent posició.
      indexObjectiu++;
    }
    // Reinici de la varaible formaAgafada a false. 
    formaAgafada = false;
  }

  // EFECTE DE SO D'ELECTRE EN TOCAR LA FORMA OBJECTIU
  // Es recorren tots els objectes de les formes.
  for (int i = 0; i < numFormes; i++) {
    // Si la distància entre una forma geomètrica i la nau és menor de 400px i a més a més es tracta de la forma objectiu, aleshores: 
    if (dist(formes[i].x, formes[i].y, nauX, nauY) < 400 && formes[i].aleatoriaFILA == formaObjectiuFILA && formes[i].aleatoriaCOLUMNA == formaObjectiuCOLUMNA) { 
      electra.play();       // Es reprodueix l'efecte de so.    
      formaTocada = i;      // Es guarda la forma tocada per tal que en la següent instrucció es pugui aturar únicament la reproducció del so en l'objecte actual. Així en cas que apareguin per pantalla dues o més formes objectiu al mateix moment, l'efecte de so es reprodueix independent pels objectius, si no només sonava per un objecte.
    }

    // Si la distància entre una forma geomètrica i la nau és major de 400px i a més a més es tracta de la forma objectiu i estem iterant per l'objecte de la forma actual, aleshores: 
    if ((dist(formes[i].x, formes[i].y, nauX, nauY) > 400 && formes[i].aleatoriaFILA == formaObjectiuFILA && formes[i].aleatoriaCOLUMNA == formaObjectiuCOLUMNA && i == formaTocada)) {
      electra.pause();      // Es para l'efecte de so
    }
  } 

  // Si arribem al final de l'efecte de so, aleshores:
  if ( electra.position() == (electra.length()) ) {     
    electra.rewind();  // Es rebobina al principi de l'efecte de so.
  }

  // CONTROL PER SI S'HAN ACONSEGUIT AGAFAR 3 OBJECTIUS. --> CANVI D'OBJECTIU
  // Si el nombre de numAgafats és 3, aleshores:
  if (numAgafats == 3) {  
    // Afegim un nou trio aconseguit a la variable triosAconseguits 
    triosAconseguits++;
    // Reproducció d'un efecte de so:  
    estrella.rewind();                // Es rebobina al principi de l'efecte de so. 
    estrella.play();                  // Es reprodueix l'efecte de so. 

    // Si l'l'índex formes és menor de 3, aleshores:
    if (indexFormes < formesAtzar.length - 1) {
      // S'incrementa l'índex formes en 1.
      indexFormes++;
      // S'assigna la nova forma a agafar en funció del valor actual de indexFormes i dels valors de l'array que havien sortit de forma aleatòria a l'inici.
      formaObjectiuFILA = formesAtzar[indexFormes];
    }

    // Si l'l'índex colors és menor de 3, aleshores:
    if (indexColors < colorsAtzar.length - 1) {
      // S'incrementa l'índex colors en 1.
      indexColors++;
      // S'assigna el nou color a agafar en funció del valor actual de indexColors i dels valors de l'array que havien sortit de forma aleatòria a l'inici.
      formaObjectiuCOLUMNA = colorsAtzar[indexColors];
    }
    // Reinici de la variable numAgafats a 0.
    numAgafats = 0;

    // Si només s'ha aconseguit un trio, aleshores:
    if (triosAconseguits < 2) {
      // Reproducció d'instruccions auditives
      activ2_2.play();
    }
  }

  // Si arribem al final de l'efecte de l'instrucció auditiva, aleshores:
  if ( activ2_2.position() == (activ2_2.length()) ) {     
    activ2_2.rewind();  // Es rebobina al principi l'instrucció auditiva.
  }

  // DIBUIX DE LES ESTRELLES (NIVELLS) I CONTROL DEL TEMPS
  // En funció del valor de triosAconseguits, es dibuixen més o menys estrelles plenes i de forma equidistant usant un bucle, com en el cas de les estrelles buides.
  switch (triosAconseguits) {  

  case 1:                                          // 3 objectius aconseguits - 1 trio
    image (estrellaPlena, 1450, 30 );              // Nivell 1 superat    
    break;
  case 2:                                          // 6 objectius aconseguits - 2 trios
    for (int i = 0; i < 2; i++) {                  // Nivell 2 superat
      image (estrellaPlena, 1450+ i*120, 30 );
    }  
    break;
  case 3:                                          // 9 objectius aconseguits - 3 trios
    for (int i = 0; i < 3; i++) {                  // Nivell 3 superat
      image (estrellaPlena, 1450+ i*120, 30 );
    }           
    break;
  case 4:                                          // 12 objectius aconseguits - 4 trios
    for (int i = 0; i < 4; i++) {                  // Nivell 4 superat 
      image (estrellaPlena, 1450+ i*120, 30 );
    }      
    // CÀLCUL DE LA PUNTUACIÓ
    // Sí tenim encerts, aleshores:
    if (encertsActiv2 > 0) {
      // La puntuació obtinguda, en tant per cent, es calcula segons la formula: Puntuació = (Encerts / (Encerts+Errades)*100, s'arrodoneix perquè doni un nombre enter amb la funció round().
      puntuacioACTIV2 = round(((encertsActiv2/(encertsActiv2+erradesActiv2))*100));
      // Les errades obtingudes també són en tant per cent, es calcula segons la formula: Errades = (Errades / (Encerts+Errades)*100, s'arrodoneix perquè doni un nombre enter amb la funció round().
      erradesActiv2 = round(((erradesActiv2/(encertsActiv2+erradesActiv2))*100));
    }
    // Si la puntuació màxima és menor que l'obtinguda, aleshores:
    if (maxPuntuacioACTIV2 < puntuacioACTIV2) {
      // S'actualitza la nova puntuació màxima a la puntuació actual obtinguda.
      maxPuntuacioACTIV2 = puntuacioACTIV2;
    }    

    // TEMPS ACTIVITAT 2
    // Guardem el temps utilitzat en fer l'activitat 2 en una variable.
    tempsACTIV2= int(timerACTIV2.getTimeSec());   
    // Reiniciem el cronòmetre
    timerACTIV2.reset();
    timerACTIV2.start (false); 
    // Pausa de l'efecte de so
    electra.pause();

    mainStateAnterior = ACTIV2;  // Es guarda l'estat actual com anterior.
    // Anem a l'estat de fi d'activitat
    mainState =  FIACTIV;     
    break;
  }

  // DIBUIX BARRA D'AJUDA
  rectMode(CORNER);                                         // Modificació de la ubicació des d'on es dibuixen els rectangles, ara des de la cantonada superior esquerra. 
  fill(0, 255, 0);                                          // Color de farciment verd
  rect(493, height-102, map(barra, 0, 100, 0, 319), 19, 2); // Dibuix del rectangle que representa la barra, la seva amplada serà en funció del valor de la variable barra i amb una amplada màxima de 319  

  // DIBUIX FURATS o SENSORS TÀCTILS
  pushMatrix();                                             // Funció que recorda l'últim sistema de coordenades.
  translate (200, 900);                                     // Es desplaça l'origen de coordenades.
  scale(0.15);                                              // S'escala la disposició de cada furat de l'activitat 1.
  color colorFuratNormal = color(89, 23, 62);               // Es declara i assigna un color pels furats que no s'han de tocar.
  color colorFuratObjectiu = color(255, 140, 35);           // Es declara i assigna un color pels furats que s'han de tocar.
  fill(colorFuratNormal);                                   // Color de farciment en funció d'un variable.
  // Dibuix dels 10 cercles o furats que representen els sensors tàctils que no s'han de tocar.
  circle(furat1X, furat1Y, 100);                      
  circle(furat2X, furat2Y, 100);
  circle(furat3X, furat3Y, 100);
  circle(furat4X, furat4Y, 100);
  circle(furat5X, furat5Y, 100);
  circle(furat6X, furat6Y, 100);
  circle(furat7X, furat7Y, 100);
  circle(furat8X, furat8Y, 100);
  circle(furat9X, furat9Y, 100);
  circle(furat10X, furat10Y, 100);

  //En funció de l'objectiu del furat que aparegui cada 5 segons, es dibuixen els cercles amb un color diferent.
  switch (furatObjectiu) {    
  case 0:    
    fill(colorFuratObjectiu);
    circle(furat1X, furat1Y, 100); 
    break;
  case 1:
    fill(colorFuratObjectiu);
    circle(furat2X, furat2Y, 100);
    break;
  case 2:
    fill(colorFuratObjectiu);
    circle(furat3X, furat3Y, 100);
    break;
  case 3:
    fill(colorFuratObjectiu);
    circle(furat4X, furat4Y, 100);
    break;
  case 4:
    fill(colorFuratObjectiu);
    circle(furat5X, furat5Y, 100);
    break;
  case 5:
    fill(colorFuratObjectiu);
    circle(furat6X, furat6Y, 100);
    break;
  case 6:
    fill(colorFuratObjectiu);
    circle(furat7X, furat7Y, 100);
    break;
  case 7:
    fill(colorFuratObjectiu);
    circle(furat8X, furat8Y, 100);
    break;
  case 8:
    fill(colorFuratObjectiu);
    circle(furat9X, furat9Y, 100);
    break;
  case 9:
    fill(colorFuratObjectiu);
    circle(furat10X, furat10Y, 100);
    break;
  }
  // Funció que restableix el sistema de coordenades anterior.
  popMatrix();                  

  // DIBUIX DELS TRIOS NO ACONSEGUITS
  // Dibuix de les imatges dels trios geomètrics no aconseguits de forma ordenada i equidistant, a través d'un bucle.
  for (int i = 0; i < 4; i++) {
    image(triosGeometrics[i], 1095+ i*155, 935);
  }

  // DIBUIX DELS OBJECTIUS QUE ES VAN ACONSEGUINT.
  // Recorrem l'array objectius amb un bucle.
  for (int i = 0; i < objectius.length; i++) {    
    // Si algun dels elements és diferent de 99, és a dir que s'ha aconseguit algun objectiu, aleshores:
    if (objectius[i] != 99 ) {

      // Funció que recorda l'últim sistema de coordenades.
      pushMatrix();

      /* A través de l'array objectius el qual guarda els objectius aconseguits es va comprovant si són CERCLES, TRIANGLES, QUADRATS o PENTAGONS
       i aleshores es van dibuixant en la seva posició respecte als fons de trios no aconseguits.
       S'han desplaçat l'origen de coordenades i escalat les imatges originals de cada forma geomètrica per aconseguir-ho */

      // Si són CERCLES:
      if (objectius[i] == 0 ||objectius[i] == 1 ||objectius[i] == 2 || objectius[i] == 3 ) {
        translate (1119, 984); 
        scale(0.22);
        if (i == 0 || i == 3 || i == 6 || i == 9) {
          image (formesGeometriquesTotes[objectius[i]], 0, 0);
        }
        if (i == 1 || i == 4 || i == 7 || i == 10) {
          image (formesGeometriquesTotes[objectius[i]], 70, -120);
        }
        if (i == 2 || i == 5 || i == 8 || i == 11) {
          image (formesGeometriquesTotes[objectius[i]], 139, 0);
        }
      }

      // Si són TRIANGLES:
      if (objectius[i] == 4 ||objectius[i] == 5 ||objectius[i] == 6 || objectius[i] == 7 ) {
        translate (1274, 984); 
        scale(0.22); 
        if (i == 0 || i == 3 || i == 6 || i == 9) {
          image (formesGeometriquesTotes[objectius[i]], 0, 0);
        }
        if (i == 1 || i == 4 || i == 7 || i == 10) {
          image (formesGeometriquesTotes[objectius[i]], 70, -120);
        }
        if (i == 2 || i == 5 || i == 8 || i == 11) {
          image (formesGeometriquesTotes[objectius[i]], 139, 0);
        }
      }

      // Si són QUADRATS:
      if (objectius[i] == 8 ||objectius[i] == 9 ||objectius[i] == 10 || objectius[i] == 11 ) {
        translate (1429, 984); 
        scale(0.22);
        if (i == 0 || i == 3 || i == 6 || i == 9) {
          image (formesGeometriquesTotes[objectius[i]], 0, 0);
        }
        if (i == 1 || i == 4 || i == 7 || i == 10) {
          image (formesGeometriquesTotes[objectius[i]], 70, -120);
        }
        if (i == 2 || i == 5 || i == 8 || i == 11) {
          image (formesGeometriquesTotes[objectius[i]], 139, 0);
        }
      }

      // Si són PENTAGONS:
      if (objectius[i] == 12 ||objectius[i] == 13 ||objectius[i] == 14 || objectius[i] == 15 ) {
        translate (1584, 984); 
        scale(0.22);
        if (i == 0 || i == 3 || i == 6 || i == 9) {
          image (formesGeometriquesTotes[objectius[i]], 0, 0);
        }
        if (i == 1 || i == 4 || i == 7 || i == 10) {
          image (formesGeometriquesTotes[objectius[i]], 70, -120);
        }
        if (i == 2 || i == 5 || i == 8 || i == 11) {
          image (formesGeometriquesTotes[objectius[i]], 139, 0);
        }
      }
      // Funció que restableix el sistema de coordenades anterior.
      popMatrix();
    }
  }

  // Controlem les instruccions sonores d'ajuda en cas de no activar cap sensor en 10 segons
  // Si no tenim senyal de cap sensor i la instrucció auditiva inicial ja ha acabat, aleshores: 
  if (pad0==0 && pad1==0 && pad2==0 && pad3==0 && pad4==0 && pad5==0 && pad6==0 && pad7==0 && pad8==0 && pad9==0 && s0==0 && s1==0 && s2==0 && s3==0 && activ2_0.position() == activ2_0.length()-1) {
    // Cronòmetre de 10 segons en marxa perquè comenci a comptar.
    timer10segons.start (true);
    // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
    timer10segons.update(clock.getDeltaMillis());  

    // Si els 10 segons ja han passat, aleshores:
    if (timer10segons.getFinish()) {
      // Reproducció d'instruccions auditives.
      activ2_1.play();
      // Reinici del cronòmetre.
      timer10segons.reset();
    }
    // En cas contrari, si s'ha activat algun sensor, aleshores:
  } else {
    // Es rebobina l'efecte de so perquè torni al principi
    activ2_1.rewind();    
    // Reinici del cronòmetre.
    timer10segons.reset();
  }

  // RETORN AL MENÚ TOT ACTIVANT AL MATEIX TEMPS EL SENSOR D'ULTRASONS SUPERIOR I INFERIOR DURANT 4 segons (aquí 2 segons i en l'estat RETORN 2 més):
  // En cas de tenir senyal en el sensor ultrasons superior i inferior, aleshores:
  if (s1 > 0 && s3 > 0) {
    // Cronòmetre de 2 segons en marxa perquè comenci a comptar.
    timer2segons.start (true);
    // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
    timer2segons.update(clock.getDeltaMillis());

    // Si els 2 segons ja han passat, aleshores:
    if (timer2segons.getFinish()) {     
      timer2segons.reset();        // Reinici del cronòmetre.
      mainStateAnterior = ACTIV2;  // Es guarda l'estat actual com anterior.
      mainState =  RETORN;         // Anem a l'estat del Retorn
    }
  }
}
