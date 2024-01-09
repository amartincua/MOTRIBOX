/*
 *    FUNCIÓ DE L'ESTAT 8: RETORN. Atura l'activitat, la reinicia i la porta a l'estat 1 del MENU.
 */

void retorn () {

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

  textSize(90);                                    // Mida del text
  fill(90, 33, 11);                                // Color de farciment 
  text("Tornant al menú...", width/2, height/2);   // Dibuix d'un text


  // RETORN AL MENÚ PRINCIPAL EN CAS D'ACTIVAR DUARNT 2S EL SENSOR D'ULTASONS SUPERIOR I INFERIOR:
  // Si tenim senyal en el sensor d'ultrasons superio i inferior, aleshores:
  if (s1 > 0 && s3 > 0) {                
    // Cronòmetre de 2 segons en marxa perquè comenci a comptar.   
    timer2segons.start (true);      
    // Actualitzem el valor del cronòmetre amb la funció update.
    timer2segons.update(clock.getDeltaMillis());

    // Si els 5 segons han finalitzat, aleshores:
    if (timer2segons.getFinish()) {       
      retorn.rewind();            // Es rebobina l'efecte de so perquè torni al principi.     
      retorn.play();              // Reproducció de l'efecte de so.     
      timer2segons.reset();       // Reinici del cronòmetre.   


      // REINICI DE LES VARIABLES de les activitats:
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

        puntuacioACTIV1 = 0;    
        encertsActiv1 = 0.0;  
        erradesActiv1 = 0.0;

        // Reiniciem el cronòmetre
        timerACTIV1.reset();
        timerACTIV1.start (false);
      }
      // REINICI DE VARIABLES ACTIVITAT2   
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

        puntuacioACTIV2 = 0;    
        encertsActiv2 = 0.0;  
        erradesActiv2 = 0.0;

        activ2_0.pause(); 
        activ2_0.rewind();

        // Reiniciem el cronòmetre
        timerACTIV2.reset();
        timerACTIV2.start (false);
      }  // FI REINICI VARIABLES ACTIVITAT 2


      mainState =  MENU;          //  Anem a l'estat MENU
    }
    // En cas de no mantenir activats els sensors d'ultraons superior i inferior, aleshores:
  } else {
    // Inicialitzem el valor del cronòmetre 
    timer2segons.reset();
    // Es retorna a l'activitat en que estavem. 
    if (mainStateAnterior == ACTIV1 ) {
      mainState =  ACTIV1;          //  Anem a l'estat ACTIV1
    } else if (mainStateAnterior == ACTIV2) {
      mainState =  ACTIV2;          //  Anem a l'estat ACTIV2
    }    

    mainStateAnterior = RETORN;
  }
}
