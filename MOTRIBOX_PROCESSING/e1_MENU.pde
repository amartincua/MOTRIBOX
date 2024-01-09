/*
 *    FUNCIÓ DE L'ESTAT 1: MENÚ DE CINC OPCIONS
 */

void menu() { 
  // Es dibuixa una imatge de fons a partir de la funció image, tot indicant la posició en x i y.
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

  imageMode(CENTER);                     // Canvi d'ubicació des d'on es dibuixen les imatges, ara des de del centre.
  pushMatrix();                          // Funció que recorda l'últim sistema de coordenades.
  translate(width/2, 185);               // Translació en x i y de la imatge del logo.
  scale(0.5);                            // S'esclala la imatge del logo a la meitat.
  image (logo, 0, 0);                    // Es dibuixa la imatge del logo.
  popMatrix();                           // Funció que restableix el sistema de coordenades.

  pushMatrix();                          // Funció que recorda l'últim sistema de coordenades.
  translate(width/2, height-100);        // Translació en x i y de la imatge instruccions.
  image (instruccions, 0, 0);            // Es dibuixa la imatge de les instruccions.
  popMatrix();                           // Funció que restableix el sistema de coordenades.
  imageMode(CORNER);                     // Canvi d'ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra de la imatge, per no afectar la resta d'imatges.

  // INTRUCCIONS ÀUDIO
  // Si l'estat anterior és la introducció, és a dir que és el primer cop que s'accedeix al Menú, aleshores:
  if (mainStateAnterior == INTRO) {
    // Reproducció d'unes instruccions auditives.
    instrucMenu.play();     
    // En cas contrari:
  } else {
    // Es rebobina i posa en pausa les instruccions auditives.     
    instrucMenu.rewind(); 
    instrucMenu.pause();
  }

  //CONTROL DE MOVIMENTS ESQUERRA I DRET EN EL MENÚ A TRAVÉS DELS SENSORS ULTRASONS
  // En cas de tenir senyal en el sensor ultrasons esquerre o dret, aleshores:
  if (s0 > 0 || s2 > 0) {   

    // En cas de tenir senyal només en el sensor dret, aleshores:
    if (s2 > 0 && s0 == 0 && s1 == 0 && s3 == 0) {        
      // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
      timer0_7segons.start (true);
      // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer0_7segons.update(clock.getDeltaMillis());

      // Si els 0,7 segons ja han passat, aleshores:
      if (timer0_7segons.getFinish()) {                    

        // Control de la posició a on tenim l'opció seleccionada (no volem que es passi de l'última opció.
        // Si el valor de la variable botoActiuMENU és menor de 4, aleshores:  
        if (botoActiuMENU < 4) {
          // Augment d'un en un del "comptador" per saber el botó actiu.
          botoActiuMENU ++;
          // Es rebobina l'efecte de so perquè torni al principi.
          pop.rewind();
          // Reproducció de l'efecte de so.
          pop.play();
        }
        // Reinici del cronòmetre.
        timer0_7segons.reset();
      }
    }

    // En cas de tenir només senyal en el sensor esquerre, aleshores:
    if (s0 > 0 && s1 == 0 && s2 == 0 && s3 == 0) {        
      // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
      timer0_7segons.start (true); 
      // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer0_7segons.update(clock.getDeltaMillis());           

      // Si els 0,7 segons ja han passat, aleshores:
      if (timer0_7segons.getFinish()) {                         

        // Si el valor de la variable botoActiuMENU està entre 1 i 4, aleshores: 
        if (botoActiuMENU < 5 & botoActiuMENU > 0 ) {  
          // Disminució d'un en un del "comptador" per saber el botó actiu.
          botoActiuMENU --;   
          // Es rebobina l'efecte de so perquè torni al principi.
          pop.rewind();
          // Reproducció de l'efecte de so.
          pop.play();
        }
        // Reinici del cronòmetre.
        timer0_7segons.reset();
      }
    }
  }

  // CONTROL DE LA IMATGE DEL BOTÓ QUE S'HA DE MOSTRAR, A TRAVÉS DEL VALOR DEL COMPTADOR: botoActiuMENU, tot assignant el valor booleà de select a un determinat botó.
  // 0 --> boto1   1 --> boto2   2 --> boto3   3 --> boto4  4 --> boto5
  // En cas d'estar en el PRIMER botó del menú, aleshores:
  if (botoActiuMENU == 0) {
    boto1.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto1.
    boto1.select = true;        // La imatge del boto1 serà la imatge seleccionada.
    boto2.select = false;       // La imatge del boto2 serà la imatge NO seleccionada
    boto3.select = false;       // La imatge del boto3 serà la imatge NO seleccionada 
    boto4.select = false;       // La imatge del boto4 serà la imatge NO seleccionada
    boto5.select = false;       // La imatge del boto5 serà la imatge NO seleccionada

    // En cas d'estar en el SEGON botó del menú, aleshores:
  } else if (botoActiuMENU == 1) {
    boto2.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto2.
    boto1.select = false;       // La imatge del boto1 serà la imatge NO seleccionada
    boto2.select = true;        // La imatge del boto2 serà la imatge seleccionada
    boto3.select = false;       // La imatge del boto3 serà la imatge NO seleccionada
    boto4.select = false;       // La imatge del boto4 serà la imatge NO seleccionada
    boto5.select = false;       // La imatge del boto5 serà la imatge NO seleccionada
    // En cas d'estar en el TERCER botó del menú, aleshores:
  } else if (botoActiuMENU == 2) {
    boto3.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto3.
    boto1.select = false;       // La imatge del boto1 serà la imatge NO seleccionada
    boto2.select = false;       // La imatge del boto2 serà la imatge NO seleccionada
    boto3.select = true;        // La imatge del boto3 serà la imatge seleccionada
    boto4.select = false;       // La imatge del boto4 serà la imatge NO seleccionada
    boto5.select = false;       // La imatge del boto5 serà la imatge NO seleccionada
    // En cas d'estar en el QUART botó del menú, aleshores:
  } else if (botoActiuMENU == 3) {
    boto4.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto4.
    boto1.select = false;       // La imatge del boto1 serà la imatge NO seleccionada
    boto2.select = false;       // La imatge del boto2 serà la imatge NO seleccionada
    boto3.select = false;       // La imatge del boto3 serà la imatge NO seleccionada
    boto4.select = true;        // La imatge del boto4 serà la imatge seleccionada
    boto5.select = false;       // La imatge del boto5 serà la imatge NO seleccionada
  } else if (botoActiuMENU >= 4) {
    boto5.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto5.
    boto1.select = false;       // La imatge del boto1 serà la imatge NO seleccionada
    boto2.select = false;       // La imatge del boto2 serà la imatge NO seleccionada
    boto3.select = false;       // La imatge del boto3 serà la imatge NO seleccionada
    boto4.select = false;       // La imatge del boto4 serà la imatge NO seleccionada
    boto5.select = true;        // La imatge del boto5 serà la imatge seleccionada
  }

  // Es criden quatre mètodes de la classe Boto per dibuixar els cinc botons o opcions d'interacció.
  boto1.dibuix(); 
  boto2.dibuix(); 
  boto3.dibuix(); 
  boto4.dibuix(); 
  boto5.dibuix(); 

  // CONTROL DEL MOVIMENT D'ACCEPTAR UNA OPCIÓ AMB EL SENSOR D'ULTRASONS SUPERIOR, PER ANAR A L'ESTAT CORRESPONENT
  // En cas de tenir senyal només en el sensor superior (així no interfereix l'acció de tornar al menú des d'un altre estat), aleshores:
  if (s1 > 0 && s0 == 0 && s2 == 0 && s3 == 0) {
    // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
    timer0_7segons.start (true);
    // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
    timer0_7segons.update(clock.getDeltaMillis());

    // Si els 0,7 segons ja han passat, aleshores:
    if (timer0_7segons.getFinish()) {     
      // Rebobinen i posem en pausa les instruccions auditives, per aturar-les en cas que ja sapiguem com funciona, un cop hem seleccionat una opció.     
      instrucMenu.rewind(); 
      instrucMenu.pause();

      // Si el valor de la variable botoActiuMENU és 0 (estem en la primera opció del menú), aleshores: 
      if (botoActiuMENU == 0) {
        mainStateAnterior = MENU;  // Es guarda l'estat actual com anterior.
        mainState =  ACTIV1;      // Passem a l'estat de l'Activitat 1
      }

      // Si el valor de la variable botoActiuMENU és 1 (estem en la segona opció del menú), aleshores: 
      if (botoActiuMENU == 1) {
        mainStateAnterior = MENU;  // Es guarda l'estat actual com anterior.
        mainState =  ACTIV2;     // Passem a l'estat de l'Activitat 2
      }

      // Si el valor de la variable botoActiuMENU és 2 (estem en la tercera opció del menú), aleshores: 
      if (botoActiuMENU == 2) {
        mainStateAnterior = MENU;  // Es guarda l'estat actual com anterior.
        mainState =  INFO;       // Passem a l'estat d'INFORMES
      }

      // Si el valor de la variable botoActiuMENU és 3 (estem en la quarta opció del menú), aleshores: 
      if (botoActiuMENU == 3) {
        mainStateAnterior = MENU;  // Es guarda l'estat actual com anterior.
        mainState =  CONFIG;     // Passem a l'estat de Configuració
      }

      // Si el valor de la variable botoActiuMENU és 4 (estem en la cinquena opció del menú), aleshores: 
      if (botoActiuMENU == 4) {
        mainStateAnterior = MENU;  // Es guarda l'estat actual com anterior.
        mainState =  SORTIR;      // Passem a l'estat SORTIR
      } 

      select.rewind();           // Es rebobina l'efecte de so perquè torni al principi.
      select.play();             // Reproducció de l'efecte de so.
      timer0_7segons.reset();    // Reinici del cronòmetre.
    }
  }
}
