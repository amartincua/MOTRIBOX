/*
 *    FUNCIÓ DE L'ESTAT 3: ACTIVITAT 1: Consta de tres nivells més un d'inicial.
 */

void activ1() { 

  // Cronòmetre de temps que començarà a comptar el temps a partir del nivell 1 fins a la finalització de l'activitat 1.       
  timerACTIV1.start (true); 
  // Actualització del valor del cronòmetre anterior amb la funció update, utilitzant com a paràmetre el temps que ha passat.
  timerACTIV1.update(clock.getDeltaMillis());  

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

  // DIBUIX DE LES MUNTANYES: 
  image (fonsACTIV1Muntanyes, 0, 0);

  // DIBUIXOS INFORMACIÓ
  // Modificació de la ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra. 
  imageMode (CORNER);
  // Dibuix de la imatge de la icona de tornar al menú principal.
  image (tornarMenu, 30, 30);              
  // Dibuix de les imatges de les estrelles buides de forma ordenada i equidistant, a través d'un bucle.
  for (int i = 0; i < 4; i++) {  
    image (estrellaBuida, 1450+ i*120, 30 );
  }

  // DIBUIX DE LA PEDRA:
  imageMode(CENTER);
  image (pedra, width/2, 580);   
  imageMode(CORNER);

  // DIBUIX FURATS o SENSORS TÀCTILS BASE DE FONS
  fill(38, 27, 13);                                   // Color de farciment.
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

  // DIBUIX FURATS o SENSORS TÀCTILS QUAN S'HAN TOCAT
  // Si tenim senyal del sensor tàctil corresponent: dibuixem un furat de color ataronjat.   
  if (pad0==1 || pad1==1 || pad2==1 || pad3==1 || pad4==1 || pad5==1 || pad6==1 || pad7==1 || pad8==1 || pad9==1 ) {
    fill(255, 140, 35);
  }  
  if (pad0==1) {    
    circle(furat1X, furat1Y, 100);
  } 
  if (pad1==1) {    
    circle(furat2X, furat2Y, 100);
  } 
  if (pad2==1) {  
    circle(furat3X, furat3Y, 100);
  } 
  if (pad3==1) {
    circle(furat4X, furat4Y, 100);
  } 
  if (pad4==1) { 
    circle(furat5X, furat5Y, 100);
  } 
  if (pad5==1) {   
    circle(furat6X, furat6Y, 100);
  } 
  if (pad6==1) {
    circle(furat7X, furat7Y, 100);
  } 
  if (pad7==1) {
    circle(furat8X, furat8Y, 100);
  } 
  if (pad8==1) {
    circle(furat9X, furat9Y, 100);
  } 
  if (pad9==1) {
    circle(furat10X, furat10Y, 100);
  } 

  // DIBUIX DE LES FLORS DEL PAISATGE: 
  image (fonsFlors, 0, 760); 

  // En funció del valor de la variable nivell tindrem un mode de joc diferent:
  switch (nivell) {      
  case 0:   // Si s'està al nivell 0, aleshores:   
    /* ***************************************************************************************************************
     * NIVELL 0 : TOCAR TOTS ELS SENSORS TÀCTILS ABANS DE COMENÇAR
     *****************************************************************************************************************/

    // Reproducció d'instruccions.
    activ1_0.play();    

    // Si s'han tocat tots els pads a la vegada, aleshores:  
    if (pad0==1 && pad1==1 && pad2==1 && pad3==1 && pad4==1 && pad5==1 && pad6==1 && pad7==1 && pad8==1 && pad9==1) {
      // Reproducció d'instruccions auditives.
      instrucEndevant.play();   
      // Canvi de valor de la variable padsTotsTocats.
      padsTotsTocats = true;
    }
    // Si s'han tocat tots els pads i després s'han deixat, aleshores:
    if (padsTotsTocats == true && pad0==0 && pad1==0 && pad2==0 && pad3==0 && pad4==0 && pad5==0 && pad6==0 && pad7==0 && pad8==0 && pad9==0) {
      // Es passa al nivell 1
      nivell = 1;
      // Es pausa i rebobina l'efecte de so.
      activ1_0.pause(); 
      activ1_0.rewind();       

      // Reinici de la variable padsTotsTocats
      padsTotsTocats = false;
    }
    //FI NIVELL 0
    break;
  case 1:    // Si s'està al nivell 1, aleshores:      
    /* ***************************************************************************************************************
     * NIVELL 1: TOCAR UN TALP ALEATORI
     *****************************************************************************************************************/

    // DIBUIX DE LES ESTRELLES (NIVELLS)
    // En funció del valor de nivell, es dibuixen més o menys estrelles plenes.
    image (estrellaPlena, 1450, 30 );             

    // Controlem les instruccions sonores d'ajuda en cas de no activar cap sensor tàctil cada 10 segons
    // Si no tenim senyal de cap sensor tàctil
    if (pad0==0 && pad1==0 && pad2==0 && pad3==0 && pad4==0 && pad5==0 && pad6==0 && pad7==0 && pad8==0 && pad9==0) {
      // Cronòmetre de 10 segons en marxa perquè comenci a comptar.
      timer10segons.start (true);
      // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer10segons.update(clock.getDeltaMillis());  

      // Si els 10 segons ja han passat, aleshores:
      if (timer10segons.getFinish()) {
        // Reproducció d'instruccions auditives.
        activ1_1.play();
        // Reinici del cronòmetre.
        timer10segons.reset();
      }
      // En cas contrari, si s'ha activat algun sensor, aleshores:
    } else {
      // Es rebobina l'efecte de so perquè torni al principi
      activ1_1.rewind();    
      // Reinici del cronòmetre.
      timer10segons.reset();
    }

    // Iteració per l'array dels valors, a partir dels sensors tàctils (4)
    for (int i=4; i<valors.length; i++) {

      // Si es toca algun sensor tàctil, aleshores:
      if (valors[i]==1) {     
        // Es compta el nombre de tocs en cada iteració.
        count++;
        // Es guarda l'últim sensor tàctil o furat tocat
        ultimFuratTocat = i-4;
      }

      // Si es toca un sensor tàctil a on no hi ha cap talp, aleshores: 
      if ((valors[i] == 1 && i-4 !=talpObjectiu1 )) {  
        // Reproducció d'un efecte de so.  
        hitNo.play();
        // S'indica l'error amb un true a la variable errorFurat.
        errorFurat= true;
      }

      // Si el sensor que s'ha tocat incorrectament s'ha deixat de tocar, aleshores
      if (errorFurat && valors[ultimFuratTocat+4]== 0) {
        // Augmentem en un les errades de l'activitat 1
        erradesActiv1++;
        // Reiniciem la variable.
        errorFurat= false;
      }

      // Si ja no hi ha senyal en l'últim  furat tocat, aleshores:
      if (valors[ultimFuratTocat+4] == 0 ) {
        // Es rebobina l'efecte de so perquè torni al principi.
        hitNo.rewind();
        // Es pausa l'efecte de so.
        hitNo.pause();
      }
    } // Fi iteració

    // Es guarda el valor de tocs simultanis en una variable per tal d'activar més tard, un so indicant el problema  
    numTapsSimultanis = count;  

    // Reinicialització del comptador a 0, per tal de tornar a comptar des de 0.
    count = 0;  


    // Si estem tocant un sensor a la vegada, aleshores:
    if (numTapsSimultanis < 2) {      

      // Si s'ha tocat el talp objectiu, aleshores: 
      if (valors[talpObjectiu1+4] == 1 ) {

        // Dibuix del talp tocat
        talp[0].imgTalp = talpTocat;    

        // Posem el cronòmetre de 2 segons en marxa perquè comenci a comptar.
        timer2segons.start (true);   

        // Guardem l'objectiu actual en una variable per després evitar que es repeteixi.
        talpObjectiu1anterior = talpObjectiu1;

        // Marquem com assolit l'objectiu, per controlar sons.
        talpObjectiu1Assolit= true;
      } 


      // S'ctualitza el valor del cronòmetre de 2 segons amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer2segons.update(clock.getDeltaMillis());       

      // Si s'ha assolit l'objectiu, aleshores:
      if (talpObjectiu1Assolit) {
        // Es reprodueix l'efecte de so.
        hitOk.play();
        // Es rebobina l'efecte de so perquè torni al principi.
        fiu.rewind();
        // Es pausa l'efecte de so.
        fiu.pause();
      } else {
        // Es rebobina l'efecte de so perquè torni al principi.
        hitOk.rewind();
        // Es pausa l'efecte de so.
        hitOk.pause();
      }

      // Si els 2 segons ja han passat, aleshores:
      if (timer2segons.getFinish()) {  

        // CANVI ALEATORI DEL TALP OBJECTIU
        do {
          // El talp objectiu que s'ha de tocar estarà en alguna de les 10 posicions de l'arrray furatX, per tant, es genera un nombre aleatori entre 0 i 9, ambdós inclosos.
          talpObjectiu1 = int(random(furatX.length));  
          // En cas que el talp objectiu anterior sigui el mateix que el que ha sortit ara, aleshores repetim el bucle i tornem a elegir un altre talp objectiu fins que sigui diferent.
        } while (talpObjectiu1anterior == talpObjectiu1);  

        // Es comptabilitza un talp tocat correctament en el nivell actual
        talpsBenTocats++;

        // S'assigna la posició que ha de tenir el talp objectiu que ha sortit 
        talp[0].posX = furatX[talpObjectiu1];    

        // S'assigna el dibuix de la imatge del talp que surt
        talp[0].imgTalp = talpSurt;   

        // Es reprodueix un efecte de so.
        fiu.play();   

        // Reinici del cronòmetre.
        timer2segons.reset();                
        talpObjectiu1Assolit= false;
      }

      // En cas de tocar 2 o més sensors tàctils, aleshores:
    } else {      
      // Reproducció d'un so avisant del problema
      massaDits1.play();         

      // Dibuix dels furats que estem tocant amb un color vermell, per indicar el problema.
      fill(255, 91, 77);
      if (pad0==1) {                    
        ellipse(furat1X, furat1Y, 100, 100);
      } 
      if (pad1==1) {             
        ellipse(furat2X, furat2Y, 100, 100);
      } 
      if (pad2==1) {            
        ellipse(furat3X, furat3Y, 100, 100);
      } 
      if (pad3==1) {        
        ellipse(furat4X, furat4Y, 100, 100);
      } 
      if (pad4==1) {        
        ellipse(furat5X, furat5Y, 100, 100);
      } 
      if (pad5==1) {       
        ellipse(furat6X, furat6Y, 100, 100);
      } 
      if (pad6==1) {        
        ellipse(furat7X, furat7Y, 100, 100);
      }         
      if (pad7==1) {       
        ellipse(furat8X, furat8Y, 100, 100);
      }         
      if (pad8==1) {        
        ellipse(furat9X, furat9Y, 100, 100);
      } 
      if (pad9==1) {        
        ellipse(furat10X, furat10Y, 100, 100);
      }
    }
    // Només si s'ha acabat de reproduir l'alerta sonora de tocar amb més de dos dits, aleshores;
    if (!massaDits1.isPlaying()) {
      // Es rebobina l'efecte de so.
      massaDits1.rewind();  
      // Es pausa l'efecte de so.
      massaDits1.pause();
    }

    // Cridem el mètode de classe Talps per dibuixar el talp.   
    talp[0].dibuixar();

    // Si hem tocat 10 talps en aquest nivell, aleshores:
    if (talpsBenTocats == 10 ) {            
      // Actualitzem els encerts del nivell
      encertsActiv1 += talpsBenTocats;
      // Reiniciem els talps tocats
      talpsBenTocats = 0;
      // Reproducció d'instruccions auditives pel següent nivell
      activ1_2.play();
      // Passem al nivell 2
      nivell=2;
    }
    // FI NIVELL 1
    break;
  case 2: // Si s'està al nivell 2, aleshores:                   
    /* ***************************************************************************************************************
     * NIVELL 2: TOCAR DOS TALPS ALEATORIS
     *****************************************************************************************************************/

    // DIBUIX DE LES ESTRELLES (NIVELLS)
    // En funció del valor de nivell, es dibuixen més o menys estrelles plenes i de forma equidistant usant un bucle.    
    for (int i = 0; i < 2; i++) {
      image (estrellaPlena, 1450+ i*120, 30 );
    }  

    // Controlem les instruccions sonores d'ajuda en cas de no activar cap sensor tàctil cada 10 segons
    // Si no tenim senyal de cap sensor tàctil
    if (pad0==0 && pad1==0 && pad2==0 && pad3==0 && pad4==0 && pad5==0 && pad6==0 && pad7==0 && pad8==0 && pad9==0) {
      // Cronòmetre de 10 segons en marxa perquè comenci a comptar.
      timer10segons.start (true);
      // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer10segons.update(clock.getDeltaMillis());  

      // Si els 10 segons ja han passat, aleshores:
      if (timer10segons.getFinish()) {
        // Reproducció d'instruccions auditives.
        activ1_2.play();
        // Reinici del cronòmetre.
        timer10segons.reset();
      }
      // En cas contrari, si s'ha activat algun sensor, aleshores:
    } else {
      // Es rebobina l'efecte de so perquè torni al principi
      activ1_2.rewind();    
      // Reinici del cronòmetre.
      timer10segons.reset();
    }

    // Iteració per l'array dels valors, a partir dels sensors tàctils (4)
    for (int i=4; i<valors.length; i++) {

      // Si es toca algun sensor tàctil, aleshores:
      if (valors[i]==1) {     
        // Es compta el nombre de tocs en cada iteració.
        count++;
        // Es guarda l'últim sensor tàctil o furat tocat
        ultimFuratTocat = i-4;
      }

      // Si es toca un sensor tàctil a on no hi ha cap talp, aleshores: 
      if ((valors[i] == 1 && i-4 !=talpObjectiu1) && (valors[i] == 1 && i-4 !=talpObjectiu2) ) {  
        // Reproducció d'un efecte de so.  
        hitNo.play();
        // S'indica l'error amb un true a la variable errorFurat.
        errorFurat= true;
      }

      // Si el sensor que s'ha tocat incorrectament s'ha deixat de tocar, aleshores
      if (errorFurat && valors[ultimFuratTocat+4]== 0) {
        // Augmentem en un les errades de l'activitat 1
        erradesActiv1++;
        // Reiniciem la variable.
        errorFurat= false;
      }

      // Si ja no hi ha senyal en l'últim furat tocat, aleshores:
      if (valors[ultimFuratTocat+4] == 0 ) {
        // Es rebobina l'efecte de so perquè torni al principi.
        hitNo.rewind();
        // Es pausa l'efecte de so.
        hitNo.pause();
      }
    } // Fi iteració

    // Es guarda el valor de tocs simultanis en una variable per tal d'activar més tard, un so indicant el problema  
    numTapsSimultanis = count;   

    // Reinicialització del comptador a 0, per tal de tornar a comptar des de 0.
    count = 0;        

    // Si estem tocant dos sensors o un a la vegada, aleshores:
    if (numTapsSimultanis<3) {      

      // Si s'han tocat els dos talps objectiu, aleshores: 
      if (valors[talpObjectiu1+4] == 1 && valors[talpObjectiu2+4] == 1  ) {

        // Dibuix del talps tocats
        talp[0].imgTalp = talpTocat;   
        talp[1].imgTalp = talpTocat;   

        // Guardem l'objectiu 1 actual en una variable per després evitar que es repeteixi.
        talpObjectiu1anterior = talpObjectiu1;

        // Guardem l'objectiu 2 actual en una variable per després evitar que es repeteixi.
        talpObjectiu2anterior = talpObjectiu2;

        // Marquem com assolit l'objectiu1, per controlar sons.
        talpObjectiu1Assolit= true;

        // Marquem com assolit l'objectiu2, per controlar sons.
        talpObjectiu2Assolit= true;
      } 

      // Si s'ha tocat el talp de l'objectiu 1, aleshores
      if (valors[talpObjectiu1+4] == 1 ) {
        // Dibuix del talp tocat
        talp[0].imgTalp = talpTocat;
      } else {
        // Dibuix del talp que surt
        talp[0].imgTalp = talpSurt;
      }

      // Si s'ha tocat el talp de l'objectiu 2, aleshores
      if (valors[talpObjectiu2+4] == 1 ) {
        // Dibuix del talp tocat
        talp[1].imgTalp = talpTocat;
      } else {
        // Dibuix del talp que surt
        talp[1].imgTalp = talpSurt;
      }

      // Si s'ha tocat un dels dos objectius, aleshores:
      if (valors[talpObjectiu1+4] == 1 || valors[talpObjectiu2+4] == 1  ) {
        // Es reprodueix l'efecte de so.
        agafat.play();
        // Es rebobina l'efecte de so perquè torni al principi.
        fiu.rewind();
        // Es pausa l'efecte de so.
        fiu.pause();
      } else {
        // Es rebobina l'efecte de so perquè torni al principi.
        agafat.rewind();
        // Es pausa l'efecte de so.
        agafat.pause();
      }

      // Si s'han assolit els dos objectiu, aleshores:
      if (talpObjectiu1Assolit && talpObjectiu2Assolit ) {
        // Posem el cronòmetre de 2 segons en marxa perquè comenci a comptar.
        timer2segons.start (true);
        // Dibuix del talp 1 tocat
        talp[0].imgTalp = talpTocat; 
        // Dibuix del talp 2 tocat
        talp[1].imgTalp = talpTocat; 
        // Es reprodueix un efecte de so.
        hitOk.play();
        // Es rebobina un efecte de so perquè torni al principi.
        fiu.rewind();
        // Es pausa un efecte de so.
        fiu.pause();

        // En cas contrari, aleshores:
      } else {
        // Es rebobina un efecte de so perquè torni al principi.
        hitOk.rewind();
        // Es pausa un efecte de so.
        hitOk.pause();
      }

      // S'actualitza el valor del cronòmetre de 2 segons amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer2segons.update(clock.getDeltaMillis());  

      // Si els 2 segons ja han passat, aleshores:
      if (timer2segons.getFinish()) {  

        // CANVI ALEATORI DEL TALP OBJECTIU 1 I DEL TALP OBJECTIU 2
        do {
          // CANVI ALEATORI DEL TALP OBJECTIU 1
          do {
            // El talp objectiu 1 que s'ha de tocar estarà en alguna de les 10 posicions de l'arrray furatX, per tant, es genera un nombre aleatori entre 0 i 9, ambdós inclosos.
            talpObjectiu1 = int(random(furatX.length));  
            // En cas que el talp objectiu 1 anterior sigui el mateix que el que ha sortit ara o igual que el talp objectiu 2 anterior, aleshores repetim el bucle i tornem a elegir un altre talp objectiu 1 fins que sigui diferent.
          } while (talpObjectiu1anterior == talpObjectiu1 || talpObjectiu2anterior == talpObjectiu1 );   

          // CANVI ALEATORI DEL TALP OBJECTIU 2
          do {
            // El talp objectiu 2 que s'ha de tocar estarà en alguna de les 10 posicions de l'arrray furatX, per tant, es genera un nombre aleatori entre 0 i 9, ambdós inclosos.
            talpObjectiu2 = int(random(furatX.length));  
            // En cas que el talp objectiu 2 anterior sigui el mateix que el que ha sortit ara o igual que el talp objectiu 1 anterior, aleshores repetim el bucle i tornem a elegir un altre talp objectiu fins que sigui diferent.
          } while (talpObjectiu2anterior == talpObjectiu2 || talpObjectiu1anterior == talpObjectiu2);
          // En cas que el talp objectiu1 coinsideix amb el talp objectiu2, aleshores, repetim tot el procés desde el primer "do" per elegir uns objectius diferents.
        } while (talpObjectiu1 == talpObjectiu2);

        // S'assigna la posició que ha de tenir el talp objectiu que ha sortit 
        talp[0].posX = furatX[talpObjectiu1];    

        // S'assigna el dibuix de la imatge del talp que surt
        talp[0].imgTalp = talpSurt;         

        // S'assigna la posició que ha de tenir el talp objectiu que ha sortit 
        talp[1].posX = furatX[talpObjectiu2];    

        // S'assigna el dibuix de la imatge del talp que surt
        talp[1].imgTalp = talpSurt;   

        // Es comptabilitza un talp tocat correctament en el nivell actual
        talpsBenTocats++;

        // Es reprodueix un efecte de so.
        fiu.play();   

        // Reinici del cronòmetre i dels dos objectius assolits.                   
        timer2segons.reset();         
        talpObjectiu1Assolit= false;
        talpObjectiu2Assolit= false;
      }

      // En cas de tocar 2 o més sensors tàctils, aleshores:
    } else {      
      // Reproducció d'un so avisant del problema
      massaDits2.play();         

      // Dibuix dels furats que estem tocant amb un color vermell, per indicar el problema.
      fill(255, 91, 77);
      if (pad0==1) {                    
        ellipse(furat1X, furat1Y, 100, 100);
      } 
      if (pad1==1) {             
        ellipse(furat2X, furat2Y, 100, 100);
      } 
      if (pad2==1) {            
        ellipse(furat3X, furat3Y, 100, 100);
      } 
      if (pad3==1) {        
        ellipse(furat4X, furat4Y, 100, 100);
      } 
      if (pad4==1) {        
        ellipse(furat5X, furat5Y, 100, 100);
      } 
      if (pad5==1) {       
        ellipse(furat6X, furat6Y, 100, 100);
      } 
      if (pad6==1) {        
        ellipse(furat7X, furat7Y, 100, 100);
      }         
      if (pad7==1) {       
        ellipse(furat8X, furat8Y, 100, 100);
      }         
      if (pad8==1) {        
        ellipse(furat9X, furat9Y, 100, 100);
      } 
      if (pad9==1) {        
        ellipse(furat10X, furat10Y, 100, 100);
      }
    }

    // Només si s'ha acabat de reproduir l'alerta sonora de tocar amb més de dos dits, aleshores;
    if (!massaDits2.isPlaying()) {
      // Es rebobina l'efecte de so.
      massaDits2.rewind();  
      // Es pausa l'efecte de so.
      massaDits2.pause();
    }

    // Cridem el mètode dibuixar() de classe Talps per dibuixar els 2 talps.
    for (int i=0; i<talp.length; i++) {         
      talp[i].dibuixar();
    }

    // Si s'han tocat 10 parelles de talps (20 talps) en aquest nivell, aleshores:
    if (talpsBenTocats == 10 ) {
      // Passem al nivell 3
      nivell=3;     
      // Actualitzem els encerts del nivell
      encertsActiv1 += talpsBenTocats;
      // Reiniciem els talps tocats
      talpsBenTocats = 0;
      // Reproducció d'instruccions auditives pel següent nivell
      activ1_3.play();
    }
    // Fi Nivell 2
    break;
  case 3:    // Si s'està al nivell 3, aleshores:     
    /* ***************************************************************************************************************
     * NIVELL 3: DESCÀRREGUES ELÈCTRIQUES A UN TALP ALEATORI
     *****************************************************************************************************************/

    // DIBUIX DE LES ESTRELLES (NIVELLS)
    // En funció del valor de nivell, es dibuixen més o menys estrelles plenes i de forma equidistant usant un bucle.     
    for (int i = 0; i < 3; i++) {
      image (estrellaPlena, 1450+ i*120, 30 );
    }    

    // Controlem les instruccions sonores d'ajuda en cas de no activar cap sensor tàctil cada 10 segons
    // Si no tenim senyal de cap sensor tàctil
    if (pad0==0 && pad1==0 && pad2==0 && pad3==0 && pad4==0 && pad5==0 && pad6==0 && pad7==0 && pad8==0 && pad9==0) {
      // Cronòmetre de 10 segons en marxa perquè comenci a comptar.
      timer10segons.start (true);
      // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer10segons.update(clock.getDeltaMillis());  

      // Si els 10 segons ja han passat, aleshores:
      if (timer10segons.getFinish()) {
        // Reproducció d'instruccions auditives.
        activ1_3.play();
        // Reinici del cronòmetre.
        timer10segons.reset();
      }
      // En cas contrari, si s'ha activat algun sensor, aleshores:
    } else {
      // Es rebobina l'efecte de so perquè torni al principi
      activ1_3.rewind();   
      activ1_3.pause();   
      // Reinici del cronòmetre.
      timer10segons.reset();
    }

    // Iteració per l'array dels valors, a partir dels sensors tàctils (4)
    for (int i=4; i<valors.length; i++) {

      // Si es toca algun sensor tàctil, aleshores:
      if (valors[i]==1) {     
        // Es compta el nombre de tocs en cada iteració.
        count++;
        // Es guarda l'últim sensor tàctil o furat tocat
        ultimFuratTocat = i-4;
      }

      // si hem aixecat el dit de l'ultim sensor tàctil
      if ((valors[talpObjectiu1anterior+4] == 0 )) {  

        // Si es toca un sensor tàctil a on no hi ha cap talp, aleshores: 
        if ((valors[i] == 1 && i-4 !=talpObjectiu1 )) {  
          // Reproducció d'un efecte de so.  
          hitNo.play();
          // S'indica l'error amb un true a la variable errorFurat.
          errorFurat= true;
        }
      }

      // Si el sensor que s'ha tocat incorrectament s'ha deixat de tocar, aleshores
      if (errorFurat && valors[ultimFuratTocat+4]== 0) {
        // Augmentem en un les errades de l'activitat 1
        erradesActiv1++;
        // Reiniciem la variable.
        errorFurat= false;
      }


      // Si ja no hi ha senyal en l'ultim furat tocat, aleshores:
      if (valors[ultimFuratTocat+4] == 0 ) {
        // Es rebobina l'efecte de so perquè torni al principi.
        hitNo.rewind();
        // Es pausa l'efecte de so.
        hitNo.pause();
      }
    } // Fi iteració


    // Es guarda el valor de tocs simultanis en una variable per tal d'activar més tard un so indicant el problema  
    numTapsSimultanis = count;   

    // Reinicialització del comptador a 0, per tal de tornar a comptar des de 0.
    count = 0;                      

    // Cada cop que la variable moviments tingui el valor de 0, aleshores:  
    if (moviments == 0) {
      // La variable moviments tindrà un nou valor aleatori: un nombre enter entre l'1 i el 3, aquest seran els moviments que s'hauran de fer d'anada i tornada en cada sensor.
      moviments = int(random(1, 4));
    }

    // Si s'ha tocat el talp objectiu, aleshores: 
    if (valors[talpObjectiu1+4] == 1 ) {
      // Dibuix del talp tocat
      talp[0].imgTalp = talpTocat;    
      // Reproducció d'un efecte de so.  
      agafat.play();
    } else {
      // Dibuix del talp que surt
      talp[0].imgTalp = talpSurt;   
      // Es rebobina l'efecte de so perquè torni al principi.
      agafat.rewind();          
      // Es pausa l'efecte de so.
      agafat.pause();
    }

    // Control dels efectes sonors en funció de la variable moviments, es reproduiran fins a tres sons diferents i l'últim so sempre serà el mateix l'obj3.
    if (moviments == 1) {
      if (anaritornar==1) {
        obj3.play();
      }
    } 

    if (moviments == 2) {
      if (anaritornar==1) {
        obj2.play();
      } else if (anaritornar==2) {
        obj3.play();
      }
    }

    if (moviments == 3) {
      if (anaritornar==1) {
        obj1.play();
      } else if (anaritornar==2) {
        obj2.play();
      } else if (anaritornar==3) {
        obj3.play();
      }
    }

    // Es calculen els moviments restants a realitzar, per tal de dibuixar-los per pantalla (acció que té lloc en el mètode dibuixar() de la classe Fletxa).
    movRestants = moviments-anaritornar; 

    // Si es toca el sensor tàctil a on tenim el talp i també s'activa el sensor d'ultrasons objectiu, aleshores:
    if (valors[talpObjectiu1+4] == 1 && valors[objectiuUltrasons] > 0 ) {

      // En funció de cada sensor objectiu que s'hagi d'activar, es crida el mètode de l'efecte d'electricitat per cada sensor corresponent
      // SENSOR ESQUERRE:
      if (objectiuUltrasons == 0 ) {          
        fletxaEsquerra.electre();         
        // SENSOR SUPERIOR:
      } else if (objectiuUltrasons == 1) {               
        fletxaSuperior.electre();         
        // SENSOR DRET:
      } else if (objectiuUltrasons == 2) {              
        fletxaDreta.electre();         
        // SENSOR INFERIOR:
      } else if (objectiuUltrasons == 3) {            
        fletxaInferiro.electre();
      } 
      // Dibuix del talp electritzat
      talp[0].imgTalp = talpElectric;  

      // Si es fa un moviment de fora cap a la caixa fins un punt allunyat de la caixa, aleshores:
      if (valors[objectiuUltrasons] > 0 && valors[objectiuUltrasons] <= 85 && objectiu == 0) {
        // S'ha completat el primer objectiu per poder validar el moviment.
        objectiu = 1;
      }      
      // Si es continua el moviment cap a la caixa fins a una mica més de la meitat aproximadament, aleshores:
      if (valors[objectiuUltrasons] > 85  && valors[objectiuUltrasons] <= 170  && objectiu == 1) {
        // S'ha completat el segon objectiu per poder validar el moviment.
        objectiu = 2;
      }     
      // Si es continua el moviment cap a la caixa fins arribar a tocar-la , aleshores:
      if (valors[objectiuUltrasons] > 170  && objectiu == 2) {
        // S'ha completat el tercer objectiu per poder validar el moviment.
        objectiu = 3;
      }

      if (objectiu == 3 && movRestants >= 0 ) {
        // Es reinicia l'objectiu a 0
        objectiu = 0;
        // Es comptabilitza una anada i tornada.
        anaritornar++;
      }

      // En cas contrari, si no es toca el sensor tàctil a on tenim el talp i no s'activa el sensor d'ultrasons objectiu, aleshores:
    } else {
      // Es reinicia l'objectiu a 0
      objectiu = 0;   
      // Es pausa l'efecte de so.
      electra.pause(); 
      // Es recupera l'aspecte de les fletxes
      fletxaEsquerra.colorInt = color(255, 91, 77);
      fletxaSuperior.colorInt = color(125, 200, 80);
      fletxaDreta.colorInt = color(95, 160, 220);
      fletxaInferiro.colorInt = color(250, 250, 77);
    }

    // Si arribem al final de l'efecte de so, aleshores:
    if ( electra.position() == (electra.length()) ) {     
      electra.rewind();  // Es rebobina al principi de l'efecte de so.
    }

    // MOVIMENTS BEN REALITZATS
    // Si s'han fet els moviments necessaris i s'ha acabat de reproduir l'últim so obj3, aleshores:
    if (anaritornar == moviments && obj3.position() == obj3.length()-1) {
      // Es comptabilitza un talp tocat correctament en el nivell actual
      talpsBenTocats++;

      // Reinici de variable
      anaritornar = 0;      

      // Es reprodueix un efecte de so.
      fiu.play();

      // Es guarda l'objectiu del talp actual en una variable per tal que quan es generi un altre objectiu aquest no es repeteixi.
      talpObjectiu1anterior= talpObjectiu1;
      // Es guarda l'objectiu del sensor d'ultrasons actual en una variable, per tal que quan es generi un altre objectiu aquest no es repeteixi.
      objectiuUltrasonsAnterior = objectiuUltrasons;

      // CANVI ALEATORI DEL TALP OBJECTIU
      do {
        // El talp objectiu que s'ha de tocar estarà en alguna de les 10 posicions de l'arrray furatX, per tant, es genera un nombre aleatori entre 0 i 9, ambdós inclosos.
        talpObjectiu1 = int(random(furatX.length));  
        // En cas que el talp objectiu anterior sigui el mateix que el que ha sortit ara, aleshores repetim el bucle i tornem a elegir un altre talp objectiu fins que sigui diferent.
      } while (talpObjectiu1anterior == talpObjectiu1);    

      // CANVI ALEATORI DEL SENSOR D'ULTRASONS OBJECTIU QUE S'HAURÀ D'ACTIVAR EN FUNCIÓ DEL TALP OBJECTIU, és a dir en funció del talp que hagi sortit.           
      do {
        // Si el talp ha sortit en algun sensor que es pugui activar amb la mà esquerra (0,1,2,3 o 4), aleshores:
        if (talpObjectiu1 >=0 && talpObjectiu1<5) {
          // El sensor aleatori que s'ha d'activar serà el superior dret, o inferior (1,2 o 3)           
          objectiuUltrasons = int(random(1, 4));
          // Si talp ha sortit en algun sensor que es pugui activar amb la mà dreta, aleshores:
        } else if (talpObjectiu1>4 && talpObjectiu1<10) {         
          do {
            // El sensor aleatori que s'ha d'activar serà l'esquerra, superior o inferior (0,1 o 3), per tanT, s'ha de generar un nombre aleatori entre 0 i 3 (4 no inclòs)
            objectiuUltrasons = int(random(0, 4));  
            // En cas que surti el número 2 (Sensor Ultrasons Dret) repetim el bucle i tornem a elegir un altre nombre fins que surti diferent de 2, així tenim en compte l'ergonomia a l'hora de fer els moviments.
          } while (objectiuUltrasons == 2);
        }
        // En cas que el sensor d'ultrasons anterior sigui el mateix que el que ha sortit ara, aleshores repetim el bucle i tornem a elegir un altre sensor fins que sigui diferent
      } while (objectiuUltrasonsAnterior == objectiuUltrasons);

      // S'assigna la posició que ha de tenir el talp objectiu que ha sortit 
      talp[0].posX = furatX[talpObjectiu1];    

      // S'assigna el dibuix de la imatge del talp que surt
      talp[0].imgTalp = talpSurt;

      // Reinici de variables
      moviments = 0;    
      obj1.rewind(); 
      obj1.pause(); 
      obj2.rewind();  
      obj2.pause();
      obj3.rewind();  
      obj3.pause();
      fiu.rewind();
      fiu.pause();
    } 

    // DIBUIX DE LES FLETXES I L'OSCIL·LACIÓ EN FUNCIÓ DEL SENSOR D'ULTRASONS QUE S'HA D'ACTIVAR I ILUMINACIÓ DEL LED CORRESPONENT:
    // SENSOR ESQUERRE:    
    if (objectiuUltrasons == 0 ) {
      fletxaEsquerra.dibuixar();    
      fletxaEsquerra.oscilacio();
      // S'envia una R al port en sèrie per tal d'encendre el led VERMELL.
      myPort.write("R");        
      // SENSOR SUPERIOR:
    } else if (objectiuUltrasons == 1) {
      fletxaSuperior.dibuixar();
      fletxaSuperior.oscilacio();
      // S'envia una G al port en sèrie per tal d'encendre el led VERD.
      myPort.write("G");  
      // SENSOR DRET:
    } else if (objectiuUltrasons == 2) {
      fletxaDreta.dibuixar(); 
      fletxaDreta.oscilacio();
      // S'envia una B al port en sèrie per tal d'encendre el led BLAU.
      myPort.write("B");  
      // SENSOR INFERIOR:
    } else if (objectiuUltrasons == 3) {
      fletxaInferiro.dibuixar();
      fletxaInferiro.oscilacio();
      // S'envia una Y al port en sèrie per tal d'encendre el led GROC.
      myPort.write("Y");
    }


    // Si estem tocant un sensor a la vegada, aleshores:
    if (numTapsSimultanis<2) {      
      massaDits1.rewind();        // Rebobinem un so.
      massaDits1.pause();         // Posem en pausa un so.

      // En cas de tocar 2 o més sensors tàctils, aleshores:
    } else {      
      // Reproducció d'un so avisant del problema
      massaDits1.play();         

      // Dibuix dels furats que estem tocant amb un color vermell, per indicar el problema.
      fill(255, 91, 77);
      if (pad0==1) {                    
        ellipse(furat1X, furat1Y, 100, 100);
      } 
      if (pad1==1) {             
        ellipse(furat2X, furat2Y, 100, 100);
      } 
      if (pad2==1) {            
        ellipse(furat3X, furat3Y, 100, 100);
      } 
      if (pad3==1) {        
        ellipse(furat4X, furat4Y, 100, 100);
      } 
      if (pad4==1) {        
        ellipse(furat5X, furat5Y, 100, 100);
      } 
      if (pad5==1) {       
        ellipse(furat6X, furat6Y, 100, 100);
      } 
      if (pad6==1) {        
        ellipse(furat7X, furat7Y, 100, 100);
      }         
      if (pad7==1) {       
        ellipse(furat8X, furat8Y, 100, 100);
      }         
      if (pad8==1) {        
        ellipse(furat9X, furat9Y, 100, 100);
      } 
      if (pad9==1) {        
        ellipse(furat10X, furat10Y, 100, 100);
      }
    }

    // Cridem el mètode de classe Talps per dibuixar el talp.   
    talp[0].dibuixar();

    // Si hem tocat 5 talps en aquest nivell, aleshores:
    if (talpsBenTocats == 5 ) {     
      // Actualitzem els encerts del nivell
      encertsActiv1 += talpsBenTocats; 
      // Reiniciem els talps tocats
      talpsBenTocats = 0;   
      // Canvi de nivell
      nivell = 4;
    }
    // FI NIVELL 3       
    break;

  case 4: // Si s'està al nivell 4 (nivell per fer càlculs de puntuació i temps), aleshores:     
    // Pausa de l'efecte de so
    electra.pause();

    // CÀLCUL DE LA PUNTUACIÓ
    // Sí tenim encerts, aleshores:
    if (encertsActiv1 > 0) {
      // La puntuació obtinguda, en tant per cent, es calcula segons la formula: Puntuació = (Encerts / (Encerts+Errades)*100, s'arrodoneix perquè doni un nombre enter amb la funció round().
      puntuacioACTIV1 = round(((encertsActiv1/(encertsActiv1+erradesActiv1))*100));
      // Les errades obtingudes també són en tant per cent, es calcula segons la formula: Errades = (Errades / (Encerts+Errades)*100, s'arrodoneix perquè doni un nombre enter amb la funció round().
      erradesActiv1 = round(((erradesActiv1/(encertsActiv1+erradesActiv1))*100));
    }
    // Si la puntuació màxima és menor que l'obtinguda, aleshores:
    if (maxPuntuacioACTIV1 < puntuacioACTIV1) {
      // S'actualitza la nova puntuació màxima a la puntuació actual obtinguda.
      maxPuntuacioACTIV1 = puntuacioACTIV1;
    } 

    // Guardem el temps utilitzat en fer l'activitat 1 en una variable.
    tempsACTIV1= int(timerACTIV1.getTimeSec()); 

    // Reiniciem el cronòmetre
    timerACTIV1.reset();
    timerACTIV1.start (false); 
    
    // Es guarda l'estat actual com anterior.
    mainStateAnterior = ACTIV1;  
    
    // Anem a l'estat FI D'ACTIVITTA
    mainState =  FIACTIV;    
    break;
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
      mainStateAnterior = ACTIV1;  // Es guarda l'estat actual com anterior.
      mainState =  RETORN;         // Anem a l'estat del Retorn
    }
  }
}
