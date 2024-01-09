/*
 *    FUNCIÓ DE L'ESTAT 2: CONFIGURACIÓ. Ens permetrà seleccionar una sèrie de músiques o apagar-les.
 */

void config() {  
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

  imageMode(CENTER);                          // Canvi d'ubicació des d'on es dibuixen les imatges, ara des de del centre.
  image (panellConfig, width/2, height/2-80); // Es dibuixa la imatge del panell de configuració. 
  fill(255, 230, 160);                        // Color de farciment 
  textSize(50);                               // Mida del text
  text("CONFIGURACIÓ", width/2, 170);         // Dibuix d'un text

  pushMatrix();                               // Funció que recorda l'últim sistema de coordenades.
  translate(width/2, height-100);             // Translació en x i y de la imatge instruccions.
  image (instruccions, 0, 0);                 // Es dibuixa la imatge de les instruccions.
  popMatrix();                                // Funció que restableix el sistema de coordenades.
  imageMode(CORNER);                          // Canvi d'ubicació des d'on es dibuixen les imatges, ara des de la cantonada superior esquerra de la imatge, per no afectar la resta d'imatges.

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

        // Control de la posició a on tenim l'opció seleccionada (no volem que es passi de les 3 opcions cap a la dreta).
        // Si el valor de la variable botoActiuCONFIG és menor de 3, aleshores:  
        if (botoActiuCONFIG < 3) {                               
          botoActiuCONFIG = botoActiuCONFIG + 1;   // Augment d'un en un del "comptador" per saber el botó actiu.
          pop.rewind();                            // Es rebobina l'efecte de so perquè torni al principi.
          pop.play();                              // Reproducció de l'efecte de so.
        }
        timer0_7segons.reset();                    // Reinici del cronòmetre.
      }
    }

    // En cas de tenir senyal només en el sensor esquerre, aleshores:
    if (s0 > 0 && s1 == 0 && s2 == 0 && s3 == 0) {        
      // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
      timer0_7segons.start (true);
      // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
      timer0_7segons.update(clock.getDeltaMillis());
      // Si els 0,7 segons ja han passat, aleshores:
      if (timer0_7segons.getFinish()) {                         

        // Si el valor de la variable botoActiuCONFIG està entre 1 i 3, aleshores: 
        if (botoActiuCONFIG < 4 & botoActiuCONFIG > 0 ) {        
          botoActiuCONFIG = botoActiuCONFIG - 1; // Disminució d'un en un del "comptador" per saber el botó actiu.
          pop.rewind();                          // Es rebobina l'efecte de so perquè torni al principi.
          pop.play();                            // Reproducció de l'efecte de so.
        }
        timer0_7segons.reset();                  // Reinici del cronòmetre.
      }
    }
  }

  // CONTROL DE LA IMATGE DEL BOTÓ QUE S'HA DE MOSTRAR, A TRAVÉS DEL VALOR DEL COMPTADOR: botoActiuCONFIG, tot assignant el valor booleà de select a un determinat botó.
  // 0 --> boto1   1 --> boto2   2 --> boto3   3 --> boto4
  // En cas d'estar en el PRIMER botó del menú, aleshores:
  if (botoActiuCONFIG == 0) {
    boto1C.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto1C.
    boto1C.select = true;        // La imatge del boto1C serà la imatge seleccionada
    boto2C.select = false;       // La imatge del boto2C serà la imatge NO seleccionada
    boto3C.select = false;       // La imatge del boto3C serà la imatge NO seleccionada 
    boto4C.select = false;       // La imatge del boto4C serà la imatge NO seleccionada
    // En cas d'estar en el SEGON botó del menú, aleshores:
  } else if (botoActiuCONFIG == 1) {
    boto2C.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto2C.
    boto1C.select = false;       // La imatge del boto1C serà la imatge NO seleccionada
    boto2C.select = true;        // La imatge del boto2C serà la imatge seleccionada
    boto3C.select = false;       // La imatge del boto3C serà la imatge NO seleccionada
    boto4C.select = false;       // La imatge del boto4C serà la imatge NO seleccionada
    // En cas d'estar en el TERCER botó del menú, aleshores:
  } else if (botoActiuCONFIG == 2) {
    boto3C.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto3C.
    boto1C.select = false;       // La imatge del boto1C serà la imatge NO seleccionada
    boto2C.select = false;       // La imatge del boto2C serà la imatge NO seleccionada
    boto3C.select = true;        // La imatge del boto3C serà la imatge seleccionada
    boto4C.select = false;       // La imatge del boto4C serà la imatge NO seleccionada
    // En cas d'estar en el QUART botó del menú, aleshores:
  } else if (botoActiuCONFIG >= 3) {
    boto4C.animacioHover();      // Es crida el mètode per fer l'animació del hover del boto4C.
    boto1C.select = false;       // La imatge del boto1C serà la imatge NO seleccionada
    boto2C.select = false;       // La imatge del boto2C serà la imatge NO seleccionada
    boto3C.select = false;       // La imatge del boto3C serà la imatge NO seleccionada
    boto4C.select = true;        // La imatge del boto4C serà la imatge seleccionada
  }

  // Es criden quatre mètodes de la classe Boto per dibuixar les quatre opcions.
  boto1C.dibuix(); 
  boto2C.dibuix(); 
  boto3C.dibuix(); 
  boto4C.dibuix(); 
  
  // INFORMACIO TEXTUAL DE LES CANÇONS
  textSize(40);                                                // Mida del text
  fill(89, 23, 62);                                            // Color de farciment
  text("MÚSICA 1", 450, 400);                                  // Dibuix d'un text  
  text("MÚSICA 2", 850, 400);                                  // Dibuix d'un text  
  text("MÚSICA 3", 1250, 400);                                 // Dibuix d'un text
  textSize(20);                                                // Mida del text
  fill(0);                                                     // Color de farciment
  text("MOTRIBOX Game", 320, 360, 250, 200);                   // Dibuix d'un text
  text("Happy Background Music", 720, 360, 250, 200);          // Dibuix d'un text
  text("Santa Claus Is Coming To Town.", 1120, 360, 250, 200); // Dibuix d'un text

  // CONTROL DEL MOVIMENT D'ACCEPTAR UNA OPCIÓ AMB EL SENSOR D'ULTRASONS SUPERIOR, PER ANAR A L'ESTAT CORRESPONENT
  // En cas de tenir senyal només en el sensor superior (així no interfereix l'acció de tornar al menú des d'un altre estat), aleshores:
  if (s1 > 0 && s0 == 0 && s2 == 0 && s3 == 0) {
    // Cronòmetre de 0,7 segons en marxa perquè comenci a comptar.
    timer0_7segons.start (true);
    // Actualització del valor del cronòmetre amb la funció update, utilitzant com a paràmetre el temps que ha passat.
    timer0_7segons.update(clock.getDeltaMillis());

    // Si els 0,7 segons ja han passat, aleshores:
    if (timer0_7segons.getFinish()) {                         

      // Si el valor de la variable botoActiuCONFIG és 0 (estem en la primera opció del menú), aleshores: 
      if (botoActiuCONFIG == 0) {
        botoSeleccionatCONFIG = 0;     // La variable botoSeleccionatCONFIG guarda el mateix valor
      }

      // Si el valor de la variable botoActiuCONFIG és 1 (estem en la segona opció del menú), aleshores: 
      if (botoActiuCONFIG == 1) {
        botoSeleccionatCONFIG = 1;    // La variable botoSeleccionatCONFIG guarda el mateix valor
      }

      // Si el valor de la variable botoActiuCONFIG és 2 (estem en la tercera opció del menú), aleshores: 
      if (botoActiuCONFIG == 2) {
        botoSeleccionatCONFIG = 2;    // La variable botoSeleccionatCONFIG guarda el mateix valor
      }

      // Si el valor de la variable botoActiuCONFIG és 3 (estem en la quarta opció del menú), aleshores: 
      if (botoActiuCONFIG == 3) {
        botoSeleccionatCONFIG = 3;    // La variable botoSeleccionatCONFIG guarda el mateix valor
      } 

      select.rewind();           // Es rebobina l'efecte de so perquè torni al principi.
      select.play();             // Reproducció de l'efecte de so.
      timer0_7segons.reset();    // Reinici del cronòmetre.
    }
  }

  // Si el valor de la variable botoActiuCONFIG és 0 (estem en la primera opció del menú), aleshores: 
  if (botoSeleccionatCONFIG == 0) {
    boto1Cok.dibuix();       // Dibuix de la icona de la nota musical
    // Si la música que sona és diferent de la musica1, aleshores:
    if (musica!=musica1) {
      musica.pause();        // Posar en pausa la música
      musica.rewind();       // Rebobinar música
      musica = musica1;      // La música que ha de sonar serà la musica1
      musica.loop();         // Reproducció de la música indefinidament.
    }
  }

  // Si el valor de la variable botoActiuCONFIG és 1 (estem en la segona opció del menú), aleshores: 
  if (botoSeleccionatCONFIG == 1) {
    boto2Cok.dibuix();       // Dibuix de la icona de la nota musical
    // Si la música que sona és diferent de la musica2, aleshores:
    if (musica!=musica2) {
      musica.pause();        // Posar en pausa la música
      musica.rewind();       // Rebobinar música
      musica = musica2;      // La música que ha de sonar serà la musica2
      musica.loop();         // Reproducció de la música indefinidament.
    }
  }

  // Si el valor de la variable botoActiuCONFIG és 2 (estem en la tercera opció del menú), aleshores: 
  if (botoSeleccionatCONFIG == 2) {
    boto3Cok.dibuix();       // Dibuix de la icona de la nota musical
    // Si la música que sona és diferent de la musica3, aleshores:
    if (musica!=musica3) {
      musica.pause();        // Posar en pausa la música
      musica.rewind();       // Rebobinar música
      musica = musica3;      // La música que ha de sonar serà la musica2
      musica.loop();         // Reproducció de la música indefinidament.
    }
  }

  // Si el valor de la variable botoActiuCONFIG és 3 (estem en la quarta opció del menú), aleshores: 
  if (botoSeleccionatCONFIG == 3) {
    boto4Cok.dibuix();               // Dibuix de la icona de la nota musical tatxada.
    musica.pause();                  // Posar en pausa la música
    musica.rewind();                 // Rebobinar música
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
      retorn.rewind();             // Es rebobina l'efecte de so perquè torni al principi.
      retorn.play();               // Reproducció de l'efecte de so.
      timer0_7segons.reset();      // Reinici del cronòmetre.
      mainStateAnterior = CONFIG;  // Es guarda l'estat actual com anterior.
      mainState =  MENU;           // Anem a l'estat del Menú
    }
  }
}
