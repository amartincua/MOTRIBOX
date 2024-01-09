/*
 *    FUNCIÓ DE L'ESTAT 5: Fi d'activitat, ens serveix per controlar el final del joc i crear l'arxiu de registre en .CSV
 */

void fiActiv() {  

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
  image (panellFiActiv, 0, 0);         

  // TÍTOL
  fill(255, 230, 160);                 // Color de farciment 
  textSize(50);                        // Mida del text
  text("Fi de Partida", width/2, 170); // Dibuix d'un text

  // SUBTÍTOLS
  pushMatrix();                        // Funció que recorda l'últim sistema de coordenades.
  translate(width/2-130, 245);         // Translació en x i y del text.
  textSize(30);                        // Mida del text
  text("TEMPS", 0, 240);               // Dibuix d'un text
  text("PUNTUACIÓ", 260, 240);         // Dibuix d'un text
  text("Errades", -40, 485);           // Dibuix d'un text
  textSize(20);                        // Mida del text
  text("MILLOR TEMPS"+"“", 0, 385);    // Dibuix d'un text
  text("PUNTUACIÓ MÀX", 260, 385);     // Dibuix d'un text
  popMatrix();                         // Funció que restableix el sistema de coordenades.

  missatge_GameOver.play();            // Reproducció d'un missatge

  // DADES ACTIVITATS
  // ACTIVITAT 1
  if (mainStateAnterior == ACTIV1) {
    rectMode(CORNER);                                                   // Modificació de la ubicació des d'on es dibuixen els rectangles, ara des de la cantonada superior esquerra. 
    fill(255, 105, 60);                                                 // Color de farciment
    rect(731, height-320, map(erradesActiv1, 0, 100, 0, 457), 40, 2);   // Dibuix d'una barra que representa el % d'errors.
    fill(255, 230, 160);                                                // Color de farciment
    textSize(30);                                                       // Mida del text
    textAlign(LEFT, CENTER);                                            // Alineació del text a l'esquerra i al centre.
    text(int(erradesActiv1) + "%", 745, 780);                           // Dibuix del valor d'una variable    
    textAlign(CENTER, CENTER);                                          // Alineació horitzontal i vertical del text al centre.
    pushMatrix();                                                       // Funció que recorda l'últim sistema de coordenades.    
    translate(width/2-130, 245);                                        // Translació en x i y del text.
    fill(255, 230, 160);                                                // Color de farciment
    textSize(40);                                                       // Mida del text
    text(tempsACTIV1+"“", 0, 295);                                      // Dibuix del valor d'una variable
    text(puntuacioACTIV1, 260, 295);                                    // Dibuix del valor d'una variable    
    textSize(30);                                                       // Mida del text
    text(toptempsACTIV1+"“", 0, 425);                                   // Dibuix del valor d'una variable
    text(maxPuntuacioACTIV1, 260, 425);                                 // Dibuix del valor d'una variable 
    popMatrix();                                                        // Funció que restableix el sistema de coordenades.
  }

  // ACTIVITAT 2
  if (mainStateAnterior == ACTIV2) {
    rectMode(CORNER);                                                   // Modificació de la ubicació des d'on es dibuixen els rectangles, ara des de la cantonada superior esquerra. 
    fill(255, 105, 60);                                                 // Color de farciment
    rect(731, height-320, map(erradesActiv2, 0, 100, 0, 457), 40, 2);   // Dibuix d'una barra que representa el % d'errors.
    fill(255, 230, 160);                                                // Color de farciment
    textSize(30);                                                       // Mida del text
    textAlign(LEFT, CENTER);                                            // Alineació del text a l'esquerra i al centre.
    text(int(erradesActiv2) + "%", 745, 780);                           // Dibuix del valor d'una variable    
    textAlign(CENTER, CENTER);                                          // Alineació horitzontal i vertical del text al centre.
    pushMatrix();                                                       // Funció que recorda l'últim sistema de coordenades.    
    translate(width/2-130, 245);                                        // Translació en x i y del text.
    fill(255, 230, 160);                                                // Color de farciment
    textSize(40);                                                       // Mida del text
    text(tempsACTIV2+"“", 0, 295);                                      // Dibuix del valor d'una variable
    text(puntuacioACTIV2, 260, 295);                                    // Dibuix del valor d'una variable    
    textSize(30);                                                       // Mida del text
    text(toptempsACTIV2+"“", 0, 425);                                   // Dibuix del valor d'una variable
    text(maxPuntuacioACTIV2, 260, 425);                                 // Dibuix del valor d'una variable 
    popMatrix();                                                        // Funció que restableix el sistema de coordenades.
  }

  //REGISTRE DADES A UN ARXIU CSV
  // Es guarda la data (dia + mes + any) i la hora actuals a la variable corresponent.
  data = nf(day(), 2) + "/" + nf(month(), 2) + "/" + nf(year(), 4);
  hora = nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2);

  // CREACIÓ DE L'ARXIU .CSV QUE CONTINDRÀ L'INFORME DE LA SESSIÓ DE JOC 
  /*En funció de l'activitat que s'ha jugat es guarden els valors de l'activitat, temps, puntuació i errades a unes varaibles, 
   per tal d'escriure a l'arxiu .csv les dades. La funció str() s'utilitza per convertir els valors a un string*/

  // Si l'estat anterior és l'ACTIVITAT 1, aleshores:
  if (mainStateAnterior == ACTIV1) { 

    activitat = "Activitat 1";   
    temps = str(tempsACTIV1);       
    puntuacio = str(puntuacioACTIV1);  
    errades = str(int(erradesActiv1));    

    // Si s'ha establit un nou rècord de temps, aleshores:
    if (tempsACTIV1 < toptempsACTIV1) {
      recordTemps= "Nou record de temps!";
    } else {
      recordTemps= "-";
    }

    // Si s'ha establit un nou rècord de puntuació, aleshores:
    if (puntuacioACTIV1 > maxPuntuacioACTIV1 ) {
      recordPuntuacio= "Nou record de puntuació!";
    } else {
      recordPuntuacio= "-";
    }

    // Si tenim un temps millor que la passada partida, aleshores es convertirà amb el nou temps rècord.
    if (tempsACTIV1 < toptempsACTIV1  || toptempsACTIV1 == 0 ) {
      toptempsACTIV1 = tempsACTIV1;
    }
  }

  // En cas que l'estat anterior sigui l'ACTIVITAT 2, aleshores:
  if (mainStateAnterior == ACTIV2) {   

    activitat = "Activitat 2";
    temps = str(tempsACTIV2);
    puntuacio = str(puntuacioACTIV2);
    errades = str(int(erradesActiv2));

    // Si s'ha establit un nou rècord de temps, aleshores:
    if (tempsACTIV2 < toptempsACTIV2) {
      recordTemps= "Nou record de temps!";
    } else {
      recordTemps= "-";
    }

    // Si s'ha establit un nou rècord de puntuació, aleshores:
    if (puntuacioACTIV2 > maxPuntuacioACTIV2 ) {
      recordPuntuacio= "Nou record de puntuació!";
    } else {
      recordPuntuacio= "-";
    }
    // Si tenim un temps millor que la passada partida, aleshores es convertirà amb el nou temps rècord.
    if (tempsACTIV2 < toptempsACTIV2  || toptempsACTIV2 == 0 ) {
      toptempsACTIV2 = tempsACTIV2;
    }
  }

  // Si el valor de registre es false, aleshores: 
  if (registre == false) {
    // Es crea el nom de l'arxiu que contindrà el dia, mes, any, hora, minuts i segons actuals i s'indica l'extensió: .CSV, 
    nomFitxer = "Informe_MOTRIBOX_" + nf(day(), 2) + "-" + nf(month(), 2) + "-" + year() + "_" + nf(hour(), 2) +"h"+ nf(minute(), 2)+ "m" + nf(second(), 2) +"s"+ ".csv";
    // Es crea l'objecte PrintWriter i s'asigna a writer
    writer = createWriter(nomFitxer);
    // S'escriuen les columnes de l'arxiu .CSV
    writer.println("DATA,HORA,ACTIVITAT,TEMPS,PUNTUACIÓ,ERRADES,MILLOR TEMPS,MILLOR PUNTUACIÓ");    
    // S'escriuen les dades obtingudes anteriorment a l'arxiu .csv
    writer.println(data + "," + hora + "," + activitat + "," + temps + "," + puntuacio + "," + errades + "," + recordTemps + "," + recordPuntuacio );
    // S'esborra l'objecte PrintWriter, necessari per assegurar que totes les dades s'escriuen al fitxer abans que es tanqui.
    writer.flush();
    // Canvi del valor de registre a true, per tal que no es torni a crear un nou arxiu .csv
    registre = true;
  }

  // RETORN AL MENÚ TOT ACTIVANT AL MATEIX TEMPS EL SENSOR D'ULTRASONS SUPERIOR I INFERIOR:
  // En cas de tenir senyal en el sensor ultrasons superior i inferior, aleshores:
  if (s1 > 0 && s3 > 0) {
    // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
    timer0_7segons.start (true);
    // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
    timer0_7segons.update(clock.getDeltaMillis());  

    // Si els 0,7 segons ja han passat, aleshores:
    if (timer0_7segons.getFinish()) {     
      retorn.rewind();               // Es rebobina l'efecte de so perquè torni al principi.
      retorn.play();                 // Reproducció de l'efecte de so.
      missatge_GameOver.rewind();    // Es rebobina l'efecte de so perquè torni al principi.
      missatge_GameOver.pause();     // Es pausa l'efecte de so.
      timer0_7segons.reset();        // Reinici del cronòmetre.               

      // REINICI DE LES VARIABLES DE LES ACTIVITATS:

      // ACTIVITAT 1
      if (mainStateAnterior == ACTIV1) {             
        nivell = 0;        
        do {     
          talpObjectiu1 = int(random(furatX.length));  
          talpObjectiu2 = int(random(furatX.length));
        } while (talpObjectiu1 == talpObjectiu2); 
        talpObjectiu1anterior = talpObjectiu1;
        talpObjectiu2anterior = talpObjectiu2;  
        objectiuUltrasons = int(random(1, 4));
        objectiuUltrasonsAnterior = objectiuUltrasons;  
        objectiu = 0;
        talpObjectiu1PosX= furatX[talpObjectiu1]; 
        talpObjectiu2PosX = furatX[talpObjectiu2];          
        talp[0] = new Talps(talpObjectiu1PosX, talpSurt);
        talp[1] = new Talps(talpObjectiu2PosX, talpSurt);
        count = 0; 
        numTapsSimultanis = 0; 
        talpsBenTocats = 0;
        moviments = 0;
        anaritornar = 0; 
        movRestants = moviments - anaritornar;  
        ultimFuratTocat = 0; 
        padsTotsTocats = false;    
        talpObjectiu1Assolit = false;
        talpObjectiu2Assolit = false;  
        errorFurat = false; 
        instrucEndevant.pause();
        instrucEndevant.rewind();  
        puntuacioACTIV1temp = puntuacioACTIV1; 
        erradesActiv1temp = erradesActiv1; 
        puntuacioACTIV1 = 0;    
        encertsActiv1 = 0.0;  
        erradesActiv1 = 0.0;
      }

      // ACTIVITAT2      
      if (mainStateAnterior == ACTIV2) {
        numFormes = 3;      
        for (int i = 0; i < formesAtzar.length - 1; i++) {
          int index = int(random(i, formesAtzar.length)); 
          int temp = formesAtzar[i];
          formesAtzar[i] = formesAtzar[index];
          formesAtzar[index] = temp;
        }      
        for (int i = 0; i < colorsAtzar.length - 1; i++) { 
          int index = int(random(i, colorsAtzar.length)); 
          int temp = colorsAtzar[i];
          colorsAtzar[i] = colorsAtzar[index]; 
          colorsAtzar[index] = temp;
        }
        indexFormes = 0;    
        indexColors = 0;          
        formaObjectiuFILA = formesAtzar[indexFormes];      
        formaObjectiuCOLUMNA = colorsAtzar[indexColors];
        indexFormes = 0;
        indexColors = 0;
        indexFILA = 0;
        indexCOLUMNA = 0;
        objectius = new int[12];
        for (int i = 0; i < objectius.length; i++) {
          objectius[i] = 99;
        }
        indexObjectiu = 0;
        formaTocada = 0;
        formaAgafada = false; 
        sensorTactilPolsat = false;  
        barraFull = false;
        numAgafats = 0; 
        triosAconseguits= 0;
        barra = 0;        
        for (int i = 0; i < 12; i++) {  
          objectiusHistoricFILA[i] = 0;
        }               
        for (int i = 0; i < 12; i++) {
          objectiusHistoricCOLUMNA[i] = 0;
        }
        furatObjectiu = 0;
        furatObjectiuAnterior = 0;           
        puntuacioACTIV2temp = puntuacioACTIV2; 
        erradesActiv2temp = erradesActiv2;         
        puntuacioACTIV2 = 0;    
        encertsActiv2 = 0.0;  
        erradesActiv2 = 0.0;        
        activ2_0.pause(); 
        activ2_0.rewind();
      } 

      registre = false;              // Inicialització de la variable.
      mainStateAnterior = FIACTIV;   // Es guarda l'estat actual com anterior. 
      mainState =  MENU;             // Anem a l'estat del Menú.
    }
  }
}
